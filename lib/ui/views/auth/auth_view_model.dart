part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('auth_view');

  final showRegister = LocalStorageService().read("showRegister") ?? false;

  void toSignInPage(BuildContext context) {
    _navigationService.replaceWith(Routes.signInView);
  }

  void toRegisterPage(BuildContext context) {
    _navigationService.replaceWith(Routes.registerView);
  }

 
}
