import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhytham/screen/home_module/home_controller.dart';
import 'package:rhytham/services/shared_pref/shared_pref.dart';
import 'package:rhytham/utils/assets.dart';

class VoiceButton extends GetView<HomeController> {
  const VoiceButton({super.key});

  Future<void> changeAudio(void Function() onComplete) async {
    final SharedPref pref = Get.find<SharedPref>();
    bool value = pref.getAudioStatus();
    await pref.setAudioStatus(!value);
    if (!value) {
      controller.audioSound();
      controller.register();
    } else {
      controller.muteSound();
      controller.cancelVibration();
    }
    onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return IconButton(
          onPressed: () => changeAudio(() => setState(() {})),
          icon: SizedBox(
            height: 45,
            width: 45,
            child: Get.find<SharedPref>().getAudioStatus() ? Image.asset(Assets.sound) : Image.asset(Assets.mute),
          ),
        );
      },
    );
  }
}
