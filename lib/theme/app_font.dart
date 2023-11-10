import 'package:darpan/file_exporter.dart';
import 'package:darpan/utils/extension.dart';

class FontThemeClass {
  TextStyle appBarText(BuildContext context) {
    return TextStyle(
      fontSize: 26,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle large(BuildContext context) {
    return TextStyle(
      fontSize: 32,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
      color: context.colorScheme.primaryColor,
    );
  }

  TextStyle heading(BuildContext context, Color? color) {
    return TextStyle(
      fontSize: 26,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      color: color ?? context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle heading2(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle heading3(BuildContext context) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      color: context.colorScheme.secondaryBlackColor,
    );
  }

  TextStyle subHeading(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      color: context.colorScheme.secondarySectionColor,
    );
  }

  TextStyle subHeading2(BuildContext context, Color color) {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  TextStyle paragraph(
    BuildContext context,
  ) {
    return TextStyle(
      fontSize: 14,
      letterSpacing: 0.5,
      fontFamily: 'Poppins',
      color: context.colorScheme.secondaryBlackColor,
    );
  }
}
