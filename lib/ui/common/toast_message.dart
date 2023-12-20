import 'package:flutter_animate/flutter_animate.dart';

import '../../file_exporter.dart';

void showmessage(BuildContext context, String message) {
  FontThemeClass fontTheme = FontThemeClass();
  try {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.all(10),
      elevation: 30,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.transparent,
      content: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          height: 50.sp,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.colorScheme.secondaryWhiteColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              message,
              style: fontTheme.body(context,
                  color: context.colorScheme.secondaryBlackColor),
            ),
          ),
        ),
      ),
    ));
  } catch (e) {
    debugPrint("error is $e");
  }
}
