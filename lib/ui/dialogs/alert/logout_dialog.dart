import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/auth_service.dart';

part 'logout_dialog_model.dart';

class LogoutDialog extends StackedView<LogoutDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const LogoutDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    LogoutDialogModel viewModel,
    Widget? child,
  ) {
    final font = FontThemeClass();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.colorScheme.card,
      child: Padding(
        padding: const EdgeInsets.all(12.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_rounded,
              color: context.colorScheme.errorColor,
              size: 64.w,
            ),
            Text(
              "Are you sure you want to Logout ?",
              style: font.body(
                context,
                fontWeight: FontWeight.bold,
              ),
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    completer(DialogResponse(confirmed: true));
                  },
                  child: Container(
                    height: 40.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryText,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Cancel',
                      style: font.body(
                        context,
                        color: context.colorScheme.card,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.logout().then((value) {
                      completer(DialogResponse(confirmed: true));
                    });
                  },
                  child: Container(
                    height: 40.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorScheme.card,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: context.colorScheme.errorColor,
                        width: 1.5.w,
                      ),
                    ),
                    child: Text(
                      'Log out',
                      style: font.body(
                        context,
                        color: context.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  LogoutDialogModel viewModelBuilder(BuildContext context) =>
      LogoutDialogModel();
}
