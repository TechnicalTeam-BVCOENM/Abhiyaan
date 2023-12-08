import 'package:darpan/firebase_options.dart';
import 'package:darpan/theme/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:darpan/file_exporter.dart';

Future<void> servicesToInitializeBeforeAppStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();

  await Future.wait([
    locator<LocalStorageService>().initStorage(),
  ]);
}

void main() async {
  await servicesToInitializeBeforeAppStart();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = locator<ThemeService>();
    return ValueListenableBuilder(
        valueListenable: themeService.valueListenable,
        builder: ((context, value, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 640),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'Darpan',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: themeService.brightness,
                  scaffoldBackgroundColor: context.colorScheme.backgroundColor,
                  appBarTheme: AppBarTheme(
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
