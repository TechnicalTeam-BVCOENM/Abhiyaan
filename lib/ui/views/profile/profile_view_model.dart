part of 'profile_view.dart';

class ProfileViewModel extends BaseViewModel {
  final log = getLogger('ProfileView');
  final _navigationService = locator<NavigationService>();
  final localStorageService = locator<LocalStorageService>();

  navigateToSettingsView() {
    _navigationService.navigateTo(Routes.settingsView);
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
    ProfileDetailsCard(
      leading: AssetImagePath.misImg,
      title: "MIS Number",
      value: LocalStorageService().read('userMisNo'),
      icon: Icons.content_copy,
    ),
    ProfileDetailsCard(
      leading: AssetImagePath.emailImg,
      title: "Email ID",
      value: LocalStorageService().read('userEmail'),
      icon: Icons.content_copy,
    ),
    ProfileDetailsCard(
      leading: AssetImagePath.phoneImg,
      title: "Mobile Number",
      value: LocalStorageService().read('userPhone'),
      icon: Icons.content_copy,
    ),
    ProfileDetailsCard(
      leading: AssetImagePath.certificateImg,
      title: "Certifications",
      value: LocalStorageService().read('userCertifications'),
      icon: Icons.navigate_next,
    ),
  ];
}
