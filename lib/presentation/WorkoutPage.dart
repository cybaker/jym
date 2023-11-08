import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock/wakelock.dart';

import 'ExerciseTile.dart';

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
  var exercises = [];

  @override
  void initState() {
    super.initState();
    widget.exercises.forEach((key, value) => value.forEach((element) {
          exercises.add('$element');
        }));
    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  Widget userControls() {
    if (startTime == pageLoadTime) {
      return const Text("Drag to reorder. Start any exercise in any order.");
    }
    return Column(
      children: [
        Text("Start Time: ${DateFormat('dd MMM – kk:mm:ss').format(startTime)}"),
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

  Widget closeCTA() {
    return ElevatedButton(
      onPressed: () {
        // TODO save results
        Navigator.pop(context);
      },
      child: const Text('I did it!', style: TextStyle(fontSize: 30),),
    );
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
              // TODO add circuit, interleave,, shuffle items
              userControls(),
              Flexible(flex: 1, child: tilesForExercises()),
              Container(height: 16),
              closeCTA(),
            ],
          ),
        ),
      ),
    );
  }
}
