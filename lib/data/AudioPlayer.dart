import 'package:audioplayers/audioplayers.dart';

class Player {
  static playClick() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/click.mp3'));
  }

  static playStart() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/start.mp3'));
  }
}