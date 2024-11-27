// ignore_for_file: use_build_context_synchronously

part of 'register_view.dart';

final Random random = Random();
int min = 10000; // Minimum value for a 5-digit number
int max = 99999; // Maximum value for a 5-digit number

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final TextEditingController userNameController = TextEditingController();
  String? signupStatus;
  late int otp;
  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();
  final smtpServer =
      gmail("technicalteam.bvcoenm@gmail.com", "wqme jjtx lerr zkkg");
  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController createpasswordTextController =
      TextEditingController();
  final TextEditingController confirmpasswordTextController =
      TextEditingController();

  final String emailIdErrorText = "Please enter a valid email id";
  final localStorageService = locator<LocalStorageService>();
  int? sendOtpCount = LocalStorageService().read('sendOtpCount');
  DateTime? lastUpdate = LocalStorageService().read("lastOtpCountUpdate");

  bool isCreatePasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isEmailIdValid = true;
  bool shouldShowUI = false;

  void init() async {
    setBusy(true);
    _analyticsService.logScreen(screenName: 'RegisterView');
    await _shouldRenderUI();
    setBusy(false);
  }

  Future<void> _shouldRenderUI() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('AppCheck')
        .doc("showRegistration")
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      shouldShowUI = data?['value'] ?? false;
    }
    notifyListeners();
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

  void generateRandomOTP() {
    otp = min + random.nextInt(max - min + 1);
  }

  Future<void> register(
    context,
  ) async {
    emailIdTextController.text = emailIdTextController.text.trim();
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_areFieldsFilled()) {
      showErrorMessage(context, "Fields are empty!");
      return;
    }
    if (!_isEmailValid()) {
      showErrorMessage(context, "Invalid email format");
      return;
    }
    if (!_isUsernameValid()) {
      showErrorMessage(context, "Username should contain only alphabets");
      return;
    }
    if (!_isUsernameCapitalized()) {
      showErrorMessage(context, "Username should start with a capital letter");
      return;
    }
    if (!_arePasswordsMatching()) {
      showErrorMessage(context, "Passwords do not match");
      return;
    }
    if (!_isPasswordStrong()) {
      showErrorMessage(context,
          "Password must be at least 8 characters long, contain letters and digits");
      return;
    }
    if (await checkEmailExists(emailIdTextController.text, context)) {
      showErrorMessage(context, "Email Already Exists");
      return;
    }

    await _handleOtpLogic(context);
  }

  Future<void> _handleOtpLogic(BuildContext context) async {
    DateTime now = DateTime.now();

    if (lastUpdate != null) {
      Duration difference = now.difference(lastUpdate!);
      if (difference.inHours >= 24) {
        await _resetOtpCount(now);
      }
    }

    if (sendOtpCount == null) {
      await _initializeOtpCount(now, context);
    } else if (sendOtpCount == 0) {
      showErrorMessage(context, "Exceeded email verification limit.");
    } else {
      sendOtpCount = sendOtpCount! - 1;
      await localStorageService.write("sendOtpCount", sendOtpCount);
      await sendVerifyMail(context);
      notifyListeners();
    }
  }

  Future<void> _resetOtpCount(DateTime now) async {
    await localStorageService.write("sendOtpCount", 3);
    await localStorageService.write("lastOtpCountUpdate", now);
    sendOtpCount = 3;
    lastUpdate = now;
  }

  Future<void> _initializeOtpCount(DateTime now, BuildContext context) async {
    sendOtpCount = 3;
    lastUpdate = now;
    await localStorageService.write("sendOtpCount", 3);
    await localStorageService.write("lastOtpCountUpdate", now);
    await sendVerifyMail(context);
    notifyListeners();
  }

  bool _areFieldsFilled() {
    return emailIdTextController.text.isNotEmpty &&
        createpasswordTextController.text.isNotEmpty &&
        confirmpasswordTextController.text.isNotEmpty &&
        userNameController.text.isNotEmpty;
  }

  bool _isEmailValid() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(emailIdTextController.text);
  }

  bool _isUsernameValid() {
    final usernameRegex = RegExp(r'^[a-zA-Z ]+$');
    return usernameRegex.hasMatch(userNameController.text);
  }

  bool _isUsernameCapitalized() {
    return userNameController.text[0] ==
        userNameController.text[0].toUpperCase();
  }

  bool _arePasswordsMatching() {
    return createpasswordTextController.text ==
        confirmpasswordTextController.text;
  }

  bool _isPasswordStrong() {
    final password = confirmpasswordTextController.text;
    return password.length >= 8 &&
        RegExp(r'[a-zA-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password);
  }

  void navigateToAuth() {
    _navigationService.clearStackAndShow(Routes.authView);
  }

  Future<void> sendVerifyMail(context) async {
    generateRandomOTP();
    AuthenticationService().showLoadingOverlay(context);
    final message = Message()
      ..from = const Address(
          "technicalteam.bvcoenm@gmail.com", "The Dev Crew Technical Team")
      ..recipients.add(emailIdTextController.text)
      ..subject = 'TDC Email OTP Verification'
      ..html = ''' <html>
    <body>
      <h1>TDC App Email Verification</h1>
      <p>Dear user,</p>
      <p>Your verification code is: <b>$otp</b></p>
      <p>Please enter this code in the app to complete the registration process.</p>
      <p>Thank you!</p>
      <p>The Dev Crew Technical Team</p>
    </body>
  </html>''';

    try {
      final sendReport = await send(message, smtpServer);
      log.i("SENDOTPCOUNT $sendOtpCount");
      NavigationService().back();
      verifyEmailDialogue(context);
      showSuccessMessage(context, 'Message sent: $sendReport');
    } on MailerException catch (e) {
      NavigationService().back();
      showErrorMessage(context, 'Something went wrong');
      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void navigateToHelpSupport() async {
    UrlLauncher externalUrlHandler = UrlLauncher();
    await externalUrlHandler.launchEmail("technicalteam.bvcoenm@gmail.com");
  }

  void verifyEmailDialogue(context) {
    FocusScope.of(context).requestFocus(FocusNode());
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15).r,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: context.colorScheme.scaffold,
            clipBehavior: Clip.hardEdge,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.verified_rounded,
                  color: Color.fromARGB(255, 43, 250, 67),
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
                Text(
                  "Verification",
                  style: FontThemeClass().title(context),
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
                    Text(
                      "Enter five digit code we have sent to your email address !",
                      textAlign: TextAlign.center,
                      style: FontThemeClass().body(
                        context,
                        fontWeight: FontWeight.w300,
                      ),
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
                      keyboardType: TextInputType.number,
                      length: 5,
                      defaultPinTheme: PinTheme(
                        margin: const EdgeInsets.only(left: 2),
                        height: 75.h,
                        width: 75.w,
                        textStyle: const TextStyle(fontSize: 22),
                        decoration: BoxDecoration(
                          color: context.colorScheme.card,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,
                      onChanged: (value) {
                        otpController.text = value;
                      },
                      showCursor: true,
                      // ignore: avoid_print
                      onCompleted: (pin) => log.i(pin),
                    ).animate().fadeIn(
                          delay: const Duration(milliseconds: 600),
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
                  backgroundColor: context.colorScheme.accentColor,
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
                      width: 2, color: context.colorScheme.accentColor),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  foregroundColor: context.colorScheme.primaryText,
                  backgroundColor: context.colorScheme.card,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                onPressed: () {
                  if (!RegExp(r'^[0-9]+$').hasMatch(otpController.text)) {
                    showErrorMessage(context, "otp should contain only digits");
                  } else {
                    onVerify(context, int.parse(otpController.text));
                  }
                },
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
              ),
        );
      },
    );
  }

  Future<bool> checkEmailExists(String email, context) async {
    AuthenticationService().showLoadingOverlay(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersRef = firestore.collection('Users');

    try {
      QuerySnapshot querySnapshot = await usersRef
          .where(
            'userEmail',
            isEqualTo: email,
          )
          .get();
      if (querySnapshot.docs.isEmpty) {
        NavigationService().back();
        return false;
      } else {
        NavigationService().back();
        return true;
      }
    } catch (error) {
      NavigationService().back();
      return false;
    }
  }

  Future<void> onVerify(context, int pinotp) async {
    if (pinotp == otp) {
      try {
        NavigationService().back();
        AuthenticationService().showLoadingOverlay(context);

        _analyticsService.logSignUp(method: 'Register - Email');

        signupStatus = await _authenticationService.signUpWithEmailAndPassword(
          context,
          emailIdTextController.text,
          confirmpasswordTextController.text,
        );
        _analyticsService.setUserProperties(
          userId: FirebaseAuth.instance.currentUser!.uid,
        );

        if (signupStatus == "pass") {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(
                FirebaseAuth.instance.currentUser?.uid,
              )
              .set({
            "userEmail": emailIdTextController.text,
            "userName": userNameController.text,
            "userProfile": 'Explorer',
            "isUserNew": true,
          });

          await AuthenticationService().storeUserDataLocally();
          NavigationService().back();
          await _navigationService.replaceWithTransition(
            const OnboardingView(),
            transitionStyle: Transition.rightToLeftWithFade,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 1500),
          );
        } else {
          NavigationService().back();
          showErrorMessage(context, "something went wrong");
        }
      } catch (e) {
        NavigationService().back();
        showErrorMessage(context, "Invalid OTP");
      }
    } else {
      showErrorMessage(context, "Invalid-OTP");
    }
  }
}
