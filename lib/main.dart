import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:need_resume/need_resume.dart';
import 'package:rhytham/firebase_options.dart';
import 'package:rhytham/routes/get_pages.dart';
import 'package:rhytham/routes/global_binding.dart';
import 'package:rhytham/routes/routes.dart';
import 'package:rhytham/screen/home_module/home_controller.dart';
import 'package:rhytham/services/get_service/get_service.dart';
import 'package:rhytham/services/user_preseance/user_preasence.dart';
import 'package:rhytham/utils/app_life_cycle_listner.dart';
import 'package:rhytham/utils/assets.dart';
import 'package:rhytham/utils/extension.dart';
import 'package:rhytham/utils/local_notification_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

///import 'package:rhytham/services/firebase/firebase_push_helper.dart';

GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

Future<void> initializing() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  WakelockPlus.enable();
  getService();

  // / final notification = FirebasePushHelper.instance;
  // / notification.initPushConfiguration((value) {});
  await AudioCache.instance.loadAll(Assets.cacheAudio);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializing();
  LocalNotificationController.initializeNotifications();
  LocalNotificationController.scheduleDailyNotification();
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends ResumableState<Application> {
  @override
  void onReady() {}

  @override
  void onResume() {
    // Get.find<UserPresenceService>().updateTimeSpent();
  }

  @override
  void onPause() {}

  @override
  Widget build(BuildContext context) {
    return AppLifecycle(
      onResume: () async {
        if (Platform.isIOS) {
          // await AudioCache.instance.loadAll(Assets.cacheAudio);
          // bool isPuttedWorldPeace = Get.isRegistered<WorldPeace>();
          // if (isPuttedWorldPeace) Get.delete<WorldPeace>();
          bool isPutted = Get.isRegistered<HomeController>();
          if (isPutted) Get.find<HomeController>().dispose();
          if (isPutted) await Get.find<HomeController>().muteSound();
          Get.offAllNamed(Routes.initialRoute);
        }
      },
      onPause: () {
        if (Platform.isIOS) {
          Get.find<UserPresenceService>().offLineUserPresence();

          /// bool isPuttedWorldPeace = Get.isRegistered<WorldPeace>();
          /// if (isPuttedWorldPeace) Get.delete<WorldPeace>();
          bool isPutted = Get.isRegistered<HomeController>();
          if (isPutted) Get.find<HomeController>().dispose();
          if (isPutted) Get.find<HomeController>().muteSound();
          Get.offAllNamed(Routes.otherRoute);
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator,
        initialBinding: GlobalScreenBindings(),
        theme: ThemeData(
          fontFamily: FontFamily.epilogue,
        ),
        onGenerateTitle: (context) => context.localization.title,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        getPages: getPage,
      ),
    );
  }
}
