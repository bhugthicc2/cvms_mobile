import 'package:audioplayers/audioplayers.dart';

class SoundHelper {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playSuccess() async {
    await _player.play(AssetSource('sounds/success.mp3'));
  }

  static Future<void> playError() async {
    await _player.play(AssetSource('sounds/failure.mp3'));
  }

  static Future<void> playWarning() async {
    await _player.play(AssetSource('sounds/warning.mp3'));
  }
}
