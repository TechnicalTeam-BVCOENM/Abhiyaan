part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final List<String> onboardingText = ['Events', 'College Updates', 'Memories'];
  ValueNotifier<String> onboardingTextNotifier =
      ValueNotifier<String>('Events');

  final log = getLogger('auth_view');

  final showRegister = LocalStorageService().read("showRegister") ?? false;
  final List<String> story = [
    "College",
    "Events",
    "Memories",
    "Updates",
    "Highlights",
  ];

  void init() async {
    await _analyticsService.logScreen(screenName: "Auth Screen");
    updateOnboardingText();
  }

  void updateOnboardingText() {
    int i = 0;
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        i = (i + 1) % onboardingText.length;
        onboardingTextNotifier.value = onboardingText[i];
        notifyListeners();
      },
    );
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
