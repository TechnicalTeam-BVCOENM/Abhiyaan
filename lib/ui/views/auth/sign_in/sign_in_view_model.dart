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

          // Attempt to sign in with email and password
          await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Log the sign-in event with analytics
          await _analyticsService.logSignUp(method: 'SignIn - Email');

          // Set user properties for analytics
          await _analyticsService.setUserProperties(
            userId: _firebaseAuth.currentUser!.uid,
          );

          // Store user data locally
          await _authenticationService.storeUserDataLocally();

          // Close the loading indicator
          _navigationService.back();

          // Show success message
          showSuccessMessage(
            context,
            "Login successful",
          );

          // Navigate to the main view (clear the stack)
          await _navigationService.clearStackAndShow(Routes.bottomNavView);
        } on FirebaseAuthException catch (e) {
          // Close the loading indicator
          _navigationService.back();

          // Set flags to update UI (e.g., to show error messages or highlight input fields)
          isPasswordValid = false;
          isEmailIdValid = false;
          notifyListeners();

          // Show appropriate error message based on Firebase error code
          switch (e.code) {
            case 'invalid-email':
              showErrorMessage(context, "The email address is not valid.");
              break;
            case 'user-disabled':
              showErrorMessage(context, "This user account has been disabled.");
              break;
            case 'user-not-found':
              showErrorMessage(context, "No user found with this email.");
              break;
            case 'wrong-password':
              showErrorMessage(context, "The password is incorrect.");
              break;
            case 'network-request-failed':
              showErrorMessage(
                  context, "Network error. Please check your connection.");
              break;
            default:
              showErrorMessage(
                  context, "An unexpected error occurred: ${e.message}");
          }
        } catch (e) {
          // Handle any other errors (non-Firebase related)
          _navigationService.back(); // Close the loading indicator
          showErrorMessage(
              context, "An unexpected error occurred: ${e.toString()}");
        } finally {
          // Ensure the loading overlay is hidden, even if an error occurred
          _navigationService.back();
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

  void onEmailAdressValueChanged() {}

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
