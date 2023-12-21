part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('auth_view');

  void toSignInPage(BuildContext context) {
    _navigationService.replaceWith(Routes.signInView);
  }

  void toRegisterPage(BuildContext context) {
    _navigationService.navigateWithTransition(const RegisterView(),
        transitionStyle: Transition.rightToLeftWithFade,
        curve: Curves.fastEaseInToSlowEaseOut,
        duration: const Duration(milliseconds: 1500));
  }
}
