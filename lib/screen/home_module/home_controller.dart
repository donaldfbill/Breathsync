import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rhytham/ntp/ntp.dart';
import 'package:rhytham/services/audio_service/audio_service.dart';
import 'package:rhytham/services/shared_pref/shared_pref.dart';
import 'package:rhytham/services/user_preseance/user_preasence.dart';
import 'package:rhytham/utils/assets.dart';
import 'package:rhytham/utils/gps_location_time.dart';
import 'package:rhytham/widget/location_enable_sheet.dart';
import 'package:rhytham/widget/location_required_sheet.dart';
import 'package:rhytham/widget/no_internet_warning_sheet.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vibration/vibration.dart';

class HomeController extends GetxController {
  HomeController()
      : worldPeace = Get.put(WorldPeace()),
        userPresenceService = Get.find<UserPresenceService>();

  final WorldPeace worldPeace;
  final UserPresenceService userPresenceService;

  late final AudioService _audioService;
  late final AudioService _musicService;
  Map<String, Uri> loadedFiles = AudioCache.instance.loadedFiles;

  final _backGroundAudioService = AudioService(AudioPlayer(playerId: 'BACKGROUND'));

  final BehaviorSubject<int> _streamSecond = BehaviorSubject<int>();
  final BehaviorSubject<String> _streamMessage = BehaviorSubject<String>();
  final ValueNotifier<int?> animationSeek = ValueNotifier(null);
  final ValueNotifier<TextStyle> textStyle = ValueNotifier<TextStyle>(
    const TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.w700,
      color: Color(0XFF3A304E),
    ),
  );

  Stream<int> get secondStream => _streamSecond.stream;

  Stream<String> get messageStreams => _streamMessage.stream;

  var sound = Play.backGroundMusic1.obs;

  String formatNumber(int number) {
    if (number < 10) {
      return '0${number.toString()}';
    } else {
      return number.toString();
    }
  }

  @override
  void onInit() {
    _audioService = AudioService(AudioPlayer(playerId: 'TONES'));
    _musicService = AudioService(AudioPlayer(playerId: 'MUSIC'));
    saveUserIdIfNot();
    setOnlineStatus();
    register();
    audioSound();
    listenForInternetStateChanges();
    super.onInit();
  }

  @override
  void dispose() async {
    super.dispose();
    worldPeace.cancel();
    _streamSecond.close();
    _streamMessage.close();
    animationSeek.dispose();
    textStyle.dispose();
    await muteSound();
    await _musicService.dispose();
    await _audioService.dispose();
  }

  void audioSound() {
    _musicService.playAudio(loadedFiles[sound.value]);
    _musicService.setLoop();
  }

  Future<void> stopSound() async {
    await _musicService.stopAudio();
  }

  Future<void> muteSound() async {
    List<Future> futures = <Future>[];
    futures.add(_musicService.pauseAudio());
    futures.add(_audioService.pauseAudio());
    await Future.wait(futures);
  }

  void cancelTimer() async {
    worldPeace.cancel();
    animationSeek.value = null;
    _streamSecond.add(0);
    await muteSound();
  }

  void listenForInternetStateChanges() {
    if (Platform.isIOS) return;
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        if (Get.isBottomSheetOpen ?? false) return;
        Get.bottomSheet(const NoInternetWarning(), enableDrag: false, isDismissible: false);
      } else {
        if (Get.isBottomSheetOpen ?? false) Get.back();
      }
    });
  }

  void saveUserIdIfNot() {
    final SharedPref pref = Get.find<SharedPref>();
    pref.setUniqueId();
  }

  void setOnlineStatus() async {
    final SharedPref pref = Get.find<SharedPref>();
    Connectivity connectivity = Connectivity();
    String? userId = pref.getUniQueId();
    if (userId == null) return;
    userPresenceService.updateUserPresence(userId, true);
    connectivity.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) userPresenceService.updateUserPresence(userId, true);
    });
  }

  void resume() => register();

  void register() {
    worldPeace.register(
      onInhaleSound: (second) => {startVibration()},
      // onHoldSound: (second) => {cancelVibration(), _audioService.playAudio(loadedFiles[Play.hold])},
      onHoldSound: (second) {},
      // onExhaleSound: (second) => _audioService.playAudio(loadedFiles[Play.exhale]),
      onExhaleSound: (second) => {startVibrationExHale()},
      // onBeepSound: (second) => _audioService.playAudio(loadedFiles[Play.beep]),
      onBeepSound: (second) {},
      onTickSound: (second) {
        animationSeek.value ??= second;
        _audioService.playAudio(loadedFiles[Play.tick]);
      },
      onSecondChange: (second) {
        _streamSecond.add(second);
        changeStyle(second);
        String? message = getMessageBasedOnSecond(second);
        if (message != '...') _streamMessage.add(message);
      },
    );
  }

  int getTimeUI(int second) {
    print("getTimeUI ==> $second");
    if (second >= 1 && second <= 4) {
      return second;
    }
    /*else if (second >= 5 && second <= 6) {
      return second;
    }*/
    else if (second >= 5 && second <= 12) {
      return second;
    } else if (second >= 13 && second <= 16) {
      return (second - 12);
    }
    /*else if (second >= 17 && second <= 18) {
      return second - 16;
    }*/
    else if (second >= 17 && second <= 24) {
      return (second - 12);
    } else if (second >= 25 && second <= 28) {
      return (second - 24);
    }
    /*else if (second >= 29 && second <= 30) {
      return second - 28;
    }*/
    else if (second >= 29 && second <= 36) {
      return (second - 24);
    } else if (second >= 37 && second <= 40) {
      return (second - 36);
    }
    /*else if (second >= 41 && second <= 42) {
      return second - 40;
    }*/
    else if (second >= 41 && second <= 48) {
      return (second - 36);
    } else if (second >= 49 && second <= 52) {
      return (second - 48);
    }
    /*else if (second >= 53 && second <= 54) {
      return second - 52;
    }*/
    else if (second >= 53 && second <= 60) {
      return (second - 48);
    } else {
      return 12;
    }
  }

  void changeStyle(int second) {
    if ([1, 2, 3, 4, 13, 14, 15, 16, 25, 26, 27, 28, 37, 38, 39, 40, 49, 50, 51, 52].contains(second)) {
      textStyle.value = textStyle.value.copyWith(color: const Color(0XFF7BD96C));
    }
    // if ([5, 6, 17, 18, 29, 30, 41, 42, 53, 54].contains(second)) textStyle.value = textStyle.value.copyWith(color: const Color(0XFFC3C3C3));
    if ([
      5,
      6,
      17,
      18,
      29,
      30,
      41,
      42,
      53,
      54,
      7,
      8,
      9,
      10,
      11,
      12,
      19,
      20,
      21,
      22,
      23,
      24,
      31,
      32,
      33,
      34,
      35,
      36,
      43,
      44,
      45,
      46,
      47,
      48,
      55,
      56,
      57,
      58,
      59,
      60
    ].contains(second)) {
      textStyle.value = textStyle.value.copyWith(color: const Color(0XFFBDB7E4));
    }
  }

  String getMessageBasedOnSecond(int second) {
    if (second == 0) return 'BEEP';
    if ([1, 13, 25, 37, 49].contains(second)) return 'INHALE';
    // if ([5, 17, 29, 41, 53].contains(second)) return 'HOLD';
    if ([7, 19, 31, 43, 55, 5, 17, 29, 41, 53].contains(second)) return 'EXHALE';
    return '...';
  }

  Future<void> startVibration() async {
    cancelVibration();
    final hasVibrator = await Vibration.hasVibrator();
    if (Platform.isIOS) {
      if (hasVibrator == true) {
        for (int i = 0; i < 1; i++) {
          Vibration.vibrate();
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    } else {
      if (hasVibrator == true) await Vibration.vibrate(duration: 100);
    }
  }

  Future<void> startVibrationExHale() async {
    cancelVibration();
    final hasVibrator = await Vibration.hasVibrator();
    if (Platform.isIOS) {
      if (hasVibrator == true) {
        for (int i = 0; i < 1; i++) {
          Vibration.vibrate();
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    } else {
      if (hasVibrator == true) await Vibration.vibrate(duration: 500);
    }
  }

  Future<void> cancelVibration() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) await Vibration.cancel();
  }
}

class WorldPeace extends GetxService {
  Timer? _timer;

  void cancel() {
    second = 0;
    _timer?.cancel();
  }

  int second = 0;

  void register({
    required void Function(int second) onBeepSound,
    required void Function(int second) onInhaleSound,
    required void Function(int second) onHoldSound,
    required void Function(int second) onExhaleSound,
    required void Function(int second) onTickSound,
    required void Function(int second) onSecondChange,
  }) async {
    if (_timer?.isActive ?? false) cancel();
    await _getUtcTime();
    final start = await _getUtcTime();
    await Future.delayed(Duration(microseconds: 999 - start.microsecond, milliseconds: 999 - start.millisecond));
    second = start.second + 1;
    if (second == 60 || second > 60) second = 0;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        second++;
        if (second == 60 || second > 60) second = 0;

        ///final inner = await _getUtcTime();
        _getCallBacks(
          ///inner.second,
          second,
          onBeepSound: (second) => onBeepSound(second),
          onExhaleSound: (second) => onExhaleSound(second),
          // onHoldSound: (second) => onHoldSound(second),
          onHoldSound: (second) => null,
          onInhaleSound: (second) => onInhaleSound(second),
          onTickSound: (second) => onTickSound(second),
          onSecondChange: (second) => onSecondChange(second),
        );
      },
    );
  }

  Future<DateTime> _getUtcTime() async {
    Completer<DateTime> completer = Completer<DateTime>();

    try {
      // Start a custom timer using Stopwatch
      Stopwatch stopwatch = Stopwatch()..start();

      // Request current GPS time
      // DateTime gpsTime = await GpsTime.time();
      DateTime gpsTime = await NTP.now();

      // Stop the timer
      stopwatch.stop();

      // Calculate the time difference between GPS time and received timestamp
      Duration elapsedTime = stopwatch.elapsed;
      // Adjust the received timestamp by adding the calculated time difference
      DateTime adjustedTime = gpsTime.add(elapsedTime);

      completer.complete(adjustedTime);
    } catch (error) {
      completer.completeError(error);

      // Handle specific errors with bottom sheets
      if (error is GpsException) {
        openSettingAppSheetFn();
      } else if (error is LocationServiceDisabledException) {
        openLocationAppSheetFn();
      }
    }

    return completer.future;
  }

  void openSettingAppSheetFn() async {
    await showModalBottomSheet(
      context: navigator!.context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false,
      builder: (context) => const OpenSettingAppSheet(),
    );
  }

  void openLocationAppSheetFn() async {
    await showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false,
      context: navigator!.context,
      builder: (context) => const OpenLocationPermissionSheet(),
    );
  }

  void _getCallBacks(
    int second, {
    required void Function(int second) onBeepSound,
    required void Function(int second) onInhaleSound,
    required void Function(int second) onHoldSound,
    required void Function(int second) onExhaleSound,
    required void Function(int second) onTickSound,
    required void Function(int second) onSecondChange,
  }) {
    onSecondChange(second);
    if (second == 0) onBeepSound(second);
    if ([1, 13, 25, 37, 49].contains(second)) onInhaleSound(second);
    // if ([5, 17, 29, 41, 53].contains(second)) onHoldSound(second);
    if ([5, 17, 29, 41, 53].contains(second)) onExhaleSound(second);
    if (![1, 13, 25, 37, 49, 5, 17, 29, 41, 53, 7, 19, 31, 43, 55].contains(second)) onTickSound(second);
  }
}
