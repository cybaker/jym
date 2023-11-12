import 'package:Jym/domain/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock/wakelock.dart';

import '../domain/Workout.dart';
import 'ExerciseTile.dart';

class WorkoutPage extends StatefulWidget {
  final Map<String, List<String>> exercises;

  const WorkoutPage({super.key, required this.exercises});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final DateTime _pageLoadTime = DateTime.now();
  late DateTime _startTime = _pageLoadTime;
  late DateTime _endTime = _pageLoadTime;
  late List<Exercise> _exercises = [];
  late List<ExerciseTile> _tiles = [];

  @override
  void initState() {
    super.initState();
    _buildExercises();
    _buildTiles();
    Wakelock.enable();
  }

  void _buildExercises() {
    widget.exercises.forEach((key, value) => value.forEach((element) {
          _exercises.add(Exercise(muscleGroup: key, movement: element, sets: 0, repsPerSet: 10, notes: ""));
        }));
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  Widget userControls() {
    if (_startTime == _pageLoadTime) {
      return const Text("Drag to reorder. Start any exercise in any order.");
    }
    return Column(
      children: [
        Text("Start Time: ${DateFormat('dd MMM – kk:mm:ss').format(_startTime)}"),
        if (_endTime != _pageLoadTime) Text("End Time: ${DateFormat('kk:mm:ss').format(_endTime)}"),
      ],
    );
  }

  void exerciseStarted(bool started) {
    if (started && _startTime == _pageLoadTime) {
      _startTime = DateTime.now();
    } else {
      _endTime = DateTime.now();
    }
    setState(() {});
  }

  void _buildTiles() {
    _tiles = [
      for (final exercise in _exercises)
        ExerciseTile(
            key: ValueKey(exercise), movement: exercise.movement, started: exerciseStarted,
            notesAndSets: (notes, sets) {
              exercise.notes = notes;
              exercise.sets = int.parse(sets);
            }),
    ];
  }

  void _saveWorkout() async {
    var workout = Workout(startTime: _startTime.toIso8601String(), endTime: _endTime.toIso8601String(), exercises: _exercises);
    debugPrint(workout.toJson(workout).toString());
  }

  Widget tilesForExercises() {
    return ReorderableListView(
        children: _tiles,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
            final item = _exercises.removeAt(oldIndex);
            _exercises.insert(newIndex, item);
          });
        });
  }

  Widget closeCTA() {
    return ElevatedButton(
      onPressed: () {
        _saveWorkout();
        _exercises = [];
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
