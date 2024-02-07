part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final _storageService = locator<LocalStorageService>();

  final log = getLogger('auth_view');

  final showRegister = LocalStorageService().read("showRegister") ?? false;

  void init() async {
    await _analyticsService.logScreen(screenName: "Auth Screen");
    final bool value =
        await runBusyFuture(FirestoreService().showRegistration());
    await _storageService.write("showRegister", value);
  }

  void toSignInPage(BuildContext context) {
    _analyticsService.logEvent(
        eventName: "Auth_Screen", value: "SignIn Button clicked");
    _navigationService.replaceWith(Routes.signInView);
  }

  void toRegisterPage(BuildContext context) {
    _analyticsService.logEvent(
        eventName: "Auth_Screen", value: "Register Button clicked");
    _navigationService.replaceWith(Routes.registerView);
  }
}
