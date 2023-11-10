import 'package:darpan/file_exporter.dart';

class FontThemeClass {
  TextStyle appBarText = const TextStyle(
    fontSize: 26,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: ColorThemeClass.secondaryBlackColor,
  );
  TextStyle large({
    Color color = ColorThemeClass.primaryColor,
  }) {
    return TextStyle(
      fontSize: 32,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  TextStyle heading({
    Color color = ColorThemeClass.secondaryBlackColor,
  }) {
    return TextStyle(
      fontSize: 26,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  TextStyle heading2({
    Color color = ColorThemeClass.secondaryBlackColor,
  }) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle heading3({
    Color color = ColorThemeClass.secondaryBlackColor,
  }) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  TextStyle subHeading({
    Color color = ColorThemeClass.secondarySectionColor,
  }) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      color: color,
    );
  }

  TextStyle subHeading2({
    Color color = ColorThemeClass.secondarySectionColor,
  }) {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  TextStyle paragraph({
    double? size = 14,
    Color color = ColorThemeClass.secondaryBlackColor,
  }) {
    return TextStyle(
      fontSize: size,
      letterSpacing: 0.5,
      fontFamily: 'Poppins',
      color: color,
    );
  }
}
