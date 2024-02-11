import 'package:abhiyaan/firebase_options.dart';
import 'package:abhiyaan/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  final analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = locator<ThemeService>();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeService.brightness == Brightness.light
            ? context.colorScheme.scaffoldBackgroundColor
            : Colors.transparent,
        statusBarIconBrightness: themeService.brightness == Brightness.light
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
              title: 'Abhiyaan',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: const TextTheme(),
                primaryColor: context.colorScheme.primaryAccentColor,
                brightness: themeService.brightness,
                scaffoldBackgroundColor:
                    context.colorScheme.scaffoldBackgroundColor,
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  backgroundColor: context.colorScheme.scaffoldBackgroundColor,
                  foregroundColor: context.colorScheme.primaryTextColor,
                ),
              ),
              navigatorObservers: [
                locator<AnalyticsService>().getAnalyticsObserver()
              ],
              onGenerateRoute: StackedRouter().onGenerateRoute,
              navigatorKey: StackedService.navigatorKey,
              initialRoute: Routes.splashView,
            );
          },
        );
      }),
    );
  }
}
