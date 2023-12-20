part of 'register_view.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController misnoTextController = TextEditingController();
  final TextEditingController createpasswordTextController =
      TextEditingController();
  final TextEditingController confirmpasswordTextController =
      TextEditingController();

  final ValueNotifier<String> dropdownValueNotifier =
      ValueNotifier<String>('Select');

  String get dropdownValue => dropdownValueNotifier.value;

  set dropdownValue(String value) {
    dropdownValueNotifier.value = value;
    notifyListeners(); // Notify listeners when the value changes
  }

  final String emailIdErrorText = "Please enter a valid email id";

  bool isCreatePasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isEmailIdValid = true;

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
    String dropdownValue,
    String misNo,
    BuildContext context,
  ) async {
    // Validate email format
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      showmessage(context, "Invalid email format");
      return;
    }

    // Validate that create password and confirm password are the same
    if (createpassword != confirmPassword) {
      showmessage(context, "Passwords do not match");
      return;
    }
    await _authenticationService.signUpWithEmailAndPassword(
        context, email, confirmPassword);

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({"userMisNo": misNo});

    //  Notify listeners if needed
    notifyListeners();
    // ignore: use_build_context_synchronously
    showmessage(context, "Registration successful");
    await AuthenticationService().storeUserDataLocally();
    await _navigationService.replaceWith(Routes.onboardingView);
  }

  navigateToHelpSupport() async {
    UrlLauncher externalUrlHandler = UrlLauncher();
    await externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
    // Navigation
  }

  navigateToSignIn() async {
    _navigationService.replaceWith(Routes.signInView);
  }
}

class ToggleModel extends ChangeNotifier {
  bool isBvcoeStudent = true;
  String misNo = '';

  void toggleSelection() {
    isBvcoeStudent = !isBvcoeStudent;
    misNo = '';
    notifyListeners();
  }

  void updateMisNo(String newMisNo) {
    misNo = newMisNo;
    notifyListeners();
  }
}

const List<String> list = <String>['BVCOE Student', 'Explorer'];
