import 'package:abhiyaan/ui/common/circular_loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final log = getLogger('AuthService');

  List userTag = [
    "userMisNo",
    "userEmail",
    "userName",
    "userCertifications",
    "isUserNew",
    "userProfile",
  ];
  final localStorageService = locator<LocalStorageService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<String> signUpWithEmailAndPassword(
      context, String email, String password) async {
    try {
      // _analyticsService.logLogin();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "pass";
      // _analyticsService.setUserProperties(userId: _firebaseAuth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorMessage(context, "Email already in use");
        return "failed";
      } else if (e.code == 'weak-password') {
        showErrorMessage(context, "Password is too weak");
        return "failed";
      } else {
        return "failed";
      }
    }
  }

  Future<bool> signOut() async {
    bool firebaseSignOutSuccess = false;
    try {
      await _firebaseAuth.signOut();
      firebaseSignOutSuccess = true;
      return firebaseSignOutSuccess;
    } catch (error) {
      log.e("Firebase Sign Out Error: ${error.toString()}");
      return firebaseSignOutSuccess;
    }
  }

  Future<void> storeUserDataLocally() async {
    try {
      Map<String, dynamic>? userData = await FirestoreService().getUserData();
      for (var i = 0; i < userTag.length; i++) {
        if (userData?[userTag[i]] == null) {
          await localStorageService.write(userTag[i], "Not Available");
        } else {
          await localStorageService.write(userTag[i], userData?[userTag[i]]);
        }
      }
    } catch (e) {
      log.e("Error storing user data locally: ${e.toString()}");
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
      log.e('Error saving  token to database: ${e.toString()}');
    }
  }

  void showLoadingOverlay(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const CircularLoadingIndicator();
      },
    );
  }

  // Future<void> checkPermission(Permission permission,BuildContext context) async {
  //  await permission.request();
  //  final status = await permission.status;
  //   if (status.isGranted) {
  //    log.i("Permission Granted");
  //   } else if (status.isDenied){
  //     log.e("Permission Denied");
  //      // ignore: use_build_context_synchronously
  //      PermissionRequestPopup().showPermissionRequestPopup(context);
  //   }
  // }
}
