import 'package:abhiyaan/file_exporter.dart';

class FontThemeClass {
  TextStyle display(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 42.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }

  TextStyle header(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 34.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }

  TextStyle title(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 28.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }

  TextStyle title2(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 22.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }

  TextStyle paragraph(BuildContext ctx,
      {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 20.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }

  TextStyle body(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 16.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }

  TextStyle caption(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryDarkColor,
    );
  }
}
