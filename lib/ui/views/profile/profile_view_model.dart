part of 'profile_view.dart';

class ProfileViewModel extends BaseViewModel {
  final log = getLogger('ProfileView');
  final _analyticsService = locator<AnalyticsService>();
  final _navigationService = locator<NavigationService>();
  final localStorageService = locator<LocalStorageService>();
  final _themeService = locator<ThemeService>();

  navigateToHelpSupport() {
    _analyticsService.logEvent(
        eventName: "Help_support", value: "Help and support button clicked");
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
  }

  navigateToPrivacyPolicy() {
    _analyticsService.logEvent(
        eventName: "Privacy_policy", value: "Privacy policy button clicked");
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchURL("https://abhiyaan.tech/privacy-policy");
  }

  navigateToProfileDetails() {
    _navigationService.navigateToPreferencesView();
  }

  Future init() async {
    _analyticsService.logScreen(screenName: 'Profile Screen Opened');
    await runBusyFuture(Future.delayed(const Duration(milliseconds: 500)));
  }

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

  changeTheme() async {
    _analyticsService.logEvent(
        eventName: "Dark_mode", value: "Dark mode toggle button clicked");
    _themeService.updateTheme();
    notifyListeners();
  }
}
