import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rhytham/routes/routes.dart';
//import 'package:rhytham/utils/gps_location_time.dart';
import 'package:rhytham/widget/location_enable_sheet.dart';
import 'package:rhytham/widget/location_required_sheet.dart';
import 'package:rhytham/widget/no_internet_widget.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  void navigate() {
    Connectivity connectivity = Connectivity();
    connectivity.checkConnectivity().then((value) {
      if (value != ConnectivityResult.none) {
        Timer(const Duration(seconds: 2), () {
          Get.offNamed(Routes.homeRoute);
        });
      } else {
        noInternetSheet();
      }
    });

    // GpsTime.time().then((value) {
    //     return Get.offNamed(Routes.homeRoute);
    //   }).catchError(
    //     (err, s) async {
    //       if (err is LocationServiceDisabledException) openLocationAppSheetFn();
    //       if (err is GpsException) openSettingAppSheetFn();
    //       return null;
    //     },
    //   );
  }

  void noInternetSheet() async {
    await showModalBottomSheet(
      context: navigator!.context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false,
      builder: (context) => const NoInternetSheet(),
    );
    navigate();
  }

  void openSettingAppSheetFn() async {
    await showModalBottomSheet(
      context: navigator!.context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false,
      builder: (context) => const OpenSettingAppSheet(),
    );
    navigate();
  }

  void openLocationAppSheetFn() async {
    await showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: false,
      context: navigator!.context,
      builder: (context) => const OpenLocationPermissionSheet(),
    );
    navigate();
  }
}
