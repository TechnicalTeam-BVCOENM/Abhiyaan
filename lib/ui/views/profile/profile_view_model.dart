part of 'profile_view.dart';

class ProfileViewModel extends BaseViewModel {
  final log = getLogger('ProfileView');
  final _navigationService = locator<NavigationService>();

  navigateToSettingsView() {
    _navigationService.navigateTo(Routes.settingsView);
  }
}
