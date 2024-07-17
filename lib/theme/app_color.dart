import 'package:abhiyaan/file_exporter.dart';



extension ColorSchemeExtension on ColorScheme {
  Color get black => const Color(0xFF202020);
  Color get white => const Color(0xFFFFFFFF);

  // brand
  Color get accentColor => const Color.fromARGB(255, 78, 75, 215);

  // text
  Color get primaryText => brightness == Brightness.dark ? white : black;
  Color get secondaryText => brightness == Brightness.dark
      ? white.withOpacity(0.5)
      : black.withOpacity(0.5);

  // scaffold
  Color get lightScaffold => const Color(0xFFD6D5FA);
  Color get darkScaffold => const Color(0xFF121212);
  Color get scaffold =>
      brightness == Brightness.dark ? darkScaffold : lightScaffold;

  // card
  Color get card => brightness == Brightness.dark ? black : white;

  // switch
  Color get toggle => brightness == Brightness.dark
      ? const Color.fromARGB(255, 141, 135, 253)
      : const Color.fromARGB(255, 78, 75, 215);

  // Bottom-nav
  Color get bottomNavIconInactive => const Color(0xFF9DB2CE);
  Color get bottomNavIconActive => brightness == Brightness.dark
      ? const Color.fromARGB(255, 189, 188, 255)
      : accentColor;

  // don't know why
  Color get secondaryPurpleColor => const Color.fromARGB(131, 73, 73, 73);
  Color get secondarySectionColor => const Color(0xFF8F8FB0);
}