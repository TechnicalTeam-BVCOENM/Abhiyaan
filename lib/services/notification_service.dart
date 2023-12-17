import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void reqestNotificationPermission() async {
    try {
      debugPrint('Requesting permission');
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initFirebaseNotification() async {
    try {
      FirebaseMessaging.onMessage.listen((message) {
        if (kDebugMode) {
          debugPrint('onMessage: ${message.notification!.body.toString()}');
          initLocalNotification();
        }
        showNotification(message);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initLocalNotification() async {
    try {
      // For Android
      const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // For iOS
      const iosInitializationSettings = DarwinInitializationSettings();

      // For both Android & iOS
      var initializationSettings = const InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings);

      // For both Android & iOS Plugin Activation
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          debugPrint('notification payload: $payload');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max,
      );

      //  For Android
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: 'Your channel description',
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'ticker',
      );

      //  For iOS
      DarwinNotificationDetails iOSPlatformChannelSpecifics =
          const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      // For both Android & iOS
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      // For both Android & iOS
      await Future.delayed(
          Duration.zero,
          () => flutterLocalNotificationsPlugin.show(
                0,
                message.notification!.title.toString(),
                message.notification!.body.toString(),
                platformChannelSpecifics,
                payload: 'Default_Sound',
              ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getDeviceToken() async {
    try {
      String? token = await messaging.getToken();
      debugPrint('Device Token: $token');
      return token!;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  void refreshedDeviceToken() {
    messaging.onTokenRefresh.listen((event) {
      debugPrint('Device Token: $event');
    });
  }
}
