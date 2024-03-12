import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_template/common/constants/notifications/notification_channel_ids.dart';
import 'package:flutter_template/common/constants/notifications/notification_channel_names.dart';
import 'package:flutter_template/common/helpers/local_notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  log('onBackgroundMessage: ${message.notification?.title}');
  log('onBackgroundMessage: ${message.notification?.body}');
}

abstract final class FirebaseMessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _requestPermission();

    // Create notification channel for FCM notifications
    if (Platform.isAndroid) {
      await LocalNotificationService.createAndroidNotificationChannel(
        id: NotificationChannelIds.fcmChannel,
        title: NotificationChannelNames.fcmChannel,
      );
    }

    _listenForegroundMessaging();

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // Handle when a user presses a notification message displayed via FCM.
    });

    final token = await _messaging.getToken();
    log('Token:${token.toString()}');
  }

  static Future<void> _requestPermission() async {
    if (Platform.isIOS) {
      await _messaging.requestPermission(
        announcement: true,
        carPlay: true,
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }
  }

  static void _listenForegroundMessaging() {
    FirebaseMessaging.onMessage.listen((event) {
      final remoteNotification = event.notification;

      if (remoteNotification != null && Platform.isAndroid) {
        LocalNotificationService.showNotification(
          title: remoteNotification.title ?? 'Title',
          body: remoteNotification.body ?? 'Body',
          channelId: NotificationChannelIds.fcmChannel,
          channelName: NotificationChannelNames.fcmChannel,
        );
      }
    });
  }
}
