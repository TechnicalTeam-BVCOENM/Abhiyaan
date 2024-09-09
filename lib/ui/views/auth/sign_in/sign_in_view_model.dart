part of 'sign_in_view.dart';

class SignInViewModel extends BaseViewModel {
  final log = getLogger('AuthViewModel');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  // final SettingsViewModel settingsViewModel = SettingsViewModel();
  final PreferencesViewModel preferencesViewModel = PreferencesViewModel();
  final fontTheme = FontThemeClass();
  final showRegister = LocalStorageService().read("showRegister") ?? true;
  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final String emailIdErrorText = "Please enter a valid email id";
  final String passwordErrorText = "Please enter a valid email and password";

  bool isloading = false;
  bool isPasswordVisible = false;
  bool isEmailIdValid = true;
  bool isPasswordValid = true;

  void init() {
    _analyticsService.logScreen(screenName: 'SignInView');
  }

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

  Future<void> changePassword(context) async {
    emailIdTextController.text = emailIdTextController.text.trim();
    if (emailIdTextController.text.isEmpty) {
      showErrorMessage(context, "email field is empty");
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(emailIdTextController.text)) {
      showErrorMessage(
        context,
        "Invalid email format",
      );
    } else if (await RegisterViewModel()
        .checkEmailExists(emailIdTextController.text, context)) { 
      preferencesViewModel.passwordChangeAlert(
          context, emailIdTextController.text);
    } else {
      showErrorMessage(context, "User Not Found");
    }
  }

  Future<void> login(String email, String password, context) async {
    setBusy(true);
    FocusScope.of(context).requestFocus(FocusNode());
    if (email != "" && password != "") {
      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(emailIdTextController.text)) {
        showErrorMessage(
          context,
          "Invalid email format",
        );
      } else {
        try {
          // Show a loading indicator over your UI
          _authenticationService.showLoadingOverlay(context);
          _analyticsService.logSignUp(method: 'SignIn - Email');
          await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          _analyticsService.setUserProperties(
              userId: _firebaseAuth.currentUser!.uid);
          await _authenticationService.storeUserDataLocally();
          _navigationService.back();

          showSuccessMessage(
            context,
            "Login successful",
          );

          // await _authenticationService.checkPermission(Permission.appTrackingTransparency,context);

          await _navigationService.clearStackAndShow(Routes.bottomNavView);
        } on FirebaseAuthException catch (e) {
          isPasswordValid = false;
          isEmailIdValid = false;
          _navigationService.back();
          showErrorMessage(context, e.code);
          notifyListeners();
        }
      }
    } else {
      showErrorMessage(context, "Email or Password is empty");
    }
    setBusy(false);
  }

  void passwordResetMail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: "");
  }

  void onEmailAdressValueChanged() {
    
  }

  void navigateToHelpSupport() {
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
    // Navigation
  }

  void navigateToPrivacyPolicy() {
    _analyticsService.logEvent(
        eventName: "Privacy_policy", value: "Privacy policy button clicked");
    UrlLauncher externalUrlHandler = UrlLauncher();
    externalUrlHandler.launchURL("https://abhiyaan.tech/privacy-policy");
  }
}
