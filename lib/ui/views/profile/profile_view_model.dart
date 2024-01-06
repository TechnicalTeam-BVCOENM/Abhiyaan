part of 'profile_view.dart';

class ProfileViewModel extends BaseViewModel {
  final log = getLogger('ProfileView');
  final _analyticsService = locator<AnalyticsService>();
  final _navigationService = locator<NavigationService>();
  final localStorageService = locator<LocalStorageService>();

  navigateToSettingsView() {
    _navigationService.navigateTo(Routes.settingsView);
  }

  void init() {
    _analyticsService.logScreen(screenName: 'Profile Screen Opened');
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

  List<ProfileDetailsCard> profileCardList = [
    LocalStorageService().read('userProfile') == "Explorer"
        ? const ProfileDetailsCard(
            leading: AssetImagePath.misImg,
            title: "MIS Number",
            value: "",
            icon: Icons.content_copy,
          )
        : LocalStorageService().read('userProfile') == "Faculty"
            ? const ProfileDetailsCard(
                leading: AssetImagePath.misImg,
                title: "MIS Number",
                value: "",
                icon: Icons.content_copy,
              )
            : ProfileDetailsCard(
                leading: AssetImagePath.misImg,
                title: "MIS Number",
                value: LocalStorageService().read('userMisNo').toString(),
                icon: Icons.content_copy,
              ),
    ProfileDetailsCard(
      leading: AssetImagePath.emailImg,
      title: "Email ID",
      value: LocalStorageService().read('userEmail'),
      icon: Icons.content_copy,
    ),
  ];
}
