import 'package:darpan/file_exporter.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get primaryColor => const Color.fromARGB(255, 78, 75, 215);
  Color get backgroundColor => brightness == Brightness.dark
      ? const Color(0xFF252525)
      : const Color(0xFFECECFF);
  Color get secondaryLPurpleColor => brightness == Brightness.dark
      ? const Color.fromARGB(131, 73, 73, 73)
      : const Color(0xFFD6D5FA);
  Color get secondaryWhiteColor => brightness == Brightness.dark
      ? const Color.fromARGB(131, 73, 73, 73)
      : const Color(0xFFF9F9F9);
  Color get secondaryBlackColor =>
      brightness == Brightness.dark ? Colors.white : const Color(0xFF252525);
  Color get secondarySectionColor => const Color(0xFF8F8FB0);

  Color get bottomNavBarBg => brightness == Brightness.dark
      ? const Color.fromARGB(255, 25, 25, 25)
      : const Color(0xFFFFFFFF);

  Color get selectedBottomNavIcon => const Color(0xFF4E4BD7);

  Color get unSelectedBottomNavIcon => const Color(0xFF9DB2CE);

  Color get selectedBottomNavIconbg => const Color(0xFF4E4BD7).withOpacity(0.1);

  Color get primaryDarkColor =>
      brightness == Brightness.dark ? Colors.white : const Color(0xFF1C1A63);

  Color get signInTextColor => brightness == Brightness.dark
      ? const Color(0xFFF9F9F9)
      : const Color(0xFF252525);

  Color get headingColor =>
      brightness == Brightness.dark ? Colors.white : const Color(0xFF252525);
  Color get iconColor =>
      brightness == Brightness.dark ? Colors.white : const Color(0xFF252525);
  Color get signInTextColor => const Color(0xFFF9F9F9);

}
