import 'package:get/get.dart';
import 'package:rhytham/screen/home_module/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
