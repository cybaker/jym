import 'package:audioplayers/audioplayers.dart';

class Player {
  static var _player = AudioPlayer();

  static playClick() async {
    await _player.play(AssetSource('sounds/click.mp3'));
  }

  static playStart() async {
    await _player.play(AssetSource('sounds/start.mp3'));
  }
}