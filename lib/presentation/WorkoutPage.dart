import 'package:flutter/material.dart';
import 'package:flutter_jym/presentation/ExerciseTile.dart';

class WorkoutPage extends StatefulWidget {
  final Map<String, List<String>> exercises;

  const WorkoutPage({super.key, required this.exercises});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

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
    // TODO
  }

  Widget tilesForExercises() {
    var exercises = [];
    widget.exercises.forEach((key, value) => value.forEach((element) {exercises.add(element);}));
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseTile(movement: "Name", muscleGroup: exercises[index].toString());
      },
    );
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
            children: [
              Flexible(child: tilesForExercises()),
            ],
          ),
          ),
        ),
      );
  }
}
