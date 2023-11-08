import 'dart:async';

import 'package:flutter/material.dart';

class ExerciseTile extends StatefulWidget {
  final String movement;
  final Function(bool) started;
  final Function(String, String)? notesAndSets;

  const ExerciseTile({super.key, required this.movement, required this.started, this.notesAndSets});

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  int sets = 0;
  String notes = "";

  // Timer for a set
  Timer? timer;
  int secondsRemaining = 60;

  void _startSet() {
    secondsRemaining = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining <= 0 || !mounted) _stopSet();

      secondsRemaining--;
      setState(() {});
    });
    setState(() {});
    widget.started(true);
  }

  void _stopSet() {
    sets++;
    widget.notesAndSets?.call(notes, sets.toString());
    timer?.cancel();
    timer = null;
    setState(() {});
    widget.started(false);
  }

  void _onStartEnd() {
    if (timer?.isActive == true) {
      _stopSet();
    } else {
      _startSet();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var icon = (timer?.isActive == true) ? Icons.stop_circle : Icons.play_arrow;

    return ListTile(
      title: Text("${widget.movement}: "),
      subtitle: noteControl(),
      trailing: startStopControls(icon, context),
    );
  }

  Widget noteControl() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: TextField(
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration.collapsed(hintText: 'notes'),
        onChanged: (value) {
          widget.notesAndSets?.call(value, sets.toString());
          setState(() { notes = value; });
        },
      ),
    );
  }

  Widget startStopControls(IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (timer?.isActive == true)
            Text(secondsRemaining.toString(), style: Theme.of(context).textTheme.bodyMedium)
          else
            Text("$sets", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.orange)),
          Container(width: 8),
          IconButton(
            icon: Icon(
              icon,
              size: 34,
            ),
            onPressed: () {
              _onStartEnd();
            },
          ),
        ],
      ),
    );
  }
}
