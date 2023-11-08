import 'package:flutter/material.dart';

import '../data/MovementGroups.dart';
import 'StringChipsWidget.dart';
import 'WorkoutPage.dart';

class JymHomePage extends StatefulWidget {
  const JymHomePage({super.key});

  @override
  _JymHomePageState createState() => _JymHomePageState();
}

class _JymHomePageState extends State<JymHomePage> {
  List<String> selectedMuscleGroups = [];

  Map<String, List<String>> selectedMuscleGroupMovements = {};

  late Map<String, Widget> muscleGroupWidgets;

  Map<String, Widget> getMuscleGroupWidgets() {
    Map<String, Widget> widgets = {};
    for (var group in movementGroups.keys) {
      widgets[group] = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group),
          StringChipsWidget(
            strings: movementGroups[group] ?? [],
            selectedStrings: selectedMuscleGroupMovements[group] ?? [],
            onSelectionChanged: (List<String> strings) {
              setState(() {
                selectedMuscleGroupMovements[group] = strings;
              });
            },
          ),
        ],
      );
    }
    return widgets;
  }

  Widget MuscleGroupsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select from these muscle groups first:'),
        StringChipsWidget(
          strings: movementGroups.keys.toList(),
          selectedStrings: selectedMuscleGroups,
          onSelectionChanged: (List<String> selectedStrings) {
            setState(() {
              selectedMuscleGroups = selectedStrings;
            });
          },
        ),
      ],
    );
  }

  Widget ExercisesFromSelectedMuscleGroupsWidget() {
    return ListView.separated(
      itemCount: selectedMuscleGroups.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (context, index) {
        var group = selectedMuscleGroups[index];
        return muscleGroupWidgets[group] ?? Container();
      },
    );
  }

  void startWorkout() {
    Map<String, List<String>> selectedMuscleGroupExercises = {};
    for (var group in selectedMuscleGroups) {
      selectedMuscleGroupExercises[group] = selectedMuscleGroupMovements[group] ?? [];
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutPage(exercises: selectedMuscleGroupExercises),
      ),
    );
  }

  Widget UserControls() {
    if (selectedMuscleGroups.isEmpty) return Container();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Button to generate user workout
        ElevatedButton(
          onPressed: () {
            startWorkout();
            // setState(() {});
          },
          child: const Text('Start my workout', style: TextStyle(fontSize: 30),),
        ),
        // Container(width: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     // setState(() {});
        //   },
        //   child: const Text('Random', style: TextStyle(fontSize: 30),),
        // ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    selectedMuscleGroupMovements.addAll(movementGroups);
    muscleGroupWidgets = getMuscleGroupWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MuscleGroupsWidget(),
              Container(height: 16),
              Flexible(flex: 1, child: ExercisesFromSelectedMuscleGroupsWidget()),
              Container(height: 16),
              UserControls(),
            ],
          ),
        ),
      ),
    );
  }
}
