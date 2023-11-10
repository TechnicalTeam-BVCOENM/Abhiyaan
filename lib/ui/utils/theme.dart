import 'package:darpan/file_exporter.dart';

class ColorThemeClass {
  Color primaryColor = const Color(0xFF4E4BD7);
  Color secondaryColor = const Color(0xFFECECFF);
  Color secondaryFadedColor = const Color(0xFFF9F9F9);
  Color secondaryInverseColor = const Color(0xFF252525);
  Color secondaryTextColor = const Color(0xFF8F8FB0);
}

class TextThemeClass {
  TextStyle heading = TextStyle(
    fontSize: 26,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: ColorThemeClass().secondaryInverseColor,
  );

  TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    color: ColorThemeClass().secondaryTextColor,
  );
}
