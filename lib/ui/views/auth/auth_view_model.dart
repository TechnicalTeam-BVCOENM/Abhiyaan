part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('AuthViewModel');

  void toHomePage(BuildContext context) {
    _navigationService.navigateTo(Routes.homeView);
  }
}
