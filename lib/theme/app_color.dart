import 'package:abhiyaan/file_exporter.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get black => const Color(0xFF202020);
  Color get white => const Color(0xFFFFFFFF);

  // Accent Colors
  Color get accentColor => const Color(0xFF6764E2);

  // Primary Text
  Color get primaryLightText => white;
  Color get primaryDarkText => black;
  Color get primaryText =>
      brightness == Brightness.dark ? primaryLightText : primaryDarkText;

  // Secondary Text
  Color get secondaryLightText => white.withOpacity(0.7);
  Color get secondaryDarkText => black.withOpacity(0.7);
  Color get secondaryText =>
      brightness == Brightness.dark ? secondaryLightText : secondaryDarkText;

  // Scaffold Color
  Color get backgroundLight => const Color(0xFFF3F3F3);
  Color get backgroundDark => const Color(0xFF121212);
  Color get scaffold =>
      brightness == Brightness.dark ? backgroundDark : backgroundLight;

  // Card Color
  Color get cardLight => const Color(0xFFFFFFFF);
  Color get cardDark => const Color(0xFF2E2E2E);
  Color get card => brightness == Brightness.dark ? cardDark : cardLight;

  // Toogle Switch Color
  Color get toggle => brightness == Brightness.dark
      ? const Color(0xFF8D87FD)
      : const Color(0xFF4E4BD7);

  // BottomNav Color
  Color get bottomNavIconInactive => const Color(0xFF9DB2CE);
  Color get bottomNavIconActive => brightness == Brightness.dark
      ? const Color.fromARGB(255, 189, 188, 255)
      : accentColor;
}
