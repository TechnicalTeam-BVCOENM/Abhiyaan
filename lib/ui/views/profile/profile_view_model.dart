part of 'profile_view.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('SplashViewModel');

  navigateToSettingsView() {
    _navigationService.navigateTo(Routes.settingsView);
  }
}
