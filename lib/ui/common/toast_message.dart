import 'package:abhiyaan/file_exporter.dart';

enum MessageType { success, error, warning, normal }

void showMessage(BuildContext context, String message, MessageType type) {
  FontThemeClass fontTheme = FontThemeClass();
  Color backgroundColor;
  IconData icon;

  switch (type) {
    case MessageType.success:
      backgroundColor = Colors.green.shade600;
      icon = Icons.check_circle;
      break;
    case MessageType.error:
      backgroundColor = Colors.red.shade600;
      icon = Icons.error;
      break;
    case MessageType.warning:
      backgroundColor = Colors.amber.shade500;
      icon = Icons.warning;
      break;
    case MessageType.normal:
      backgroundColor = context.colorScheme.accentColor;
      icon = Icons.message;
      break;
  }

  if (ScaffoldMessenger.of(context).mounted) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  try {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(10),
        elevation: 300,
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        content: Center(
          child: SizedBox(
            height: 60.h,
            child: Card(
              color: context.colorScheme.card,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20).r,
              ),
              child: Row(
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: fontTheme.body(context),
                    ),
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
    debugPrint("Error displaying message: $e");
  }
}

void showSuccessMessage(BuildContext context, String message) {
  showMessage(context, message, MessageType.success);
}

void showErrorMessage(BuildContext context, String message) {
  showMessage(context, message, MessageType.error);
}

void showWarningMessage(BuildContext context, String message) {
  showMessage(context, message, MessageType.warning);
}

void showNormalMessage(BuildContext context, String message) {
  showMessage(context, message, MessageType.normal);
}
