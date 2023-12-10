part of '../settings/settings_view.dart';

Padding settingsListTile(
  SettingsViewModel model,
  BuildContext context, {
  String? title,
  Widget? trailingIcon,
  String? leadingIcon,
  Function? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      title: Text(
        title!,
        style: model.fontTheme.heading4(context),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      leading: SizedBox(width: 35.w, child: Image.asset(leadingIcon!)),
      trailing: trailingIcon,
      tileColor: context.colorScheme.secondaryWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
  );
}
