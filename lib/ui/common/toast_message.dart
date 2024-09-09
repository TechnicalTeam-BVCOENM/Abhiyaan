import 'package:abhiyaan/file_exporter.dart';

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
      backgroundColor = context.colorScheme.accentColor;
      icon = Icons.message;
      break;
    default:
      backgroundColor = Colors.blue.shade400;
      icon = Icons.info;
  }

  // Check if a snackbar is currently being shown
  if (ScaffoldMessenger.of(context).mounted) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  try {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(10),
        elevation: 300,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        content: Center(
          child: SizedBox(
            height: 60.h,
            // width: double.infinity,
            child: Card(
              color: context.colorScheme.card,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20).r,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: fontTheme.body(context),
                  ),
                  const Spacer(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  } catch (e) {
    debugPrint("error is $e");
  }
}
