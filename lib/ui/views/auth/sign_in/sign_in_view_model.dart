part of 'sign_in_view.dart';

class SignInViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final String emailIdErrorText = "Please enter a valid email id";
  final String passwordErrorText = "Please enter a valid password";

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

  Future<void> login(String email, String password, context) async {
    setBusy(true);
    try {
      await _authenticationService.signInWithEmailAndPassword(email, password);
      showmessage(context, "Login successful");
      _navigationService.navigateTo(Routes.bottomNavView);
    } on FirebaseException catch (e) {
      showmessage(context, "Invalid email or password");
      isPasswordValid = false;
      isEmailIdValid = false;
      notifyListeners();
      debugPrint("$e");
      // You can log or handle other Firebase exceptions here
    }
    setBusy(false);
  }

  void passwordResetMail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: "");
  }

  togglePassword() {
    obscureText = !obscureText;
  }
}
