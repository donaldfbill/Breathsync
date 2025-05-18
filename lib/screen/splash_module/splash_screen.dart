import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhytham/screen/splash_module/splash_controller.dart';
import 'package:rhytham/utils/assets.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFFFFFFFF),
                  Color(0XFFDCCCFF),
                ],
              ),
            ),
          ),
          const Center(
            child: Text(
              'Breathsync',
              style: TextStyle(
                fontFamily: FontFamily.edward,
                fontWeight: FontWeight.w400,
                color: Color(0XFF463B8C),
                fontSize: 55.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
