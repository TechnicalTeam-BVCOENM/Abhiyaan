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
    final localStorageService = locator<LocalStorageService>();
    String storedEmail = localStorageService.read('userEmail');
    log.i(storedEmail);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: storedEmail)
          .then((value) => showNormalMessage(
                context,
                "reset password email sent !",
              ));
    } catch (e) {
      showErrorMessage(context, "something went wrong !");
    }

    // Change password logic
  }

  Future<void> changePasswordForSignin(context, String? email) async {
    setBusy(true);
    if (email == "" || email == null) {
      showErrorMessage(context, "Email Field Empty");
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      showErrorMessage(
        context,
        "Invalid email format",
      );
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email)
            .then((value) => showNormalMessage(
                  context,
                  "reset password email sent !",
                ));
      } catch (e) {
        showErrorMessage(context, "something went wrong !");
      }
    }
    setBusy(false);
    // Change password logic
  }

  void passwordChangeAlert(context, [String? email]) {
    FocusScope.of(context).requestFocus(FocusNode());

    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            clipBehavior: Clip.hardEdge,
            titlePadding: const EdgeInsets.all(0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(
                  height: 10,
                  thickness: 100,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 36,
                      ),
                      10.horizontalSpace,
                      const Text(
                        "Alert",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            content:
                const Text("Are you sure you want to change your password ?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: context.colorScheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 2, color: context.colorScheme.primaryColor),
                  padding: const EdgeInsets.all(0),
                  foregroundColor: context.colorScheme.secondaryBlackColor,
                  backgroundColor: context.colorScheme.secondaryWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    changePassword(context)
                        .then((value) => Navigator.pop(context));
                  } else {
                    changePasswordForSignin(context, email)
                        .then((value) => Navigator.pop(context));
                  }
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
    notifyListeners();
  }

  void logoutAlert(BuildContext context) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            clipBehavior: Clip.hardEdge,
            titlePadding: const EdgeInsets.all(0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(
                  height: 10,
                  thickness: 100,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 36,
                      ),
                      10.horizontalSpace,
                      const Text(
                        "Alert",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            content: SizedBox(
                width: 400.w,
                child: const Text("Are you sure you want to Logout ?")),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: context.colorScheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 2, color: context.colorScheme.primaryColor),
                  padding: const EdgeInsets.all(0),
                  foregroundColor: context.colorScheme.secondaryBlackColor,
                  backgroundColor: context.colorScheme.secondaryWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () async {
                  await logout(context).then((value) =>
                      showSuccessMessage(context, "Logout successful"));
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
      NavigationService().back();
      NavigationService().back();
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
