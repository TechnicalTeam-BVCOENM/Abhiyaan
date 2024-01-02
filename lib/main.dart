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

Future<void> servicesToInitializeBeforeAppStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationsService notificationsService = NotificationsService();
  LocalNotificationService.initialize();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    notificationsService.registerNotification();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    notificationsService.onForegroundMessage();
    notificationsService.onBackgroundMessage();
  }
  setupLocator();
  await Future.wait([
    locator<LocalStorageService>().initStorage(),
  ]);
}

void main() async {
  await servicesToInitializeBeforeAppStart();
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds
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
