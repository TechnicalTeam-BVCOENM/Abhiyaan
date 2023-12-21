import '../../file_exporter.dart';

void showSuccessMessage(BuildContext context, String message) {
  _showmessage(context, message, 'success');
}

void showErrorMessage(BuildContext context, String message) {
  _showmessage(context, message, 'error');
}

void showWarningMessage(BuildContext context, String message) {
  _showmessage(context, message, 'warning');
}

void showNormalMessage(BuildContext context, String message) {
  _showmessage(context, message, 'normal');
}

void _showmessage(BuildContext context, String message, String type) {
  assert(message.length < 50, "message should be smaller than 50 characters");
  FontThemeClass fontTheme = FontThemeClass();
  Color backgroundColor;
  IconData icon;

  switch (type) {
    case 'success':
      backgroundColor = Colors.green.shade400;
      icon = Icons.check_circle;
      break;
    case 'error':
      backgroundColor = Colors.red.shade400;
      icon = Icons.error;
      break;
    case 'warning':
      backgroundColor = Colors.amber.shade400;
      icon = Icons.warning;
      break;
    case 'normal':
      backgroundColor = context.colorScheme.secondaryLPurpleColor;
      icon = Icons.message;
      break;
    default:
      backgroundColor = Colors.blue.shade400;
      icon = Icons.info;
  }
  try {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.all(10),
      elevation: 300,
      duration: const Duration(milliseconds: 2000),
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      content: Center(
        child: SizedBox(
          height: 60.h,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20).r),
            child: Row(
              children: [
                Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child:  Icon(
                     icon,
                      color: Colors.white,
                    )),
                    20.horizontalSpace,
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: fontTheme.body(context,
                      color: context.colorScheme.secondaryBlackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  } catch (e) {
    debugPrint("error is $e");
  }
}
