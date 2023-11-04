import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_jym/presentation/ExerciseTile.dart';

class WorkoutPage extends StatefulWidget {
  final Map<String, List<String>> exercises;

  const WorkoutPage({super.key, required this.exercises});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  DateTime pageLoadTime = DateTime.now();
  late DateTime startTime = pageLoadTime;
  late DateTime endTime = pageLoadTime;

  @override
  void initState() {
    super.initState();
    widget.exercises.forEach((key, value) => value.forEach((element) {
          exercises.add('$element ($key)');
        }));
  }

  Widget startAndEndTimes() {
    if (startTime == pageLoadTime) {
      return const Text("Reorder then start any exercise.");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Start Time: ${DateFormat('MMM-dd – kk:mm:ss').format(startTime)}"),
        if (endTime != pageLoadTime) Text("End Time: ${DateFormat('kk:mm:ss').format(endTime)}"),
      ],
    );
  }

  void exerciseStarted(bool started) {
    if (started && startTime == pageLoadTime) {
      startTime = DateTime.now();
    } else {
      endTime = DateTime.now();
    }
    setState(() {});
  }

  var exercises = [];

  Widget tilesForExercises() {
    return ReorderableListView(
        children: [
          for (final items in exercises)
            ExerciseTile(
                key: ValueKey(items), movement: items, started: exerciseStarted),
        ],
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
            final item = exercises.removeAt(oldIndex);
            exercises.insert(newIndex, item);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Workout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // TODO add interleave, randomize items
              startAndEndTimes(),
              Flexible(child: tilesForExercises()),
            ],
          ),
        ),
      ),
    );
  }
}
