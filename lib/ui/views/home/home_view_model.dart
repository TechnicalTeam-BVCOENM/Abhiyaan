part of 'home_view.dart';

bool isCelebrationShown = false;

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final _firestoreService = FirestoreService();
  final _notificationService = NotificationsService();
  final _analyticsService = locator<AnalyticsService>();
  static final _localStorage = locator<LocalStorageService>();
  // final _carouselUtils = CarouselUtils();

  // Contructor
  HomeViewModel(BuildContext context) {
    _notificationService.registerNotification();
    final themeService = locator<ThemeService>();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeService.brightness == Brightness.light
            ? context.colorScheme.scaffold
            : Colors.transparent,
        statusBarIconBrightness: themeService.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  int _activeIndex = 0;

  // Added setter and getter for firstname
  final List<String> _firstname = [];
  List<String> get firstname => _firstname;
  set firstname(List<String> value) {
    _firstname.addAll(value);
    notifyListeners();
  }

  List<DepartmentUpdates> _collegeUpdates = [];
  List<DepartmentUpdates> get collegeUpdates => _collegeUpdates;

  final List<CelebrationData> _celebrationData = [];
  List<CelebrationData> get celebrationData => _celebrationData;

  List<String> _highlights = [];
  List<String> get highlights => _highlights;

  int get activeIndex => _activeIndex;

  bool _isUserNew = _localStorage.read('isUserNew') ?? true;
  bool get isUserNew => _isUserNew;
  set isUserNew(bool value) {
    _isUserNew = value;
    notifyListeners();
  }

  List<QuickLinksModel> quickLinksList = [
    QuickLinksModel(
      imageUrl: "assets/images/android_splash_logo.png",
      title: "BVCOENM",
      url: 'https://www.bvcoenm.edu.in/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/quick_links/abhiyaan.png",
      title: "Abhiyaan",
      url: 'https://abhiyaan.tech/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/quick_links/tdc_logo.png",
      title: "TDC",
      url: 'https://abhiyaan.tech/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/quick_links/cesa.png",
      title: "CESA",
      url: 'https://www.clubcesa.tech/',
    ),
  ];

  // Initialisation Method
  Future<void> init(context) async {
    try {
      setBusy(true);
      _analyticsService.logScreen(screenName: 'HomeView Screen Opened');

      final results = await Future.wait([
        _firestoreService.getHighlights(),
        _firestoreService.getCollegeUpdates(),
        // Future.delayed(2.seconds),
      ]);

      _highlights = results[0] as List<String>;
      _collegeUpdates = results[1] as List<DepartmentUpdates>;

      notifyListeners();
      setBusy(false);

      _notificationService.onTokenRefresh();
      _notificationService.getToken();
    } catch (e) {
      log.e(e);
      showErrorMessage(context, "Something went wrong");
    }
  }

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

  Future<void> afterInit(context) async {
    try {
      await getCelebrationData()
          .then((value) => showWelcomeAndCelebration(context));
      notifyListeners();
    } on Exception catch (e) {
      log.e("Error in after init : ${e.toString()}");
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
