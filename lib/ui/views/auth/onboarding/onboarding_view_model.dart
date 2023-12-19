part of 'onboarding_view.dart';

class OnboardingViewModel extends BaseViewModel {
  final log = getLogger('onboardingViewModel');
  PageController pageController = PageController();
  final _navigationService = locator<NavigationService>();
  int activeindex = 0;
  void updateindex(BuildContext context, bool increment, int index) {
    if (increment && index != 2) {
      activeindex = activeindex + 1;
      pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutQuad);
    } else if (!increment && index != 0) {
      activeindex = activeindex - 1;
      pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutQuad);
    } else if (increment && index == 2) {
      _navigationService.replaceWith(Routes.bottomNavView);
    }
    notifyListeners();
  }

  void index(int index) {
    activeindex = index;
    notifyListeners();
  }
}
