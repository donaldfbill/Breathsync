import 'package:get/get.dart';
import 'package:rhytham/screen/setting_module/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}
