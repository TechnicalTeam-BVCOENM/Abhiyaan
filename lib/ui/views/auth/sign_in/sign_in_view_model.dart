part of 'sign_in_view.dart';

class SignInViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  bool isloading = false;
  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final String emailIdErrorText = "Please enter a valid email id";
  final String passwordErrorText = "Please enter a valid email and password";

  bool isPasswordVisible = false;
  bool isEmailIdValid = true;
  bool isPasswordValid = true;

  bool togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
    return isPasswordVisible;
  }

  void toHomePage(BuildContext context) {
    _navigationService.navigateTo(Routes.bottomNavView);
  }

  void toRegisterPage(BuildContext context) {
    _navigationService.replaceWith(Routes.registerView);
  }

  Future<void> login(String email, String password, context) async {
    setBusy(true);

    try {
      // Show a loading indicator over your UI
      AuthenticationService().showLoadingOverlay(context);
      await _authenticationService.signInWithEmailAndPassword(email, password);
      await AuthenticationService().storeUserDataLocally();
      NavigationService().back();
      showSuccessMessage(
        context,
        "Login successful",
      );
      _navigationService.replaceWith(Routes.bottomNavView);
    } on FirebaseException {
      isPasswordValid = false;
      isEmailIdValid = false;
      NavigationService().back();
      notifyListeners();
      // Handle Firebase exceptions here
    }

    setBusy(false);
  }

  void passwordResetMail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: "");
  }

  void navigateToHelpSupport() {
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
    // Navigation
  }
}
