part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('SplashViewModel');

  void init() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    if (FirebaseAuth.instance.currentUser != null) {
      // signed in
      _navigationService.replaceWith(Routes.bottomNavView);
    } else {
      _navigationService.replaceWith(Routes.authView);

      // signed out
    }
  }
}
