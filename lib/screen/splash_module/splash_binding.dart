import 'package:get/get.dart';
import 'package:rhytham/screen/splash_module/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
