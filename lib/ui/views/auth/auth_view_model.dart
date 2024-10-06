part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final log = getLogger('auth_view');
  final _navigation = locator<NavigationService>();
  final _analytic = locator<AnalyticsService>();

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

  Future<void> toSignInPage(BuildContext context) async {
    try {
      _analytic.logEvent(
          eventName: "Auth_Screen", value: "SignIn Button clicked");
      await _navigation.navigateTo(Routes.signInView);
    } on Exception catch (e) {
      log.e(e.toString());
    }
  }

  void toRegisterPage(BuildContext context) async {
    try {
      _analytic.logEvent(
          eventName: "Auth_Screen", value: "Register Button clicked");
      await _navigation.navigateTo(Routes.registerView);
    } on Exception catch (e) {
      log.e(e.toString());
    }
  }
}
