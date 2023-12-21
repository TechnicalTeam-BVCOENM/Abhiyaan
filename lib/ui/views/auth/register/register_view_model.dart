part of 'register_view.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  String dropDownValue = list.first;

  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController misnoTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController createpasswordTextController =
      TextEditingController();
  final TextEditingController confirmpasswordTextController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final ValueNotifier<String> dropdownValueNotifier =
      ValueNotifier<String>('Select');

  String get dropdownValue => dropdownValueNotifier.value;
  changeDropDown(String? value) {
    dropDownValue = value!;
    notifyListeners();
  }

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
    String phoneNo,
    String userName,
    BuildContext context,
  ) async {
    // Validate email format
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      showErrorMessage(context, "Invalid email format");
      return;
    }
    if (misNo == "" ||
        createpassword == "" ||
        confirmPassword == "" ||
        phoneNo == "" ||
        userName == "") {
      showErrorMessage(context, "some fields are empty!");
      return;
    }

    // Validate that create password and confirm password are the same
    if (createpassword != confirmPassword) {
      showErrorMessage(context, "Passwords do not match");
      return;
    }
    AuthenticationService().showLoadingOverlay(context);
    await _authenticationService.signUpWithEmailAndPassword(
        context, email, confirmPassword);

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "userMisNo": misNo,
      "userEmail": email,
      "userPhone": phoneNo,
      "userName": userName,
          "isUserNew": true,
    });


    await AuthenticationService().storeUserDataLocally();
    // ignore: use_build_context_synchronously
    NavigationService().back();
    await _navigationService
        .navigateWithTransition(const OnboardingView(),
            transitionStyle: Transition.rightToLeftWithFade,
            curve: Curves.easeInOutQuad,
            duration: const Duration(milliseconds: 400))
        ?.then((value) => showSuccessMessage(context, "Registration successful"));
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

List<String> list = <String>['BVCOE Student', 'Explorer'];
