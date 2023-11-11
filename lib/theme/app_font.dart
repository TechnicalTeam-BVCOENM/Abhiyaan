import 'package:darpan/file_exporter.dart';
import 'package:darpan/utils/extension.dart';

class FontThemeClass {
  TextStyle appBarText(BuildContext context) {
    return TextStyle(
      fontSize: 26,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.bold,
      color: context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle large(BuildContext context) {
    return TextStyle(
      fontSize: 32,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w800,
      color: context.colorScheme.primaryColor,
    );
  }

  TextStyle heading(BuildContext context, [Color? color]) {
    return TextStyle(
      fontSize: 26,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.bold,
      color: color ?? context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle heading2(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w600,
      color: context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle heading3(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w400,
      color: context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle subHeading(BuildContext context, Color? color) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      color: color ?? context.colorScheme.secondarySectionColor,
    );
  }

  TextStyle subHeading2(BuildContext context, Color color) {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: color,
    );
  }
  TextStyle smallSubHeading(BuildContext context, [Color? color]) {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: color ?? context.colorScheme.secondarySectionColor,
    );
  }

  TextStyle paragraph(
    BuildContext context,
  ) {
    return TextStyle(
      fontSize: 14,
      letterSpacing: 0.5,
      fontFamily: 'Outfit',
      color: context.colorScheme.secondaryBlackColor,
    );
  }
}
