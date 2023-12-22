part of 'home_view.dart';
bool isCelebrationShown = false;

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final FirestoreService _firestoreService = FirestoreService();
  final navigationService = locator<NavigationService>();
  FontThemeClass fontThemeClass = FontThemeClass();
  List<String> firstname = [];
  List<Activity> get activityList => _activityList;
  List<Map<String, dynamic>> _highlights = [];
  List<Map<String, dynamic>> get highlights => _highlights;
  List<DepartmentUpdates> _departmentUpdates = [];
  List<DepartmentUpdates> get departmentUpdates => _departmentUpdates;
  late bool isUserNew = LocalStorageService().read('isUserNew');
  final List<CelebrationData> _celebrationData = [];
  List<CelebrationData> get celebrationData => _celebrationData;

  bool toggleCelebrationShown() {
    isCelebrationShown = true;
    notifyListeners();
    return isCelebrationShown;
  }
 
  Future getCelebrationData() async {
    try {
      List<CelebrationData> unsortedList =
          await _firestoreService.getCelebrationData();

      if (unsortedList.isEmpty) {
        debugPrint("UnsortedList data is empty");
        return [];
      } else {
        unsortedList.sort(
            (a, b) => b.startdate.toDate().compareTo(a.startdate.toDate()));
        if (unsortedList.first.startdate
            .toDate()
            .isBefore(DateTime(DateTime.now().year, DateTime.now().month))) {
          return [];
        } else {
          _celebrationData.add(unsortedList.first);
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error in getting celebration data : ${e.toString()}");
    }
  }

  String splitusername() {
    final user = LocalStorageService().read('userName');
    firstname = user.split(' ');
    log.i(isUserNew);
    return firstname[0];
  }

  Future<bool> toggleisNewUser() async {
    isUserNew = false;
   await _firestoreService
        .updateUserStatus()
        .then((value) => LocalStorageService().write('isUserNew', isUserNew));
    notifyListeners();
    return isUserNew;
  }

  void showWelcomeAndCelebration(BuildContext context) async {
    if (isUserNew) {
      debugPrint("User is new");
      await showWelcomPopUp(context,toggleisNewUser: toggleisNewUser , username: splitusername() ).then((value) async {
        debugPrint("Showed welcome pop up");
        Future.delayed(2.seconds, () async{
          if (isCelebrationShown == false && _celebrationData.isNotEmpty) {
          await showCelebrationModal(context, _celebrationData[0],toggleCelebrationShown);
          debugPrint("Showed Celebration pop up");
        }
        });
      });
    } else if (_celebrationData.isNotEmpty && isCelebrationShown == false) {
      showCelebrationModal(context, _celebrationData[0],toggleCelebrationShown);
    } else if (_celebrationData.isNotEmpty && isCelebrationShown == true) {
      debugPrint("Celebration is already shown");
    } else if (celebrationData.isEmpty) {
      debugPrint("Celebration data: ${celebrationData.length}");
      debugPrint("User is not new");
      debugPrint("Celebration data is empty & isCelebrationShown is true");
    }
  }

  void navigateToNotificationView() {
    navigationService.navigateToNotificationView(id: '');
  }

  List<QuickLinksModel> quickLinksList = [
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle 88.png",
      title: "BVCOENM",
      url: 'https://www.bvcoenm.edu.in/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle_89.png",
      title: "Abhiyaan",
      url: 'https://abhiyaan-2023.netlify.app/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle 90.png",
      title: "Sigma",
      view: const SocietiesView(),
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle_91.png",
      title: "Blogs",
      url: 'https://www.dev.com/',
    ),
  ];

  final List<Activity> _activityList = [
    Activity(
      startTime: const TimeOfDay(hour: 11, minute: 15),
      endTime: const TimeOfDay(hour: 12, minute: 15),
      subName: "Computer Network",
      profName: "Prof. Aruna Kamble",
      location: "Floor 1, Class Room 137",
    ),
  ];

  Future<void> init(context) async {
    setBusy(true);
    try {
      NotificationService notificationService = NotificationService();
      notificationService.messaging.onTokenRefresh.listen((event) {
        notificationService.getDeviceToken();
      });
      notificationService.getDeviceToken();
      await getCelebrationData();
      _highlights = await _firestoreService.getHighlights();
      _departmentUpdates = await _firestoreService.getCollegeUpdates();
      notifyListeners();
      log.i(highlights);
      log.i(highlights.length);
      showWelcomeAndCelebration(context);
      debugPrint(
          DateFormat("MMMM d").format((departmentUpdates[0].date).toDate()));
    } catch (e) {
      log.e(e);
    }

    setBusy(false);
  }

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;
  void updateActiveIndex(int newIndex) {
    _activeIndex = newIndex;
    notifyListeners();
  }

 
}

void handleQuickLinksNavigation(List model, int i) {
  try {
    if (model[i].url != '' && model[i].url != null) {
      debugPrint("Route Url");
      UrlLauncher externalUrlHandler = UrlLauncher();
      externalUrlHandler.launchURL(
        model[i].url,
      );
    } else if (model[i].view != '' && model[i].view != null) {
      final navigationService = locator<NavigationService>();

      debugPrint("Page View");
      navigationService.navigateToView(model[i].view);
    } else {
      debugPrint("Error");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

// Models
class DepartmentUpdates {
  late String title;
  late String description;
  late Timestamp date;
  DepartmentUpdates({
    required this.title,
    required this.description,
    required this.date,
  });
}

class QuickLinksModel {
  late String imageUrl;
  late String title;
  late String url;
  late Widget view;
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
