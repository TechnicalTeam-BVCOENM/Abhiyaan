import 'package:darpan/firebase_options.dart';
import 'package:darpan/services/notification_service.dart';
import 'package:darpan/theme/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:darpan/file_exporter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

Future<void> servicesToInitializeBeforeAppStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  await Future.wait([
    locator<LocalStorageService>().initStorage(),
  ]);
  NotificationService notificationService = NotificationService();
  notificationService.reqestNotificationPermission();
  notificationService.initFirebaseNotification();
}

void main() async {
  await servicesToInitializeBeforeAppStart();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = locator<ThemeService>();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeService.brightness == Brightness.light
            ? context.colorScheme.backgroundColor
            : context.colorScheme.secondaryBlackColor,
        statusBarIconBrightness: themeService.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        statusBarBrightness: themeService.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
    return ValueListenableBuilder(
        valueListenable: themeService.valueListenable,
        builder: ((context, value, child) {
          return ScreenUtilInit(
            designSize: const Size(430, 932),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'Darpan',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  textTheme: const TextTheme(),
                  primaryColor: context.colorScheme.primaryColor,
                  brightness: themeService.brightness,
                  scaffoldBackgroundColor: context.colorScheme.backgroundColor,
                  appBarTheme: AppBarTheme(
                    elevation: 0,
                    backgroundColor: context.colorScheme.backgroundColor,
                    foregroundColor: context.colorScheme.secondaryBlackColor,
                  ),
                ),
                onGenerateRoute: StackedRouter().onGenerateRoute,
                navigatorKey: StackedService.navigatorKey,
                initialRoute: Routes.splashView,
              );
            },
          );
        }));
  }
}
