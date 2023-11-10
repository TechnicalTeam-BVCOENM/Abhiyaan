import 'package:darpan/theme/app_color.dart';
import 'file_exporter.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Darpan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorThemeClass.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorThemeClass.backgroundColor,
          foregroundColor: ColorThemeClass.secondaryBlackColor,
        )
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      initialRoute: Routes.splashView,
    );
  }
}
