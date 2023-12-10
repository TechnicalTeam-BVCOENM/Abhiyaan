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

  List<ProfileDetailsCard> allProfileCards = [
    ProfileDetailsCard(
      leading: AssetImagePath.misImg,
      title: "MIS Number",
      value: LocalStorageService().read('userMisNo'),
    ),
    ProfileDetailsCard(
      leading: AssetImagePath.libraryImg,
      title: "Library Card Number",
      value: LocalStorageService().read('userLibNo'),
    ),
    ProfileDetailsCard(
      leading: AssetImagePath.idImg,
      title: "College ID",
      value: LocalStorageService().read('userCollegeId'),
    ),
    ProfileDetailsCard(
      leading: AssetImagePath.prnImg,
      title: "PRN Number",
      value: LocalStorageService().read('userPrnNo'),
    ),
  ];
}
