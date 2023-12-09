import 'package:darpan/app/app.locator.dart';
import 'package:darpan/app/app.logger.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:darpan/services/local_storage_service.dart';
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
      await storeUserData();
      log.i('Auth success');
    } on FirebaseAuthException {
      // Handle error
      rethrow;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Handle successful sign up
    } on FirebaseAuthException {
      // Handle error
      rethrow;
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

  Future storeUserData() async {
    List userTag = [
      "userCollegeId",
      "userLibNo",
      "userMisNo",
      "userName",
      "userYear",
      "userPrnNo",
    ];
    final localStorageService = locator<LocalStorageService>();
    try {
      Map<String, dynamic>? userData = await FirestoreService().getUserData();
      for (var i = 0; i < userTag.length; i++) {
        await localStorageService.write(userTag[i], userData?[userTag[i]]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
