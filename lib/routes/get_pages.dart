import 'package:get/get.dart';
import 'package:rhytham/routes/routes.dart';
import 'package:rhytham/screen/home_module/home_binding.dart';
import 'package:rhytham/screen/home_module/home_screen.dart';
import 'package:rhytham/screen/other/other_screen.dart';
import 'package:rhytham/screen/poem_module/poem_binding.dart';
import 'package:rhytham/screen/poem_module/poem_screen.dart';
import 'package:rhytham/screen/setting_module/setting_binding.dart';
import 'package:rhytham/screen/setting_module/setting_screen.dart';
import 'package:rhytham/screen/splash_module/splash_binding.dart';
import 'package:rhytham/screen/splash_module/splash_screen.dart';

List<GetPage> getPage = [
  GetPage(
    name: Routes.initialRoute,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Routes.homeRoute,
    page: () => const HomeScreen(),
    binding: HomeBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Routes.poemRoute,
    page: () => const PoemScreen(),
    binding: PoemBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Routes.otherRoute,
    page: () => const OtherScreen(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Routes.settingRoute,
    page: () => const SettingScreen(),
    binding: SettingBinding(),
    transition: Transition.fadeIn,
  ),
];
