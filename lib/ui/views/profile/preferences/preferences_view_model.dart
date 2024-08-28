part of 'preferences_view.dart';

class PreferencesViewModel extends BaseViewModel {
  final log = getLogger('SettingsView');
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _analyticsService = locator<AnalyticsService>();
  final profileViewModel = locator<ProfileViewModel>();
  bool isProfileError = false;
  bool isPreview = true;
  final TextEditingController profileImageUrlController =
      TextEditingController();

  final LocalStorageService localStorageService =
      locator<LocalStorageService>();
  final fontTheme = FontThemeClass();

  final List<String> profileImages = [
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%201.png?alt=media&token=054e3dfe-5c92-4241-8ac5-5607165b5e4e",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%202.png?alt=media&token=c4180bc7-dc1f-487e-9926-27d626248780",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%203.png?alt=media&token=f16a4169-22fe-4c3e-a8ae-83531d9d9105",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%204.png?alt=media&token=c84967eb-14f2-4abc-82b3-a00eaf6014f1",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%205.png?alt=media&token=52f70fac-0fbc-4b34-a1b1-397b8843cdb8",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%206.png?alt=media&token=cdea444d-bdcc-4f4e-b864-e2226fb23e69",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%207.png?alt=media&token=1cbfc91d-7f27-4540-a6a6-f2d16a7f9546",
    "https://firebasestorage.googleapis.com/v0/b/abhiyaan-9f241.appspot.com/o/Avatars%2FAvatar%208.png?alt=media&token=68a1d6c1-2bae-4c94-ba6f-f12d11418e65",
  ];

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
    final storageService = locator<LocalStorageService>();
    final bool success = await _authenticationService.signOut().then((value) {
      return value;
    });
    if (success) {
      log.i('sign out success');
      bottomNavViewModel.setIndex(0);
      await _navigationService.clearStackAndShow(Routes.authView);
      await localStorageService.clear();
      await storageService.write(
          "showRegister", await FirestoreService().showRegistration());
    } else {
      log.i('sign out failed');
    }
    setBusy(false);
  }

  void updateImageSheet(BuildContext context) {
    isProfileError = false;
    profileImageUrlController.text = '';
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
              top: 10.r,
              left: 10.r,
              right: 10.r),
          decoration: BoxDecoration(
            color: context.colorScheme.scaffold,
            borderRadius: BorderRadius.circular(32).r,
          ),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Select Profile Image",
                  style: FontThemeClass().caption(
                    context,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primaryText,
                  ),
                ),
              ),
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i++)
                    GestureDetector(
                      onTap: () async {
                        profileImageUrlController.text = profileImages[i];
                        await localStorageService.write("userProfileImageUrl",
                            profileImageUrlController.text);
                        AssetUrls.profileImageUrl =
                            profileImageUrlController.text;
                        _navigationService.back();
                        profileViewModel.notifyListeners();
                        notifyListeners();
                        updateProfileImage(profileImageUrlController.text);
                        profileImageUrlController.text = '';
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              height: 80.h,
                              width: 80.w,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const CircularLoadingIndicator();
                              },
                              imageUrl: profileImages[i],
                            ),
                          ).animate().tint(
                              color: localStorageService
                                          .read("userProfileImageUrl") ==
                                      profileImages[i]
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.transparent),
                          localStorageService.read("userProfileImageUrl") ==
                                  profileImages[i]
                              ? Icon(
                                  Icons.check_rounded,
                                  size: 30.r,
                                  color: context.colorScheme.white,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                ].animate(delay: 200.ms, interval: 200.ms).fadeIn(
                      delay: 100.ms,
                      curve: Curves.easeInOut,
                      duration: 700.ms,
                    ),
              ),
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 4; i < profileImages.length; i++)
                    GestureDetector(
                      onTap: () async {
                        profileImageUrlController.text = profileImages[i];
                        await localStorageService.write("userProfileImageUrl",
                            profileImageUrlController.text);
                        AssetUrls.profileImageUrl =
                            profileImageUrlController.text;
                        _navigationService.back();
                        profileViewModel.notifyListeners();
                        notifyListeners();
                        updateProfileImage(profileImageUrlController.text);
                        profileImageUrlController.text = '';
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              height: 80.h,
                              width: 80.w,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const CircularLoadingIndicator();
                              },
                              imageUrl: profileImages[i],
                            ),
                          ).animate().tint(
                              color: localStorageService
                                          .read("userProfileImageUrl") ==
                                      profileImages[i]
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.transparent),
                          localStorageService.read("userProfileImageUrl") ==
                                  profileImages[i]
                              ? Icon(
                                  Icons.check_rounded,
                                  size: 30.r,
                                  color: context.colorScheme.white,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                ].animate(delay: 400.ms, interval: 200.ms).fadeIn(
                      delay: 100.ms,
                      curve: Curves.easeInOut,
                      duration: 700.ms,
                    ),
              ),
              12.verticalSpace,
              TextFormField(
                onTap: () {
                  if (!isPreview) {
                    isPreview = true;
                    notifyListeners();
                  }
                },
                controller: profileImageUrlController,
                onChanged: (value) {
                  isPreview = true;
                  notifyListeners();
                },
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
                  hintText: 'Enter Custom Image Url.....',
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
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _navigationService.back();
                    },
                    child: Container(
                      width: 180.w,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).r,
                        color: context.colorScheme.black,
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: FontThemeClass().body(
                            context,
                            color: context.colorScheme.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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
                        if (profileImageUrlController.text.isEmpty) {
                          profileImageUrlController.text =
                              localStorageService.read("userProfileImageUrl");
                        }
                        await localStorageService.write("userProfileImageUrl",
                            profileImageUrlController.text);
                        AssetUrls.profileImageUrl =
                            profileImageUrlController.text;
                        _navigationService.back();
                        profileViewModel.notifyListeners();
                        notifyListeners();
                        updateProfileImage(profileImageUrlController.text);
                        profileImageUrlController.text = '';
                      }
                    },
                    child: Container(
                      width: 180.w,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: context.colorScheme.black,
                      ),
                      child: Center(
                        child: Text(
                          'Update',
                          style: FontThemeClass().body(
                            context,
                            color: context.colorScheme.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ].animate(delay: 200.ms, interval: 20.ms).fadeIn(
                      delay: 100.ms,
                      curve: Curves.easeInOut,
                      duration: 700.ms,
                    ),
              ),
              20.verticalSpace,
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
