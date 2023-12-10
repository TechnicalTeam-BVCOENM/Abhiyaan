import 'package:darpan/file_exporter.dart';

class FontThemeClass {
  TextStyle appBarText(BuildContext context, [Color? color]) {
    return TextStyle(
      fontSize: 30.sp,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: color ?? context.colorScheme.primaryDarkColor,
    );
  }

  TextStyle large(BuildContext context, [FontWeight? fontWeight]) {
    return TextStyle(
      fontSize: 32,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w700,
      color: context.colorScheme.primaryColor,
    );
  }

  TextStyle heading(BuildContext context, {Color? color, double size = 24}) {
    return TextStyle(
      fontSize: size,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.bold,
      color: color ?? context.colorScheme.headingColor,
    );
  }

  TextStyle heading2(BuildContext context, [Color? primaryColor]) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: primaryColor ?? context.colorScheme.headingColor,
    );
  }

  TextStyle profileheading(BuildContext context) {
    return TextStyle(
      fontSize: 22,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: context.colorScheme.headingColor,
    );
  }

  TextStyle heading3(BuildContext context, [FontWeight? weight]) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Outfit',
      fontWeight: weight ?? FontWeight.w400,
      color: context.colorScheme.headingColor,
    );
  }

  TextStyle heading4(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: context.colorScheme.headingColor,
    );
  }

  TextStyle subHeading(BuildContext context, [Color? color]) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      color: color ?? context.colorScheme.headingColor,
    );
  }

  TextStyle subHeading2(BuildContext context, Color color,
      {FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color,
    );
  }

  TextStyle smallSubHeading(BuildContext context, [Color? color]) {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: color ?? context.colorScheme.headingColor,
    );
  }

  TextStyle smallestSubHeading(BuildContext context, [Color? color]) {
    return TextStyle(
      fontSize: 10,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      color: color ?? context.colorScheme.headingColor,
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
