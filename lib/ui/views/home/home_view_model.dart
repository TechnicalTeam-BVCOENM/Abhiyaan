part of 'home_view.dart';

bool isCelebrationShown = false;

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');

  // Contructor
  HomeViewModel() {
    NotificationsService notificationsService = NotificationsService();

    notificationsService.registerNotification();
  }

  final FirestoreService _firestoreService = FirestoreService();
  final navigationService = locator<NavigationService>();
  NotificationsService notificationService = NotificationsService();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  FontThemeClass fontThemeClass = FontThemeClass();
  CarouselUtils carouselUtils = CarouselUtils();
  late bool isUserNew = LocalStorageService().read('isUserNew');

  int _activeIndex = 0;
  List<String> firstname = [];
  List<DepartmentUpdates> _collegeUpdates = [];
  final List<CelebrationData> _celebrationData = [];
  List<Map<String, dynamic>> _highlights = [];
  List<Map<String, dynamic>> get highlights => _highlights;
  List<DepartmentUpdates> get collegeUpdates => _collegeUpdates;
  List<CelebrationData> get celebrationData => _celebrationData;
  int get activeIndex => _activeIndex;

  bool toggleCelebrationShown() {
    try {
      isCelebrationShown = true;
      notifyListeners();
      return isCelebrationShown;
    } on Exception catch (e) {
      log.e("Error in toggling celebration shown : ${e.toString()}");
      return isCelebrationShown = false;
    }
  }

  Future<void> getCelebrationData() async {
    try {
      DateTime today = DateTime.now();
      List<CelebrationData> unsortedList =
          await _firestoreService.getCelebrationData();

      if (unsortedList.isEmpty) {
        return;
      } else if (unsortedList.length == 1 &&
          unsortedList.first.startdate.toDate().year == today.year &&
          unsortedList.first.startdate.toDate().month == today.month &&
          unsortedList.first.startdate.toDate().day == today.day) {
        _celebrationData.add(unsortedList.first);
        notifyListeners();
      } else {
        List<CelebrationData> filteredList = unsortedList.where((item) {
          return item.startdate.toDate().year == today.year &&
              item.startdate.toDate().month == today.month &&
              item.startdate.toDate().day == today.day;
        }).toList();
        if (filteredList.isEmpty) {
          return;
        } else if (filteredList.isNotEmpty) {
          _celebrationData.add(filteredList.first);
          notifyListeners();
        }
      }
    } catch (e) {
      log.e("Error in getting celebration data : ${e.toString()}");
    }
  }

  String splitusername() {
    final user = LocalStorageService().read('userName');
    firstname = user.split(' ');
    return firstname[0];
  }

  Future<bool> toggleisNewUser() async {
    try {
      isUserNew = false;
      await _firestoreService
          .updateUserStatus()
          .then((value) => LocalStorageService().write('isUserNew', isUserNew));
      notifyListeners();
      return isUserNew;
    } on Exception catch (e) {
      log.e("Error in toggling user status : ${e.toString()}");
      return isUserNew = true;
    }
  }

  void showWelcomeAndCelebration(context) async {
    try {
      if (isUserNew) {
        await showWelcomPopUp(context,
                toggleisNewUser: toggleisNewUser,
                username: splitusername(),
                isCelebrationShown: isCelebrationShown,
                celebrationData: _celebrationData,
                toggleCelebrationShown: toggleCelebrationShown)
            .then((value) async {
          Future.delayed(2.seconds, () async {
            if (isCelebrationShown == false && _celebrationData.isNotEmpty) {
              await showCelebrationModal(
                  context, _celebrationData[0], toggleCelebrationShown);
            }
          });
        });
      } else if (_celebrationData.isNotEmpty && isCelebrationShown == false) {
        showCelebrationModal(
            context, _celebrationData[0], toggleCelebrationShown);
      } else if (_celebrationData.isNotEmpty && isCelebrationShown == true) {
        log.i("Celebration is already shown");
      } else if (celebrationData.isEmpty) {
        log.i("User is not new");
      }
    } on Exception catch (e) {
      log.e("Error in showing welcome and celebration : ${e.toString()}");
    }
  }

  List<QuickLinksModel> quickLinksList = [
    QuickLinksModel(
      imageUrl: "assets/images/home/college.png",
      title: "BVCOENM",
      url: 'https://www.bvcoenm.edu.in/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/abhiyaan.png",
      title: "Abhiyaan",
      url: 'https://abhiyaan.tech/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/sigma.png",
      title: "Sigma",
      view: const SocietiesView(),
    ),
    QuickLinksModel(
      imageUrl: "assets/images/cesa.png",
      title: "CESA",
      url: 'https://www.clubcesa.tech/',
    ),
  ];

  Future<void> afterInit(context) async {
    try {
      await getCelebrationData()
          .then((value) => showWelcomeAndCelebration(context));
      notifyListeners();
    } on Exception catch (e) {
      log.e("Error in after init : ${e.toString()}");
    }
  }

  Future<void> init(context) async {
    try {
      _analyticsService.logScreen(screenName: 'HomeView Screen Opened');

      setBusy(true);
      _highlights = await _firestoreService.getHighlights();
      _collegeUpdates = await _firestoreService.getCollegeUpdates();
      // await _authenticationService.checkPermission(Permission.appTrackingTransparency,context);
      // await _authenticationService.checkPermission(
      //     Permission.notification, context);
      notifyListeners();
      setBusy(false);
      await Future.delayed(2.seconds);
      notificationService.onTokenRefresh();
      notificationService.getToken();
    } catch (e) {
      log.e(e);
      showErrorMessage(context, "Error in getting data");
    }
  }

  void updateActiveIndex(int newIndex) {
    try {
      _activeIndex = newIndex;
      notifyListeners();
    } on Exception catch (e) {
      log.e("Error in updating active index : ${e.toString()}");
    }
  }
}

void handleQuickLinksNavigation(List model, int i) {
  try {
    if (model[i].url != '' && model[i].url != null) {
      UrlLauncher externalUrlHandler = UrlLauncher();
      _analyticsService.logEvent(
          eventName: "Quick_Links",
          value: "Button Clicked : ${model[i].title}");
      externalUrlHandler.launchURL(
        model[i].url,
      );
    } else if (model[i].view != '' && model[i].view != null) {
      final navigationService = locator<NavigationService>();
      navigationService.navigateToView(model[i].view);
    } else {
      debugPrint("Error in handling quick links navigation");
    }
  } catch (e) {
    debugPrint("Error in handling quick links navigation : ${e.toString()}");
  }
}

// Models
class DepartmentUpdates {
  final String title;
  final String description;
  final Timestamp date;
  final String url;
  DepartmentUpdates({
    required this.title,
    required this.description,
    required this.date,
    required this.url,
  });
}

class QuickLinksModel {
  final String imageUrl;
  final String title;
  final String url;
  final Widget view;
  QuickLinksModel({
    required this.imageUrl,
    required this.title,
    this.url = '',
    this.view = const HomeView(),
  });
}

class Activity {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String subName;
  final String profName;
  final String location;

  Activity({
    required this.startTime,
    required this.endTime,
    required this.subName,
    required this.profName,
    required this.location,
  });
}
