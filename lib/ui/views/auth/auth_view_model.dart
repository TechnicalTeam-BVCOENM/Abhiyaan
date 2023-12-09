part of 'auth_view.dart';

class AuthViewModel extends BaseViewModel {
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

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child :Text(
          'Darpan v.1.0.0',
          style: FontThemeClass().subHeading2(
                                context, context.colorScheme.secondarySectionColor),
        ),
      
    );
  }
}