import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abhiyaan/file_exporter.dart';
import 'package:abhiyaan/services/firestore_service.dart';
import 'package:abhiyaan/ui/common/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

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

 

  Future<void> signUpWithEmailAndPassword(
      context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorMessage(context, "Email already in use");
      } else if (e.code == 'weak-password') {
        showErrorMessage(context, "Password is too weak");
      }
      NavigationService().back();
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
        return Center(
          child: SizedBox(
            width: 250,
            child: LottieBuilder.asset(
              repeat: true,
              AnimationAssets.handLoading,
            ),
          ),
        );
      },
    );
  }
}
