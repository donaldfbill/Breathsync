import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationController {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const Map<String, String> timeZoneMap = {
    // Africa
    'WAT': 'Africa/Lagos', // West Africa Time
    'CAT': 'Africa/Harare', // Central Africa Time
    'EAT': 'Africa/Nairobi', // East Africa Time
    'PST': 'America/Los_Angeles', // Pacific Standard Time
    'MST': 'America/Denver', // Mountain Standard Time
    'CST': 'America/Chicago', // Central Standard Time
    'EST': 'America/New_York', // Eastern Standard Time
    'AST': 'America/Halifax', // Atlantic Standard Time
    'NST': 'America/St_Johns', // Newfoundland Standard Time
    'NZST': 'Antarctica/South_Pole', // New Zealand Standard Time
    'IST': 'Asia/Kolkata', // Indian Standard Time
    'PKT': 'Asia/Karachi', // Pakistan Standard Time
    'BST': 'Asia/Dhaka', // Bangladesh Standard Time
    'WIB': 'Asia/Jakarta', // Western Indonesian Time
    'WITA': 'Asia/Makassar', // Central Indonesian Time
    'WIT': 'Asia/Jayapura', // Eastern Indonesian Time
    'JST': 'Asia/Tokyo', // Japan Standard Time
    'KST': 'Asia/Seoul', // Korea Standard Time
    'AEST': 'Australia/Sydney', // Australian Eastern Standard Time
    'ACST': 'Australia/Adelaide', // Australian Central Standard Time
    'AWST': 'Australia/Perth', // Australian Western Standard Time
    'GMT': 'Europe/London', // Greenwich Mean Time
    'CET': 'Europe/Paris', // Central European Time
    'EET': 'Europe/Istanbul', // Eastern European Time
    'MSK': 'Europe/Moscow', // Moscow Standard Time
    'UTC': 'Etc/UTC', // Coordinated Universal Time
    'IRST': 'Asia/Tehran', // Iran Standard Time
    'GST': 'Asia/Dubai', // Gulf Standard Time
  };

  static Future<void> initializeNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
    // Handle background notification response
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    // Handle notification response when the app is in the foreground or background
  }

  //dhruv
  static Future<void> scheduleNotificationByDateAndTime() async {
    tz.initializeTimeZones(); // Make sure to call this at the beginning of your app's initialization.
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(DateTime.now().add(const Duration(seconds: 10)), tz.local);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'This is a scheduled notification.',
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static scheduleDailyNotification() async {
    tz.initializeTimeZones();
    final String timeZoneName = DateTime.now().timeZoneName;
    final String ianaTimeZone = timeZoneMap[DateTime.now().timeZoneName] ?? 'Etc/UTC';
    tz.setLocalLocation(tz.getLocation(ianaTimeZone));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 08, 05);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'This is a scheduled notification.',
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> cancelNotificationsWithId(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
