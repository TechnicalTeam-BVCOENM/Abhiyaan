import '../../file_exporter.dart';

void showmessage(context, String message) {
  FontThemeClass fontTheme = FontThemeClass();
  try {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.transparent,
      content: Center(
        child: Container(
          padding:
              const EdgeInsets.only(left: 70, right: 70, top: 8, bottom: 8),
          height: 40.sp,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryLPurpleColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            message,
            style: fontTheme.header(context,
                color: context.colorScheme.secondaryBlackColor),
          ),
        ),
      ),
    ));
  } catch (e) {
    debugPrint("error is $e");
  }
}
