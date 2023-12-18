part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void toSignInPage(BuildContext context) {
    _navigationService.navigateTo(Routes.signInView);
  }

  void toRegisterPage(BuildContext context) {
    _navigationService.navigateTo(Routes.onboardingView);
  }
}
