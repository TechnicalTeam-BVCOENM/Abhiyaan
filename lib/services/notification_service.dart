import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:darpan/file_exporter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
        debugPrint('User declined or has not accepted permission');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initFirebaseNotification(BuildContext context) async {
    try {
      debugPrint('Initializing firebase notification');
      FirebaseMessaging.onMessage.listen((message) {
        if (Platform.isAndroid) {
          initLocalNotification(context, message);
          showNotification(message);
        } else {
          showNotification(message);
        }
      });
      debugPrint('Initialized firebase notification successfully!');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    try {
      debugPrint('Initializing local notification');
      // For Android
      AndroidInitializationSettings androidInitializationSettings =
          const AndroidInitializationSettings('@mipmap/ic_launcher');

      // For iOS
      const DarwinInitializationSettings iosInitializationSettings =
          DarwinInitializationSettings();

      // For both Android & iOS
      var initializationSettings = InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings);

      // For both Android & iOS Plugin Activation
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          handleMessage(context, message);
        },
      );
      debugPrint('Initialized local notification successfully!');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    final navigationService = locator<NavigationService>();

    if (message.data['type'] == 'msg') {
      navigationService.navigateToNotificationView(id: message.data['id']);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      if (message.notification != null) {
        AndroidNotificationChannel channel = const AndroidNotificationChannel(
          '1',
          'High Importance Channel',
          importance: Importance.max,
        );
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        //  For Android
        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: 'Your channel description',
          priority: Priority.max,
          importance: Importance.max,
          showWhen: false,
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
        Future.delayed(
            Duration.zero,
            () => flutterLocalNotificationsPlugin.show(
                  0,
                  message.notification?.title.toString(),
                  message.notification?.body.toString(),
                  platformChannelSpecifics,
                  payload: 'Default_Sound',
                ));
      }
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
