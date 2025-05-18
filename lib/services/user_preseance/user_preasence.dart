import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:rhytham/services/shared_pref/shared_pref.dart';

class UserPresenceService extends GetxService {
  late final DatabaseReference _userPresenceRef;
  DateTime dateTime = DateTime.now();
  late Timer timer;

  UserPresenceService() {
    _userPresenceRef = FirebaseDatabase.instance.ref().child('USER-PRESENCE');
  }

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) async {
        await updateTimeSpent();
      },
    );
  }

  // Update user presence when user signs in
  void updateUserPresence(String userId, bool isOnline) {
    DatabaseReference userRef = _userPresenceRef.child(userId);
    userRef.update({
      'isOnline': isOnline,
      // 'lastSeen': ServerValue.timestamp,
    });

    userRef.onDisconnect().update({
      'isOnline': false,
      'lastSeen': ServerValue.timestamp,
    });
  }

  Future<int> updateTimeSpent() async {
    final SharedPref pref = Get.find<SharedPref>();
    String? userId = pref.getUniQueId();
    if (userId == null) return 0;
    DatabaseReference userRef = _userPresenceRef.child(userId);

    DataSnapshot? timeSpent = await userRef.child("timeSpent").get();
    DataSnapshot? lastSeen = await userRef.child("lastSeen").get();
    int? timeStamp = int.tryParse(lastSeen.value.toString());
    int timeSpentSec = int.tryParse(timeSpent.value.toString()) ?? 0;
    if (timeStamp != null) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      if (date.difference(dateTime).inDays < 1) {
        int seconds = dateTime.difference(DateTime.now()).inSeconds.abs();
        userRef.update({
          'timeSpent': timeSpentSec + seconds,
        });
        dateTime = DateTime.now();
      } else {
        int seconds = dateTime.difference(DateTime.now()).inSeconds.abs();
        userRef.update({
          'timeSpent': seconds,
        });
      }
    }

    return timeSpentSec;
  }

  getValueByKey() {}

  void offLineUserPresence() {
    final SharedPref pref = Get.find<SharedPref>();
    String? userId = pref.getUniQueId();
    if (userId == null) return;

    DatabaseReference userRef = _userPresenceRef.child(userId);
    userRef.update({
      'isOnline': false,
      'lastSeen': ServerValue.timestamp,
    });
  }

  // Get the count of active users
  Stream<int> getActiveUserCount() {
    return _userPresenceRef.onValue.map((event) {
      int count = 0;
      Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, value) {
          if (value['isOnline'] == true) {
            count++;
          }
        });
      }
      return count;
    });
  }

  Stream<int> getActiveUser() {
    final SharedPref pref = Get.find<SharedPref>();
    String? userId = pref.getUniQueId();

    if (userId != null) {
      return _userPresenceRef.child(userId).onValue.map((event) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
        print("events:- ${values?["timeSpent"] ?? 0}");
        return values?["timeSpent"] ?? 0;
      });
    } else {
      return Stream.value(0); // Default value when userId is null
    }
  }
}
