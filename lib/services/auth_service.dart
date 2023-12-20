import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class AuthenticationService {
  List userTag = [
    "userSem",
    "userCollegeId",
    "userMisNo",
    "userEmail",
    "userName",
    "userYear",
    "userPrnNo",
    "userLibNo",
    "userPhone",
    "userCertifications",
  ];
  final localStorageService = locator<LocalStorageService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final log = getLogger('AuthService');
  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log.i('Auth success');
    } on FirebaseAuthException catch (e) {
      log.i(e);
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(
      context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showmessage(context, "email-already-in-use");
      } else if (e.code == 'weak-password') {
        showmessage(context, "weak-password");
      }
      NavigationService().back();
    }
  }

  registerWithEmailAndPassword(String email, String password) {}

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

  Future<void> storeUserDataLocally() async {
    try {
      Map<String, dynamic>? userData = await FirestoreService().getUserData();
      for (var i = 0; i < userTag.length; i++) {
        if (userData?[userTag[i]] == null) {
          await localStorageService.write(userTag[i], "feed me data");
        } else {
          await localStorageService.write(userTag[i], userData?[userTag[i]]);
          log.i(localStorageService..read('${userTag[i]}'));
        }
      }

      await misBreakdown();
    } catch (e) {
      log.i(e);
      rethrow;
    }
  }

  void setStorageToNull() async {
    for (var i = 0; i < userTag.length; i++) {
      await localStorageService.write(userTag[i], "feed me data");
    }
    log.i("done");
  }

  Future<void> misBreakdown() async {
    try {
      final localStorageService = locator<LocalStorageService>();
      int misNo = int.parse(localStorageService.read('userMisNo'));
      int admissionYear = (misNo ~/ 1000000); // 21
      int departmentCode = ((misNo % 1000000) ~/ 10000); // 12
      int division = ((misNo % 10000) ~/ 1000); // 1
      int rollNo = (misNo % 1000); // 17
      await localStorageService.write('addmissionYear', admissionYear);
      await localStorageService.write('departmentCode', departmentCode);
      await localStorageService.write('division', division);
      await localStorageService.write('rollNo', rollNo);
      await departmentCodeDatabase(departmentCode);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> departmentCodeDatabase(int code) async {
    final localStorageService = locator<LocalStorageService>();
    try {
      if (code == 12) {
        String departmentCodeDatabase = '${code}_computer';
        await localStorageService.write(
            'departmentCodeDatabase', departmentCodeDatabase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future saveDeviceToken(String token) async {
    try {
      if (token.isNotEmpty) {
        final user = FirebaseFirestore.instance
            .collection('Users')
            .doc(_firebaseAuth.currentUser!.uid);
        DocumentSnapshot userSnapshot = await user.get();

        if (userSnapshot.exists) {
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          if (userData != null) {
            final existingToken = userData['userDeviceToken'];

            if (existingToken == null) {
              await user.update({
                'userDeviceToken': token,
              });
            } else if (existingToken == token) {
              debugPrint('Token already exists');
              return;
            } else {
              await user.update({
                'userDeviceToken': token,
              });
            }
          } else if (userData != null &&
              !userData.containsKey('userDeviceToken')) {
            await user.update({
              'userDeviceToken': token,
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error saving  token to database: ${e.toString()}');
    }
  }

  void showLoadingOverlay(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
              child: SizedBox(
                  width: 250,
                  child: LottieBuilder.asset(
                      repeat: true,
                      "assets/images/animations/hand_loading.json")));
        });
  }
}
