part of 'register_view.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  String? signupStatus;

  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
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
    } else if (createpasswordTextController.text !=
        confirmpasswordTextController.text) {
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
    else if (userNameController.text[0] !=
        userNameController.text[0].toUpperCase()) {
      showErrorMessage(context, "Username should start with a capital letter");
      return;
    }

    // Check if MIS number contains only numbers and has a length of 8
    try {
      AuthenticationService().showLoadingOverlay(context);
      signupStatus = await _authenticationService.signUpWithEmailAndPassword(
          context,
          emailIdTextController.text,
          confirmpasswordTextController.text);
      if (signupStatus == "pass") {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({
          "userEmail": emailIdTextController.text,
          "userName": userNameController.text,
          "userProfile": 'Explorer',
          "isUserNew": true,
        });

        await AuthenticationService().storeUserDataLocally();
        // ignore: use_build_context_synchronously
        NavigationService().back();
        await _navigationService
            .replaceWithTransition(const OnboardingView(),
                transitionStyle: Transition.rightToLeftWithFade,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(milliseconds: 1500))
            ?.then((value) =>
                showSuccessMessage(context, "Registration successful"));
      } else {
        NavigationService().back();
      }
    } catch (e) {
      debugPrint("$e");
    }
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
          return SizedBox(
              child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            clipBehavior: Clip.hardEdge,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.verified_rounded,
                  color: Color.fromARGB(255, 54, 244, 76),
                  size: 100,
                )
                    .animate(
                      delay: 300.ms,
                    )
                    .shimmer(
                      padding: 0,
                      delay: 200.ms,
                      duration: 700.ms,
                    ),
                10.verticalSpace,
                const Text(
                  "Verification",
                )
                    .animate(
                      delay: 100.ms,
                    )
                    .fadeIn(
                      delay: 100.ms,
                      duration: 700.ms,
                    ),
              ],
            ),
            content: Builder(builder: (context) {
              return SizedBox(
                width: 1000.w,
                height: 140.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Enter five digit code we have sent to your email address !",
                      textAlign: TextAlign.center,
                    )
                        .animate(
                          delay: 100.ms,
                        )
                        .fadeIn(
                          delay: 100.ms,
                          duration: 700.ms,
                        ),
                    10.verticalSpace,
                    Pinput(
                      length: 5,
                      defaultPinTheme: PinTheme(
                        margin: const EdgeInsets.only(left: 2),
                        height: 75.h,
                        width: 75.w,
                        textStyle: const TextStyle(fontSize: 22),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.circular(10)),
                      ),

                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,
                      onChanged: (value) {
                        otpController.text = value;
                      },
                      showCursor: true,
                      // ignore: avoid_print
                      onCompleted: (pin) => print(pin),
                    ),
                  ],
                ),
              );
            }),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: context.colorScheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              )
                  .animate(
                    delay: 500.ms,
                  )
                  .fadeIn(
                    delay: 100.ms,
                    duration: 700.ms,
                  ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 2, color: context.colorScheme.primaryColor),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  foregroundColor: context.colorScheme.secondaryBlackColor,
                  backgroundColor: context.colorScheme.secondaryWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () {},
                child: const Text("verify"),
              )
                  .animate(
                    delay: 800.ms,
                  )
                  .fadeIn(
                    delay: 100.ms,
                    duration: 700.ms,
                  ),
            ],
          )
                  .animate(
                    delay: 100.ms,
                  )
                  .fadeIn(
                    duration: 400.ms,
                  ));
        });
  }
}
