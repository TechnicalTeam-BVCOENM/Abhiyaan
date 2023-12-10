import 'package:darpan/file_exporter.dart';
import 'package:darpan/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final log = getLogger('AuthService');

  User? get currentUser => _firebaseAuth.currentUser;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => storeUserData());
      // Handle successful login
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
      "userSem",
      "userCollegeId",
      "userMisNo",
      "userEmail",
      "userName",
      "userPrnNo",
      "userLibNo",
    ];
    try {
      final localStorageService = locator<LocalStorageService>();
      Map<String, dynamic>? userData = await FirestoreService().getUserData();
      for (var i = 0; i < userTag.length; i++) {
        await localStorageService.write(userTag[i], userData?[userTag[i]]);
      }
      int misNo = int.parse(localStorageService.read('userMisNo'));
      int admissionYear = (misNo ~/ 1000000); // 21
      int departmentCode = ((misNo % 1000000) ~/ 10000); // 12
      int division = ((misNo % 10000) ~/ 1000); // 1
      int rollNo = (misNo % 1000); // 17
      localStorageService.write('addmissionYear', admissionYear);
      localStorageService.write('departmentCode', departmentCode);
      localStorageService.write('division', division);
      localStorageService.write('rollNo', rollNo);
    } catch (e) {
      rethrow;
    }
  }
}
