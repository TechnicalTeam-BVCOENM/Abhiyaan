import 'package:abhiyaan/file_exporter.dart';

class FontThemeClass {
  TextStyle display(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 42.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle header(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 34.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle eventCard(BuildContext ctx,
      {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 30.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle title(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 28.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle title2(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 22.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle paragraph(BuildContext ctx,
      {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 20.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle body(BuildContext ctx,
      {Color? color, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? 16.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle caption(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }

  TextStyle small(BuildContext ctx, {Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: 12.sp,
      fontFamily: 'Outfit',
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? ctx.colorScheme.primaryText,
    );
  }
}
