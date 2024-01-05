part of 'register_view.dart';

class RegisterViewModel extends BaseViewModel {
  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController createpasswordTextController =
      TextEditingController();
  final TextEditingController confirmpasswordTextController =
      TextEditingController();

  final String emailIdErrorText = "Please enter a valid email id";
  bool isCreatePasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isEmailIdValid = true;

  void init() {
    _analyticsService.logScreen(screenName: 'RegisterView');
  }

  bool toggleCreatePasswordVisibility() {
    isCreatePasswordVisible = !isCreatePasswordVisible;
    notifyListeners();
    return isCreatePasswordVisible;
  }

  bool toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
    return isConfirmPasswordVisible;
  }

  Future<void> register(
    String email,
    String createpassword,
    String confirmPassword,
    String userName,
    BuildContext context,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (createpassword == "" ||
        confirmPassword == "" ||
        email == "" ||
        userName == "") {
      showErrorMessage(context, "some fields are empty!");
      return;
    } else if (createpassword != confirmPassword) {
      showErrorMessage(context, "Passwords do not match");
      return;
    }
    // Validate email format
    else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      showErrorMessage(
        context,
        "Invalid email format",
      );
      return;
    } // Check if phone number contains only numbers and has a length of 10
    else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(userName)) {
      showErrorMessage(context, "Username should contain only alphabets");
      return;
    }

// Check if the first letter of the username is capitalized
    else if (userName[0] != userName[0].toUpperCase()) {
      showErrorMessage(context, "Username should start with a capital letter");
      return;
    }

    // Check if MIS number contains only numbers and has a length of 8

    AuthenticationService().showLoadingOverlay(context);

    _analyticsService.logSignUp(method: 'Register - Email');

    await _authenticationService.signUpWithEmailAndPassword(
        context, email, confirmPassword);
    _analyticsService.setUserProperties(
        userId: FirebaseAuth.instance.currentUser!.uid);

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "userEmail": email,
      "userName": userName,
      "userProfile": 'Explorer',
      "isUserNew": true,
    });

    await AuthenticationService().storeUserDataLocally();
    // ignore: use_build_context_synchronously
    NavigationService().back();
    _navigationService
        .replaceWithTransition(const OnboardingView(),
            transitionStyle: Transition.rightToLeftWithFade,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 1500))
        ?.then(
            (value) => showSuccessMessage(context, "Registration successful"));
    notifyListeners();
  }

  navigateToHelpSupport() async {
    UrlLauncher externalUrlHandler = UrlLauncher();
    await externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
  }

  navigateToSignIn() async {
    _navigationService.replaceWith(Routes.signInView);
  }
}
