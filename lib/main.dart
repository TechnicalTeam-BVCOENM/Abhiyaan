import 'package:abhiyaan/firebase_options.dart';
import 'package:abhiyaan/services/notification_service.dart';
import 'package:abhiyaan/theme/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isNotEmpty) {
    return;
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void notificationServicesAfterAppStart(BuildContext context) {
  NotificationService notificationService = NotificationService();
  notificationService.reqestNotificationPermission();
  notificationService.initFirebaseNotification(context);
  notificationService.setupInteractMessage(context);
}

Future<void> servicesToInitializeBeforeAppStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  setupLocator();
  await Future.wait([
    locator<LocalStorageService>().initStorage(),
  ]);
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
    notificationServicesAfterAppStart(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.colorScheme.secondaryBlackColor,
        statusBarIconBrightness: themeService.brightness == Brightness.light
            ? Brightness.light
            : Brightness.dark,
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
                title: 'abhiyaan',
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
