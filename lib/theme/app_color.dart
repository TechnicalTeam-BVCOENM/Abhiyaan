import 'package:abhiyaan/file_exporter.dart';

extension ColorSchemeExtension on ColorScheme {
  // new
  Color get black => const Color(0xFF181818);
  Color get white => const Color(0xFFFFFFFF);
  Color get primaryAccentColor => const Color.fromARGB(255, 78, 75, 215);
  Color get primaryLightScaffold => const Color(0xFFD6D5FA);
  Color get primaryDarkScaffold => const Color(0xFF010409);
  Color get primaryDarkGrey => black.withOpacity(0.5);
  Color get primaryLightGrey => white.withOpacity(0.5);
  Color get unSelectedBottomNavIcon => const Color(0xFF9DB2CE);

  // don't know why
  Color get secondaryPurpleColor => const Color.fromARGB(131, 73, 73, 73);
  Color get secondarySectionColor => const Color(0xFF8F8FB0);

  Color get primaryTextColor => brightness == Brightness.dark ? white : black;
  Color get secondaryTextColor =>
      brightness == Brightness.dark ? primaryLightGrey : primaryDarkGrey;
  Color get scaffoldBackgroundColor => brightness == Brightness.dark
      ? primaryDarkScaffold
      : primaryLightScaffold;
  Color get primaryCardColor => brightness == Brightness.dark ? black : white;
  Color get switchColor => brightness == Brightness.dark
      ? const Color.fromARGB(255, 141, 135, 253)
      : const Color.fromARGB(255, 78, 75, 215);
}
