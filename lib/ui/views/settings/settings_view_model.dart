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
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchURL("https://bvcoenm.edu.in/contact-us/");
    // Navigation
  }

  navigateToPrivacyPolicy() {
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchURL("");
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
      leading: AssetImagePath.darkMode,
    ),
    SettingsModel(
      title: 'Change Password',
      leading: AssetImagePath.pass,
    ),
    SettingsModel(
      title: 'Help & Support',
      leading: AssetImagePath.help,
    ),
    SettingsModel(
      title: 'Privacy Policy',
      leading: AssetImagePath.privacy,
    ),
    SettingsModel(
      title: 'Logout',
      leading: AssetImagePath.logout,
    )
  ];
}

class SettingsModel {
  late String title;
  IconData trailing = Icons.arrow_forward_ios;
  late String leading;
  SettingsModel({required this.title, required this.leading});
}
