part of 'register_view.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final log = getLogger('AuthViewModel');
  final fontTheme = FontThemeClass();

  final TextEditingController emailIdTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

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
      debugPrint("$e");
      // You can log or handle other Firebase exceptions here
    }
    setBusy(false);
  }

  void passwordResetMail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: "");
  }
}