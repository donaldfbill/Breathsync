import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:rhytham/services/shared_pref/shared_pref.dart';

class AudioService {
  AudioService(this._audioPlayer) : pref = Get.find<SharedPref>();

  final SharedPref pref;
  final AudioPlayer _audioPlayer;

  Future<void> playAudio(Uri? url) async {
    if (pref.getAudioStatus()) if (url != null) await _audioPlayer.play(DeviceFileSource(url.path));
  }

  Future<void> pauseAudio() async => await _audioPlayer.pause();

  Future<void> stopAudio() async => await _audioPlayer.stop();

  Future<void> setLoop() async => _audioPlayer.setReleaseMode(ReleaseMode.loop);

  Future<void> dispose() async => await _audioPlayer.dispose();
}
