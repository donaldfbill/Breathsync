import 'package:get/get.dart';
import 'package:rhytham/screen/poem_module/poem_controller.dart';

class PoemBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PoemController());
  }
}