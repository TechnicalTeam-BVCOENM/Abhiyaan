part of '../settings/settings_view.dart';

Padding settingsListTile(
  SettingsViewModel model,
  BuildContext context, {
  String? title,
  Widget? trailingIcon,
  IconData? leadingIcon,
  Function? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      title: Text(
        title!,
        style: model.fontTheme.heading4(context),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      leading: Icon(
        leadingIcon!,
        size: 35.wWise,
        color: context.colorScheme.secondaryBlackColor,
      ),
      trailing: trailingIcon,
      tileColor: context.colorScheme.secondaryWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      visualDensity: VisualDensity(vertical: 4.hWise),
    ),
  );
}
