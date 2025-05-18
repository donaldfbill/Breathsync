import 'dart:async';

import 'package:get/get.dart';

class UserTrackController extends GetxService {
  Timer? _timer;
  DateTime? _startTime;

  Future<UserTrackController> init() async {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(DateTime.now().difference(_startTime!).inSeconds);
      //_trackTime();
    });
    return this;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  void _trackTime() {
    // if (_startTime != null) {
    //   final elapsed = DateTime.now().difference(_startTime!).inSeconds;
    //   _databaseReference.child('user_time').set({'time_spent': elapsed});
    // }
  }
}
