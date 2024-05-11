import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/material.dart';

class AudioPlayer {
  static const _clickSource = 'sounds/click.mp3';
  static const _startSource = 'sounds/start.mp3';

  static int clickSound = 0;
  static int startSound = 0;

  static final Soundpool _pool = Soundpool.fromOptions(options: const SoundpoolOptions());

  static playClick() async {
    await _initPool();
    _pool.play(clickSound);
    debugPrint("Playing click sound");
  }

  static void playStart() async {
    await _initPool();
    _pool.play(startSound);
    debugPrint("Playing start sound");
  }

  static _initPool() async {
    if (clickSound == 0) {
      clickSound = await _loadSound(_clickSource);
      startSound = await _loadSound(_startSource);
    }
  }

  static Future<int> _loadSound(String soundFile) async {
    var asset = await rootBundle.load(soundFile);
    return await _pool.load(asset);
  }
}