import 'package:darpan/app/app.logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final log = getLogger('AuthService');

  User? get currentUser => _firebaseAuth.currentUser;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // Handle successful login
      log.i('Auth success');
    } on FirebaseAuthException catch (e) {
      // Handle error
      throw e;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Handle successful sign up
    } on FirebaseAuthException catch (e) {
      // Handle error
      throw e;
    }
  }

  Future<bool> signOut() async {
    bool firebaseSignOutSuccess = false;

    try {
      await _firebaseAuth.signOut();
      firebaseSignOutSuccess = true;
    } catch (error) {
      log.i("Firebase Sign Out Error: $error");
    }
    return firebaseSignOutSuccess;
    // Handle sign out
  }
}
