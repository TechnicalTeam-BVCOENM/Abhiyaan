part of '../settings/settings_view.dart';

class SettingsViewModel extends BaseViewModel {
  final log = getLogger('SettingsView');
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final _themeService = locator<ThemeService>();

  navigateToProfile() {
    _navigationService.replaceWith(Routes.profileView);
  }

  final fontTheme = FontThemeClass();
  Color blue = Colors.blue;
  var isDark = false;
  changeTheme() async {
    _themeService.updateTheme();
    notifyListeners();
  }

  changePassword(context) {
    final localStorageService = locator<LocalStorageService>();
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: localStorageService.read('userEmail'))
        .then((value) => showmessage(context, "reset password email sent !"))
        .onError((error, stackTrace) =>
            showmessage(context, "something went wrong !"));
    // Change password logic
  }

  navigateToHelpSupport() {
    // Navigation
  }
  navigateToPrivacyPolicy() {
    // Navigation
  }
  Future<void> logout() async {
    setBusy(true);
    final success = await _authenticationService.signOut();
    if (success) {
      log.i('sign out success');
      _navigationService.clearStackAndShow(Routes.authView);
    } else {
      log.i('sign out failed');
    }
    setBusy(false);
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
