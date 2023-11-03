import 'package:flutter/material.dart';
import 'package:flutter_jym/domain/MuscleGroupMovements.dart';

import 'domain/Exercise.dart';
import 'data/MovementGroups.dart';

import 'presentation/StringChipsWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Jym',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(),
      ),
      routes: {
        '/': (context) => const MyWidget(),
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> selectedMuscleGroups = [];

  Map<String, List<String>> selectedMuscleGroupMovements = {};

  late Map<String, Widget> muscleGroupWidgets;

  // List<Exercise> getExercises(String muscleGroup) {
  //   var movements = movementGroups[muscleGroup] ?? [];
  //   List<Exercise> exercises = [];
  //   for (var movement in movements) {
  //     exercises.add(Exercise(
  //       movement: movement,
  //       sets: 3,
  //       repsPerSet: 10,
  //     ));
  //   }
  //   return exercises;
  // }

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
          selectedStrings: const [],
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
    return ListView.builder(
      itemCount: selectedMuscleGroups.length,
      itemBuilder: (context, index) {
        var group = selectedMuscleGroups[index];
        return Column(
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
      },
    );
  }

  void startWorkout() {
    List<MuscleGroupMovements> muscleGroupMovements = [];
    for (var group in selectedMuscleGroups) {
      var movements = selectedMuscleGroupMovements[group] ?? [];
      List<Exercise> userExercises = [];
      for (var movement in movements) {
        debugPrint('movement: $movement');
        userExercises.add(Exercise(
          movement: movement,
          sets: 3,
          repsPerSet: 10,
        ));
      }
      muscleGroupMovements.add(MuscleGroupMovements(muscleGroup: group, exercises: userExercises));
    }
    for (var element in muscleGroupMovements) {
      print(element.toJson(element));
    }
  }

  Widget UserControls() {
    return Row(
      children: [
        // Button to generate user workout
        ElevatedButton(
          onPressed: () {
            startWorkout();
            // setState(() {});
          },
          child: const Text('Start'),
        ),

        // TODO add a randomizer to the workout?

        // TODO edit groups and exercises?
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    muscleGroupWidgets = getMuscleGroupWidgets();
    selectedMuscleGroupMovements.addAll(movementGroups);
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
              Flexible(flex: 10, child: MuscleGroupsWidget()),

              const Spacer(
                flex: 1,
              ),

              UserControls(),

              // // Button to generate user workout
              // ElevatedButton(
              //   onPressed: () {
              //     userWorkout = getAllExercisesWorkout(selectedMuscleGroups);
              //     setState(() {});
              //   },
              //   child: const Text('Generate Workout'),
              // ),

              Flexible(flex: 40, child: ExercisesFromSelectedMuscleGroupsWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

// // Timer
// Text(secondsRemaining.toString()),
//
// // Timer Button
// if (timer?.isActive == true)
//   // Button to stop timer
//   ElevatedButton(
//     onPressed: stopTimer,
//     child: Text('Stop Timer'),
//   )
// else
//   ElevatedButton(
//     onPressed: startTimer,
//     child: Text('Start Timer'),
//   ),

// // Timer the user can set for starting and stopping a set
// Timer? timer;
// int secondsRemaining = 60;
//
// void startTimer() {
//   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//     if (secondsRemaining <= 0) {
//       timer.cancel();
//       return;
//     }
//
//     secondsRemaining--;
//     setState(() {});
//   });
// }
//
// void stopTimer() {
//   timer?.cancel();
//   secondsRemaining = 60;
//   setState(() {});
// }
//
// // Save user exercises to local storage
// void saveUserExercises() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setStringList('Workout', userExercises.map((exercise) => jsonEncode(exercise)).toList());
// }
//
// // Save user exercises to local storage
// void saveWorkout() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('Workout', jsonEncode(userWorkout));
// }
//
// // Load user exercises from local storage
// void loadWorkout() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   String workout = prefs.getString('Workout') ?? "";
//   userWorkout = jsonDecode(workout);
// }
