import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationInfo {
  final String title;
  final String subtitle;
  final String channelId;
  final String channelName;
  final Map<String, dynamic> payLoad;

  NotificationInfo({
    required this.title,
    required this.subtitle,
    required this.channelId,
    required this.channelName,
    required this.payLoad,
  });

  factory NotificationInfo.fromFirebaseMessage({required RemoteMessage message}) {
    return NotificationInfo(
      title: (message.notification?.title ?? ''),
      subtitle: (message.notification?.body ?? ''),
      channelId: 'high_importance_channel_custom',
      channelName: 'high_importance_channel_name',
      payLoad: message.data,
    );
  }
}
