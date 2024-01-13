import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract final class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Initialize android settings for local notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // Initialize ios settings for local notifications
    const DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings(
        // If you want to request permissions at a later point in your application on iOS, set all of the bellow to false when initialize the plugin.
        //   requestSoundPermission: false,
        // requestBadgePermission: false,
        // requestAlertPermission: false,
        );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await _requestPermission();
  }

  static Future<bool?>? _requestPermission() {
    if (Platform.isIOS) {
      // If you set permissions are false on iOS, you have to request permission at a later point in your application.
      // requestIosPermission();
    } else if (Platform.isAndroid) {
      return requestAndroidPermission();
    }
    return null;
  }

  static Future<bool?>? requestIosPermission() {
    return _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<bool?>? requestAndroidPermission() {
    return _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Create the channel on the device (if a channel with an id already exists, it will be updated):
  static Future<void> createAndroidNotificationChannel({
    required String id,
    required String title,
    String? description,
  }) async {
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      id, // id
      title, // title
      description: description,
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  //  Show a notification immediately
  static Future<void> showNotification({
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    String? payload,
    int? id,
  }) async {
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      id ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
