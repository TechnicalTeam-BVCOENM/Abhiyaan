// import 'package:abhiyaan/file_exporter.dart';
// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/cupertino.dart';

// class PermissionRequestPopup  {
//   showPermissionRequestPopup(BuildContext context) {
//     showCupertinoDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Permission Request"),
//           content: const Text("Please grant the notification required permissions to get college updates."),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Later"),
//             ),
//             TextButton(
//               onPressed: () async {
//                  AppSettings.openAppSettings(
//                   asAnotherTask: true,
//                   type: AppSettingsType.notification,
//                 );
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Settings"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
