import 'package:flutter/material.dart';

import '../data/MovementGroups.dart';
import 'StringChipsWidget.dart';
import 'WorkoutPage.dart';

class JymHomePage extends StatefulWidget {
  const JymHomePage({super.key});

  @override
  JymHomePageState createState() => JymHomePageState();
}

class JymHomePageState extends State<JymHomePage> {
  List<String> selectedMuscleGroups = [];

  Map<String, List<String>> selectedMuscleGroupMovements = {};

  late Map<String, Widget> muscleGroupWidgets;

  Map<String, Widget> getMuscleGroupWidgets() {
    Map<String, Widget> widgets = {};
    for (var group in movementGroups.keys) {
      widgets[group] = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(group),
              const SizedBox(width: 40),
              ElevatedButton(
                onPressed: () {
                  var stringList = movementGroups[group];
                  stringList!.shuffle();
                  var pickList = stringList.sublist(0, 4);
                  setState(() {
                    selectedMuscleGroupMovements[group] = pickList;
                  });
                },
                child: const Text('Pick 4', style: TextStyle(fontSize: 16, color: Colors.white70),),
              ),
            ]
          ),
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

  Widget muscleGroupsWidget() {
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
          fontSize: 20,
        ),
      ],
    );
  }

  Widget exercisesFromSelectedMuscleGroupsWidget() {
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

  Widget userControls() {
    if (selectedMuscleGroups.isEmpty) return Container();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Button to generate user workout
        ElevatedButton(
          onPressed: () {
            startWorkout();
          },
          child: const Text('Start my workout', style: TextStyle(fontSize: 30),),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    selectedMuscleGroupMovements.addAll(movementGroups);
  }

  @override
  Widget build(BuildContext context) {
    muscleGroupWidgets = getMuscleGroupWidgets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Workout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              muscleGroupsWidget(),
              const Divider(height: 30, thickness: 4,),
              Container(height: 16),
              Flexible(flex: 1, child: exercisesFromSelectedMuscleGroupsWidget()),
              Container(height: 16),
              userControls(),
            ],
          ),
        ),
      ),
    );
  }
}
