import 'package:darpan/firebase_options.dart';
import 'package:darpan/theme/theme_service.dart';
import 'package:darpan/utils/extension.dart';
import 'package:firebase_core/firebase_core.dart';

import 'file_exporter.dart';

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
        valueListenable: themeService.brightnessListner,
        builder: ((context, value, child) {
          return MaterialApp(
            title: 'Darpan',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: context.colorScheme.backgroundColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: context.colorScheme.backgroundColor,
                  foregroundColor: context.colorScheme.secondaryBlackColor,
                )),
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
            initialRoute: Routes.splashView,
          );
        }));
  }
}
