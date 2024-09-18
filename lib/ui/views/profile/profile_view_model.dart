part of 'profile_view.dart';

// Profile View Model
class ProfileViewModel extends BaseViewModel {
  final InAppReview inAppReview = InAppReview.instance;
  final log = getLogger('ProfileView');
  final _analyticsService = locator<AnalyticsService>();
  final _navigationService = locator<NavigationService>();
  final localStorageService = locator<LocalStorageService>();
  final _themeService = locator<ThemeService>();
  final fontTheme = FontThemeClass();

  // Navigation Functions for the Profile View Page
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

  // Initialization Function for the Profile View Page
  Future init() async {
    _analyticsService.logScreen(screenName: 'Profile Screen Opened');
    await runBusyFuture(Future.delayed(const Duration(milliseconds: 500)));
  }

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

//Dark Mode Toggle Function for the Profile View Page
  changeTheme(BuildContext context) async {
    _analyticsService.logEvent(
        eventName: "Dark_mode", value: "Dark mode toggle button clicked");
    _themeService.updateTheme();

    notifyListeners();
  }


// Rate App Function for the Profile View Page
  Future<void> rateApp() async {

    if (await inAppReview.isAvailable()) {
      log.i("hi");
      try {
        final int androidVersion = int.parse(
            Platform.operatingSystemVersion.split(' ')[0].split('.')[0]);
        if (androidVersion >= 10) {
          // Attempt to request the in-app review
          await inAppReview.requestReview();
//           showSuccessMessage(context, "Requested in-app review");
        } else {
          await inAppReview.openStoreListing(
            appStoreId:
                'com.bvcoenm.abhiyaan', // Replace with your actual Play Store app ID
          );
//           showSuccessMessage(context, "Opened Play Store for older device");
        }
      } catch (e) {
        await inAppReview.openStoreListing();
      }
    } else {
      showSuccessMessage(context, "InAppReview not available.");
    }
  }
}
