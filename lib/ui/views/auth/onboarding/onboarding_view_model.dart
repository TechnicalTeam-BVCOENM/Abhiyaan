part of 'onboarding_view.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  int activeindex = 0;
  void updateindex(bool increment, int index) {
    if (increment && index != 2) {
      activeindex = activeindex + 1;
    } else if (!increment && index != 0) {
      activeindex = activeindex - 1;
    } else if (increment && index == 2) {
      _navigationService.navigateTo(Routes.bottomNavView);
    } else if (!increment && index == 0) {
      _navigationService.back();
    }
    notifyListeners();
  }
}
