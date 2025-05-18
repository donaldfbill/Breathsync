import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhytham/routes/routes.dart';
import 'package:rhytham/screen/home_module/home_controller.dart';
import 'package:rhytham/utils/assets.dart';
import 'package:rhytham/widget/video_player.dart';
import 'package:rhytham/widget/voice_on_off_button.dart';
import 'package:rhytham/widget/wrapper_background.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperBackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          centerTitle: false,
          title: const Text(
            'Breathsync',
            style: TextStyle(
              fontFamily: FontFamily.edward,
              fontWeight: FontWeight.w400,
              color: Color(0XFF463B8C),
              fontSize: 45.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.settingRoute),
              icon: Image.asset(Assets.iconSetting),
            ),
            IconButton(
              onPressed: () => Get.toNamed(Routes.poemRoute),
              icon: Image.asset(Assets.poemICO),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: const Text(
                      'Breathe in tantric synchrony with all humanity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF3A304E),
                        letterSpacing: 1.2,
                        fontFamily: 'Gabriola',
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.animationSeek,
                    builder: (context, value, child) {
                      if (value != null) {
                        return VideoPlayerView(
                          startFrom: Duration(seconds: value),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  StreamBuilder(
                    stream: controller.secondStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) return const SizedBox.shrink();
                      return ValueListenableBuilder(
                        valueListenable: controller.textStyle,
                        builder: (context, value, child) => Text(
                          controller.getTimeUI(snapshot.data ?? 0).toString(),
                          style: value,
                        ),
                      );
                    },
                  ),
                ],
              ).paddingOnly(
                top: 10.0,
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Share.share(
                        r"invite you to discover inner peace and mindfulness with our new app, "
                        r"BreathSynch App, now available on ios App Store and Google Play store."
                        ' Android :- https://play.google.com/store/apps/details?id=com.app.breathsync&hl=en \n'
                        ' IOS :- https://apps.apple.com/us/app/instagram/id389801252',
                        subject: '🌿 Find Your Calm: Download Our Meditation App Today! ');
                  },
                  icon: SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(Assets.iconShare),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25.0),
                    alignment: Alignment.bottomCenter,
                    child: StreamBuilder(
                      stream: controller.userPresenceService.getActiveUserCount(),
                      builder: (context, snapshot) {
                        return Text(
                          "${snapshot.data ?? 0} active users",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF39792F),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const VoiceButton(),
              ],
            ),
          ),
        ),
        // floatingActionButton: Row(
        //   children: [
        //
        //     Spacer(),
        //     const VoiceButton()
        //   ],
        // ),
      ),
    );
  }
}
