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
    if (dropDownValue == "Explorer") {
      misNo = "null";
    } else if (misNo == "" ||
        createpassword == "" ||
        confirmPassword == "" ||
        phoneNo == "" ||
        userName == "") {
      showErrorMessage(context, "some fields are empty!");
      return;
    }
    // Check MIS number only if the dropdown is not "explorer"
    else if (dropDownValue != "Explorer" &&
        !RegExp(r'^[0-9]{8}$').hasMatch(misNo)) {
      showErrorMessage(context, "MIS number should be an 8-digit number");
    }
    // Validate that create password and confirm password are the same
    else if (createpassword != confirmPassword) {
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
    else if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneNo)) {
      showErrorMessage(context, "Phone number should be a 10-digit number");
      return;
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(userName)) {
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
      "userProfile": dropDownValue,
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
