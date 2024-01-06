import 'package:abhiyaan/file_exporter.dart';
import 'package:app_settings/app_settings.dart';

class PermissionRequestPopup  {
  showPermissionRequestPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Permission Request"),
          content: const Text("Please grant the required permissions to continue"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                 AppSettings.openAppSettings(
                  asAnotherTask: true,
                  type: AppSettingsType.notification,
                );
                Navigator.of(context).pop();
              },
              child: const Text("Settings"),
            ),
          ],
        );
      },
    );
  }
}
