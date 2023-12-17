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

  Future<void> register(
      String email,
      String createpassword,
      String confirmPassword,
      String selectedOption,
      String misNo,
      context) async {
    setBusy(true);

    // Validate that all common fields are non-empty
    if (email.isEmpty ||
        createpassword.isEmpty ||
        confirmPassword.isEmpty ||
        selectedOption == 'Select') {
      showmessage(context, "Please fill in all fields");
      setBusy(false);
      return;
    }

    if (createpassword != confirmPassword) {
      showmessage(context, "Passwords do not match");
      setBusy(false);
      return;
    }

    try {
      // Check the selected option
      if (selectedOption == 'BVCOE Student') {
        if (misNo.isEmpty) {
          showmessage(context, "MIS No is required for BVCOE Student");
          setBusy(false);
          return;
        }
      }

      // Continue with registration if passwords match
      await _authenticationService.registerWithEmailAndPassword(
          email, confirmPassword);

      // Store the information in Firebase Firestore
      // await FirebaseFirestore.instance.collection('users').add({
      //   'email': email,
      //   'password': confirmPassword,
      //   if (selectedOption == 'BVCOE Student') 'misNo': misNo,
      // });

      showmessage(context, "Registration successful");
      _navigationService.navigateTo(Routes.signInView);
    } on FirebaseException catch (e) {
      showmessage(
          context, "Registration failed. Please try again: ${e.message}");
      debugPrint("$e");
      // You can log or handle other Firebase exceptions here
    } finally {
      setBusy(false);
    }
  }

  toggleCreatePassword() {
    obscureText = !obscureText;
  }

  toggleConfirmPassword() {
    obscureText = !obscureText;
  }

  String _selectedValue = 'Select'; // Initialize with your default value

  String get selectedValue => _selectedValue;

  void setSelectedValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }
}

String selectedValue = 'Select';
bool obscureText = true;
List<String> dropdownItems = ['BVCOE Student', 'Outsider'];
