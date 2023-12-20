import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isLocalNotificationInitialized = false;

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

  Future initFirebaseNotification(BuildContext context) async {
    try {
      debugPrint('Initializing firebase notification');
      FirebaseMessaging.onMessage.listen((message) {
        if (Platform.isAndroid) {
          initLocalNotification(context, message);
          debugPrint('Initialized Android firebase notification successfully!');
        } else {
          showNotification(message);
          debugPrint('Initialized Ios firebase notification successfully!');
        }
      });

      await messaging
          .subscribeToTopic('all')
          .whenComplete(() => debugPrint('Subscribed to topic "all"'));
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
      if (!isLocalNotificationInitialized) {
        debugPrint('Checking local notification initialization');
        await flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (payload) async {
            handleMessage(context, message);
          },
        );
      }
      debugPrint('Initialized local notification successfully!');
    } catch (e) {
      debugPrint('Initialized local notification failed!');

      debugPrint(e.toString());
    }
    debugPrint('📍📍📍📍Initialized local notification exited!');
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

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
    if (message.data['type'] == 'event') {
      navigationService.navigateToEventView();
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      if (isLocalNotificationInitialized) {
        return;
      }

      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
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
        channelDescription: channel.description,
        priority: Priority.high,
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
      await messaging
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      isLocalNotificationInitialized = true;

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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getDeviceToken() async {
    AuthenticationService authenticationService =
        locator<AuthenticationService>();
    try {
      String? token = await messaging.getToken();
      if (token != null) {
        debugPrint('📍 Device Token: $token');
        authenticationService.saveDeviceToken(token);
      }
    } catch (e) {
      debugPrint('Device Token Error: ${e.toString()}');
    }
  }
}
