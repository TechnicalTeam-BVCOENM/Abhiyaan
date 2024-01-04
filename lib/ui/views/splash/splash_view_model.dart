part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final log = getLogger('SplashViewModel');
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<LocalStorageService>();
  void init() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    if (FirebaseAuth.instance.currentUser != null) {
      _navigationService.replaceWith(Routes.bottomNavView);
    } else {
      final bool value = await FirestoreService().showRegistration();
      _storageService.write("showRegister", value);
      _navigationService.replaceWith(Routes.authView);
    }
  }

  // Future<bool> showRegistration() async {
  //   final value = await locator<FirestoreService>().showRegistration();
  //   return value;
  // }
}
