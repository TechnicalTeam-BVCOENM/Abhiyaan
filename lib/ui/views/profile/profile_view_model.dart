part of 'profile_view.dart';

// Profile View Model
class ProfileViewModel extends BaseViewModel {
  final log = getLogger('ProfileView');
  final _analyticsService = locator<AnalyticsService>();
  final _navigationService = locator<NavigationService>();
  final localStorageService = locator<LocalStorageService>();
  final _themeService = locator<ThemeService>();

  final inAppReview = InAppReview.instance;
  // User Data Tags for the Profile View Page
  List<String> userStorageTag = [
    "userCollegeId",
    "userLibNo",
    "userMisNo",
    "userName",
    "userPrnNo",
    "userYear",
  ];
  List<String> userUiTag = [
    "MIS Number",
    "Library Card Number",
    "College ID",
    "PRN Number",
  ];
  List<String> iconImages = [
    "misImg",
    "libraryImg",
    "idImg",
    "prnImg",
  ];

  // Initialization Function for the Profile View Page
  Future init() async {
    _analyticsService.logScreen(screenName: 'Profile Screen Opened');
    await runBusyFuture(Future.delayed(const Duration(milliseconds: 500)));
  }

  // Navigation Functions for the Profile View Page
  void navigateToHelpSupport() {
    _analyticsService.logEvent(
        eventName: "Help_support", value: "Help and support button clicked");
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchEmail("thedevcrew.bvcoenm@gmail.com");
  }

  void navigateToPrivacyPolicy() {
    _analyticsService.logEvent(
        eventName: "Privacy_policy", value: "Privacy policy button clicked");
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchURL("https://abhiyaan.tech/privacy-policy");
  }

  void navigateToProfileDetails() {
    _navigationService.navigateToPreferencesView();
  }

//Dark Mode Toggle Function for the Profile View Page
  void changeTheme() {
    _analyticsService.logEvent(
        eventName: "Dark_mode", value: "Dark mode toggle button clicked");
    _themeService.updateTheme();
    notifyListeners();
  }

// Rate App Function for the Profile View Page
  Future<void> rateApp(context) async {
    if (await inAppReview.isAvailable()) {
      log.i("hi");
      try {
        final int androidVersion = int.parse(
            Platform.operatingSystemVersion.split(' ')[0].split('.')[0]);
        if (androidVersion >= 10) {
          await inAppReview.requestReview();
        } else {
          await inAppReview.openStoreListing(
            appStoreId: 'com.bvcoenm.abhiyaan',
          );
        }
      } catch (e) {
        await inAppReview.openStoreListing();
      }
    } else {
      showErrorMessage(context, "InAppReview not available.");
    }
  }
}
