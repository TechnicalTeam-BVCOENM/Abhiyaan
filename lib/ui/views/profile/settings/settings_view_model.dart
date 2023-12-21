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

  Future<void> changePassword(context) async {
    try {
      final localStorageService = locator<LocalStorageService>();
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: localStorageService.read('userEmail'))
          .then((value) => showmessage(context, "reset password email sent !",));
    } catch (e) {
      showmessage(context, "something went wrong !");
    }
    // Change password logic
  }

  void passwordChangeAlert(
    context,
  ) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert"),
            content:
                const Text("Are you sure you want to change your password ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  changePassword(context)
                      .then((value) => Navigator.pop(context));
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }

  void logoutAlert(BuildContext context) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert"),
            content: const Text("Are you sure you want to Logout ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  await logout(context).then(
                      (value) => showmessage(context, "Logout successful"));
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }

  navigateToHelpSupport() {
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
    // Navigation
  }

  navigateToPrivacyPolicy() {
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchURL(
        "https://docs.google.com/document/d/1WzwkIXbSMIBa-M2_ADZfPJmGa9CkvBjA2j847oVn6C8/edit?usp=sharing");
    // Navigation
  }

  Future<void> logout(BuildContext context) async {
    setBusy(true);
    LocalStorageService localStorageService = locator<LocalStorageService>();

    final bool success = await _authenticationService.signOut().then((value) {
      localStorageService.clear();
      return value;
    });
    if (success) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      log.i('sign out success');
      _navigationService.replaceWith(Routes.authView);
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
