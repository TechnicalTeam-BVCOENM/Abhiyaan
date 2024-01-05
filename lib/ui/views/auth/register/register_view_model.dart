part of 'register_view.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController createpasswordTextController =
      TextEditingController();
  final TextEditingController confirmpasswordTextController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();

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
    BuildContext context,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (createpasswordTextController.text == "" ||
        confirmpasswordTextController.text == "" ||
        emailIdTextController.text == "" ||
        userNameController.text == "") {
      showErrorMessage(context, "some fields are empty!");
      return;
    } else if (createpasswordTextController.text != confirmpasswordTextController.text) {
      showErrorMessage(context, "Passwords do not match");
      return;
    }
    // Validate email format
    else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(emailIdTextController.text)) {
      showErrorMessage(
        context,
        "Invalid email format",
      );
      return;
    } // Check if phone number contains only numbers and has a length of 10
    else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(userNameController.text)) {
      showErrorMessage(context, "Username should contain only alphabets");
      return;
    }

// Check if the first letter of the username is capitalized
    else if (userNameController.text[0] != userNameController.text[0].toUpperCase()) {
      showErrorMessage(context, "Username should start with a capital letter");
      return;
    }

    // Check if MIS number contains only numbers and has a length of 8

    AuthenticationService().showLoadingOverlay(context);
    await _authenticationService.signUpWithEmailAndPassword(
        context,  emailIdTextController.text, confirmpasswordTextController.text);

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "userEmail":  emailIdTextController.text,
      "userName": userNameController.text,
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

  void verifyEmailDialogue(context) {
    FocusScope.of(context).requestFocus(FocusNode());

    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            clipBehavior: Clip.hardEdge,
            titlePadding: const EdgeInsets.all(0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(
                  height: 10,
                  thickness: 100,
                  color: Color.fromARGB(255, 54, 244, 76),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        color: Color.fromARGB(255, 54, 244, 76),
                        size: 36,
                      ),
                      10.horizontalSpace,
                      const Text(
                        "Alert",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            content:
                const Text("Are you sure you want to change your password ?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: context.colorScheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 2, color: context.colorScheme.primaryColor),
                  padding: const EdgeInsets.all(0),
                  foregroundColor: context.colorScheme.secondaryBlackColor,
                  backgroundColor: context.colorScheme.secondaryWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () {},
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }
}
