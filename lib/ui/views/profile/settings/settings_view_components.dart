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
    padding: const EdgeInsets.symmetric(vertical: 10).r,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20).r,
      title: Text(
        title!,
        style: model.fontTheme.body(context,
            color: context.colorScheme.secondaryBlackColor,
            fontWeight: FontWeight.w500),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      leading: Icon(
        leadingIcon,
        weight: 30.w,
        size: 30.sp,
        color: context.colorScheme.primaryColor,
      ),
      trailing: trailingIcon,
      tileColor: context.colorScheme.secondaryWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.sp),
      ),
      visualDensity: const VisualDensity(vertical: 4),
    ),
  );
}
