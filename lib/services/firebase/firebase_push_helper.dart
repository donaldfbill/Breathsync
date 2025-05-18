import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_helper.dart';
import 'models/notification_info.dart';

abstract class FirebasePushHelperHelperProtocol {
  Future<void> initPushConfiguration(void Function(NotificationResponse value) callback);

  Future<void> saveToken();
}

class FirebasePushHelper extends FirebasePushHelperHelperProtocol {
  static final FirebasePushHelperHelperProtocol instance = FirebasePushHelper._();

  FirebasePushHelper._();

  final messaging = FirebaseMessaging.instance;
  final notificationHelper = NotificationHelper.instance;

  @override
  Future<void> initPushConfiguration(void Function(NotificationResponse) callback) async {
    await notificationHelper.initialize(callback);
    await messaging.requestPermission();
    _setupForegroundNotify();
    _setupBackGroundMessage();
    //await _setupTerminatedNotify();
    //_setupClickNotify();
  }

  @override
  Future<void> saveToken() async {
    await messaging.getToken().then((token) => log('$token', name: 'TOKEN'));
    messaging.onTokenRefresh.listen((newToken) => log(newToken, name: 'TOKEN'));
  }

  void _setupForegroundNotify() => FirebaseMessaging.onMessage.listen(_messageShowHandler);

  static void _setupBackGroundMessage() => FirebaseMessaging.onBackgroundMessage(_messageShowHandler);

  // void _setupClickNotify() => FirebaseMessaging.onMessageOpenedApp.listen((_) {});
  //
  // Future<void> _setupTerminatedNotify() async {
  //   final initialMsg = await messaging.getInitialMessage();
  //   if (initialMsg == null) return;
  //   _messageShowHandler(initialMsg);
  // }
}

@pragma('vm:entry-point')
Future<void> _messageShowHandler(RemoteMessage message) async {
  final notificationHelper = NotificationHelper.instance;
  final notificationInfo = NotificationInfo.fromFirebaseMessage(message: message);
  notificationHelper.showNotification(notificationInfo);
}
