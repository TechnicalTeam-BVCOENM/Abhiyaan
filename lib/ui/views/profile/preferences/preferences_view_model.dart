part of 'preferences_view.dart';

class PreferencesViewModel extends BaseViewModel {
  final log = getLogger('SettingsView');
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _analyticsService = locator<AnalyticsService>();
  final _profileViewModel = locator<ProfileViewModel>();
  bool isProfileError = false;
  bool isPreview = true;
  final TextEditingController profileImageUrlController =
      TextEditingController();

  final LocalStorageService localStorageService =
      locator<LocalStorageService>();
  final fontTheme = FontThemeClass();

  void init() {
    _analyticsService.logScreen(screenName: 'Settings Screen Opened');
  }

  void copyText(String title, String value, BuildContext context) async {
    _analyticsService.logEvent(
      eventName: "Profile_Details_Copy",
      value: "$title Profile Details Copy button clicked",
    );
    await Clipboard.setData(ClipboardData(text: value)).then(
      (value) => showNormalMessage(
        context,
        "$title Copied",
      ),
    );
  }

  Future<void> changePassword(context) async {
    final localStorageService = locator<LocalStorageService>();
    String storedEmail = localStorageService.read('userEmail');
    log.i(storedEmail);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: storedEmail)
          .then(
            (value) => showNormalMessage(
              context,
              "reset password email sent !",
            ),
          );
    } catch (e) {
      showErrorMessage(context, "something went wrong !");
    }
  }

  Future<void> changePasswordForSignin(context, String? email) async {
    setBusy(true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!).then(
            (value) => showNormalMessage(
              context,
              "reset password email sent !",
            ),
          );
    } catch (e) {
      showErrorMessage(context, "something went wrong !");
    }
    setBusy(false);
    // Change password logic
  }

  void passwordChangeAlert(context, [String? email]) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          clipBehavior: Clip.hardEdge,
          titlePadding: const EdgeInsets.all(0),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(
                height: 20,
                thickness: 100,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 36,
                    ),
                    10.horizontalSpace,
                    const Text(
                      "Alert",
                    ),
                  ],
                ),
              ),
            ],
          ),
          content:
              const Text("Are you sure you want to change your password ?"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                foregroundColor: Colors.white,
                backgroundColor: context.colorScheme.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () {
                _analyticsService.logEvent(
                  eventName: "Change_password_popup",
                  value: "Change password cancel button clicked",
                );
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2,
                  color: context.colorScheme.accentColor,
                ),
                padding: const EdgeInsets.all(0),
                foregroundColor: context.colorScheme.primaryText,
                backgroundColor: context.colorScheme.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () {
                _analyticsService.logEvent(
                  eventName: "Change_password_popup",
                  value: "Change password yes button clicked",
                );
                if (FirebaseAuth.instance.currentUser != null) {
                  changePassword(context).then(
                    (value) => Navigator.pop(context),
                  );
                } else {
                  changePasswordForSignin(context, email).then(
                    (value) => Navigator.pop(context),
                  );
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
    notifyListeners();
  }

  void logoutAlert(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          clipBehavior: Clip.hardEdge,
          titlePadding: const EdgeInsets.all(0),
          backgroundColor: context.colorScheme.card,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(
                height: 20,
                thickness: 100,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 36,
                    ),
                    10.horizontalSpace,
                    const Text(
                      "Alert",
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 400.w,
            child: const Text("Are you sure you want to Logout ?"),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                foregroundColor: Colors.white,
                backgroundColor: context.colorScheme.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () {
                _analyticsService.logEvent(
                  eventName: "Logout_popup",
                  value: "Logout cancel button clicked",
                );
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                    width: 2, color: context.colorScheme.accentColor),
                padding: const EdgeInsets.all(0),
                foregroundColor: context.colorScheme.primaryText,
                backgroundColor: context.colorScheme.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () async {
                _analyticsService.logEvent(
                  eventName: "Logout_popup",
                  value: "Logout yes button clicked",
                );
                await logout(context).then(
                  (value) => showSuccessMessage(context, "Logout successful"),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    setBusy(true);
    LocalStorageService localStorageService = locator<LocalStorageService>();
    final bottomNavViewModel = locator<BottomNavViewModel>();
    final bool success = await _authenticationService.signOut().then((value) {
      return value;
    });
    if (success) {
      log.i('sign out success');
      bottomNavViewModel.setIndex(0);
      await _navigationService.clearStackAndShow(Routes.authView);
      await localStorageService.clear();
    } else {
      log.i('sign out failed');
    }
    setBusy(false);
  }

  void updateImageSheet(BuildContext context) {
    isProfileError = false;
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.scaffold,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      showDragHandle: true,
      context: context,
      builder: (context) {
        isProfileError = false;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20.r,
              left: 20.r,
              right: 20.r),
          decoration: BoxDecoration(
            color: context.colorScheme.scaffold,
            borderRadius: BorderRadius.circular(32).r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: profileImageUrlController.text == ''
                    ? Container(
                        width: 100.r,
                        height: 100.r,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 70,
                        ),
                      )
                    : CachedNetworkImage(
                        width: 100.r,
                        height: 100.r,
                        fit: BoxFit.cover,
                        imageUrl: profileImageUrlController.text,
                        placeholder: (context, url) =>
                            const CircularLoadingIndicator(),
                        errorWidget: (context, url, error) {
                          isProfileError = true;
                          isPreview = true;
                          return Container(
                            width: 100.r,
                            height: 100.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                      ),
              ),
              16.verticalSpace,
              TextFormField(
                onTap: () {
                  if (!isPreview) {
                    isPreview = true;
                    notifyListeners();
                  }
                },
                controller: profileImageUrlController,
                // onChanged: (value) {
                //   isPreview = true;
                //   notifyListeners();
                // },
                keyboardType: TextInputType.name,
                cursorColor: context.colorScheme.accentColor,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
                          .r,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(15).r,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: context.colorScheme.card,
                  filled: true,
                  focusColor: context.colorScheme.card,
                  hintText: 'Enter Image Url.....',
                  hintStyle: fontTheme.caption(
                    context,
                    color: context.colorScheme.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ).animate(delay: 300.ms).fadeIn(
                    delay: 100.ms,
                    curve: Curves.easeInOut,
                    duration: 700.ms,
                  ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (isProfileError && isPreview) {
                    profileImageUrlController.text = '';
                    _navigationService.back();
                    showErrorMessage(context, "Invalid Image URL");
                  } else if (isPreview) {
                    isPreview = false;
                    FocusScope.of(context).requestFocus(FocusNode());
                    notifyListeners();
                  } else if (isProfileError) {
                    _navigationService.back();
                    showErrorMessage(context, "Invalid Image URL");
                  } else {
                    await localStorageService.write(
                        "userProfileImageUrl", profileImageUrlController.text);
                    AssetUrls.profileImageUrl = profileImageUrlController.text;
                    _navigationService.back();
                    _profileViewModel.notifyListeners();
                    notifyListeners();
                    updateProfileImage(profileImageUrlController.text);
                    profileImageUrlController.text = '';
                  }
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ).r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15).r,
                    color: context.colorScheme.accentColor,
                  ),
                  child: Center(
                    child: Text(
                      isPreview ? 'Preview' : 'Update',
                      style: FontThemeClass().body(
                        context,
                        color: context.colorScheme.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ).animate(delay: 200.ms).fadeIn(
                    delay: 100.ms,
                    curve: Curves.easeInOut,
                    duration: 700.ms,
                  ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateProfileImage(String imageUrl) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(
          FirebaseAuth.instance.currentUser?.uid,
        )
        .update({
      "userProfileImageUrl": imageUrl,
    });
  }
}
