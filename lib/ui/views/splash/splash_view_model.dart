part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final log = getLogger('SplashViewModel');
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<LocalStorageService>();

  void init() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    final bool value =
        await runBusyFuture(FirestoreService().showRegistration());
    await _storageService.write("showRegister", value);

    if (FirebaseAuth.instance.currentUser != null) {
      _navigationService.clearStackAndShow(Routes.bottomNavView);
    } else {
      // final bool value = await FirestoreService().showRegistration();
      // _storageService.write("showRegister", value);
      _navigationService.clearStackAndShow(Routes.authView);
    }
  }

  // Future<bool> showRegistration() async {
  //   final value = await locator<FirestoreService>().showRegistration();
  //   return value;
  // }
}
