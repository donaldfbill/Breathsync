import 'package:get/get.dart';
import 'package:rhytham/services/shared_pref/shared_pref.dart';
import 'package:rhytham/user_track_controller.dart';

class GlobalScreenBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() => SharedPref().init());
  }
}
