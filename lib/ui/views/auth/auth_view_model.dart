part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  final log = getLogger('auth_view');

  final showRegister = LocalStorageService().read("showRegister") ?? true;

  void init() async{
   await _analyticsService.logScreen(screenName: "Auth Screen");
  }

  void toSignInPage(BuildContext context) {
    _analyticsService.logEvent(
        eventName: "Auth Screen", value: "SignIn Button clicked");
    _navigationService.replaceWith(Routes.signInView);
  }

  void toRegisterPage(BuildContext context) {
    _analyticsService.logEvent(
        eventName: "Auth Screen", value: "Register Button clicked");
    _navigationService.replaceWith(Routes.registerView);
  }
}
