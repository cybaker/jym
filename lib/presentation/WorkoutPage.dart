import 'dart:async';

import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  final Map<String, List<String>> exercises;

  const WorkoutPage({super.key, required this.exercises});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // Timer the user can set for starting and stopping a set
  Timer? timer;
  int secondsRemaining = 60;

  void startSet() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining <= 0) {
        timer.cancel();
        return;
      }

      secondsRemaining--;
      setState(() {});
    });
    setState(() {});
  }

  void stopSet() {
    timer?.cancel();
    timer = null;
    secondsRemaining = 60;
    setState(() {});
  }

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

  void startWorkout() {
    // TODO
  }

  Widget UserControls() {
    return Row(
      children: [

        // Timer Button
        if (timer?.isActive == true)
          // Button to stop timer
          ElevatedButton(
            onPressed: stopSet,
            child: Text('Stop Set'),
          )
        else
          ElevatedButton(
            onPressed: startSet,
            child: Text('Start Set'),
          ),

        // Timer Seconds
        if (timer?.isActive == true)
          Text(secondsRemaining.toString()),
        
        // TODO add a randomizer to the workout?

        // TODO edit groups and exercises?
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // TODO
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
              UserControls(),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
