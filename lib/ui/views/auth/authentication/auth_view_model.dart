part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final log = getLogger('auth_view');
  final _navigation = locator<NavigationService>();
  final _analytic = locator<AnalyticsService>();
  final font = FontThemeClass();

  final List<String> onboardingText = ['Events', 'College Updates', 'Memories'];
  final List<String> story = [
    "College",
    "Events",
    "Memories",
    "Updates",
    "Highlights",
    "Achievements",
    "More",
  ];

  void init() {
    _analytic.logScreen(screenName: "Auth Screen");
  }

  void toSignInPage(BuildContext context) {
    try {
      _analytic.logEvent(
          eventName: "Auth_Screen", value: "SignIn Button clicked");
      _navigation.replaceWith(Routes.signInView);
    } on Exception catch (e) {
      log.e(e.toString());
    }
  }

  void toRegisterPage(BuildContext context) {
    try {
      _analytic.logEvent(
          eventName: "Auth_Screen", value: "Register Button clicked");
      _navigation.replaceWith(Routes.registerView);
    } on Exception catch (e) {
      log.e(e.toString());
    }
  }
}
