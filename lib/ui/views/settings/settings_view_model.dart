part of '../settings/settings_view.dart';

class SettingsViewModel extends BaseViewModel {
  final log = getLogger('SettingsView');
  final _navigationService = locator<NavigationService>();

  navigateToProfile() {
    _navigationService.replaceWith(Routes.profileView);
  }

  final fontTheme = FontThemeClass();
  Color blue = Colors.blue;
  var isDark = false;
  changeTheme() {
    isDark = !isDark;
    // Theme changing logic
    rebuildUi();
  }

  changePassword() {
    // Change password logic
  }
  navigateToHelpSupport() {
    // Navigation
  }
  navigateToPrivacyPolicy() {
    // Navigation
  }
  logout() {
    // Logout Logic
  }

  List<SettingsModel> settings = [
    SettingsModel(
      title: 'Dark mode',
      leading: Icons.brightness_2_outlined,
    ),
    SettingsModel(
      title: 'Change Password',
      leading: Icons.lock_outline_rounded,
    ),
    SettingsModel(
      title: 'Help & Support',
      leading: Icons.support_agent_rounded,
    ),
    SettingsModel(
      title: 'Privacy Policy',
      leading: Icons.security_rounded,
    ),
    SettingsModel(
      title: 'Logout',
      leading: Icons.logout,
    )
  ];
}

class SettingsModel {
  late String title;
  IconData trailing = Icons.arrow_forward_ios;
  late IconData leading;
  SettingsModel({required this.title, required this.leading});
}
