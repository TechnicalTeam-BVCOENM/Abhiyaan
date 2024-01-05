part of 'sign_in_view.dart';

class SignInViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _authenticationService = locator<AuthenticationService>();
  final SettingsViewModel settingsViewModel = SettingsViewModel();
  bool isloading = false;
  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();
  final showRegister = LocalStorageService().read("showRegister") ?? true;
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

  void changePassword(context) {
    settingsViewModel.passwordChangeAlert(context, emailIdTextController.text);
  }

  Future<void> login(String email, String password, context) async {
    setBusy(true);
    FocusScope.of(context).requestFocus(FocusNode());
    if (email != "" && password != "") {
      try {
        // Show a loading indicator over your UI
        _authenticationService.showLoadingOverlay(context);
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _authenticationService.storeUserDataLocally();
        _navigationService.back();
        showSuccessMessage(
          context,
          "Login successful",
        );
        await _navigationService.replaceWith(Routes.bottomNavView);
      } on FirebaseAuthException catch (e) {
        isPasswordValid = false;
        isEmailIdValid = false;
        _navigationService.back();
        showErrorMessage(context, e.code);
        notifyListeners();
      }
    } else {
      showErrorMessage(context, "Email or Password is empty");
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
