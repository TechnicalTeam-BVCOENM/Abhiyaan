import 'package:darpan/file_exporter.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get primaryColor => const Color(0xFF4E4BD7);
  Color get backgroundColor => const Color(0xFFECECFF);
  Color get secondaryLPurpleColor => const Color(0xFFD6D5FA);
  Color get secondaryWhiteColor => const Color(0xFFF9F9F9);
  Color get secondaryBlackColor => const Color(0xFF252525);
  Color get secondarySectionColor => const Color(0xFF8F8FB0);

  Color get bottomNavBarBg => const Color(0xFFFFFFFF);

  Color get selectedBottomNavIcon => const Color(0xFF4E4BD7);

  Color get unSelectedBottomNavIcon => const Color(0xFF9DB2CE);

  Color get selectedBottomNavIconbg => const Color(0xFF4E4BD7).withOpacity(0.1);

  Color get primaryDarkColor => const Color(0xFF1C1A63);
}
