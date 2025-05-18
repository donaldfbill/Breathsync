import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPref extends GetxService {
  late SharedPreferences preferences;

  Future<SharedPref> init() async {
    preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setAudioStatus(bool value) async => await preferences.setBool('AUDIO', value);

  bool getAudioStatus() => preferences.getBool('AUDIO') ?? true;

  Future<void> setUniqueId() async {
    if (getUniQueId() == null) {
      Uuid uuid = const Uuid();
      await preferences.setString('UNIQUE', uuid.v4());
    }
  }

  String? getUniQueId() => preferences.getString('UNIQUE');
}
