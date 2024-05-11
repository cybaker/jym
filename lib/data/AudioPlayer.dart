import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Player {
  static final _clickSource = AssetSource('sounds/click.mp3');
  static final _startSource = AssetSource('sounds/start.mp3');

  static playClick() async {
    await AudioPlayer().stop();
    await AudioPlayer().play(_clickSource, mode: PlayerMode.lowLatency);
    debugPrint("Playing click sound");
  }

  static playStart() async {
    await AudioPlayer().stop();
    await AudioPlayer().play(_startSource, mode: PlayerMode.lowLatency);
    debugPrint("Playing start sound");
  }
}