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

// // Save user exercises to local storage
//   void saveUserExercises() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('Workout', userExercises.map((exercise) => jsonEncode(exercise)).toList());
//   }
//
// // Save user exercises to local storage
//   void saveWorkout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('Workout', jsonEncode(userWorkout));
//   }
//
// // Load user exercises from local storage
//   void loadWorkout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String workout = prefs.getString('Workout') ?? "";
//     userWorkout = jsonDecode(workout);
//   }

  @override
  void initState() {
    super.initState();
    widget.exercises.forEach((key, value) => value.forEach((element) {
          exercises.add(element);
        }));
  }

  Widget startAndEndTimes() {
    if (startTime == pageLoadTime) {
      return Text("Start any exercise.");
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
                key: ValueKey(items), movement: items, muscleGroup: items.toString(), started: exerciseStarted),
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
