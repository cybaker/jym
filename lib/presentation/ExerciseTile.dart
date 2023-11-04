

import 'dart:async';

import 'package:flutter/material.dart';

class ExerciseTile extends StatefulWidget {
  final String movement;
  final String muscleGroup;

  const ExerciseTile({super.key, required this.movement, required this.muscleGroup});

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {

  @override
  void initState() {
    super.initState();
  }

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
      if (!this.mounted) {
        timer.cancel();
        return;
      }
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

  void _onStartEnd() {
    if (timer?.isActive == true) {
      stopSet();
    } else {
      startSet();
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = (timer?.isActive == true) ? Icons.stop_circle : Icons.play_arrow;

    return ListTile(
      title: Text(widget.movement),
      subtitle: Text(widget.muscleGroup),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {
              _onStartEnd();
            },
          ),
          if (timer?.isActive == true)
            Text(secondsRemaining.toString(), style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
