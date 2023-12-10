part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final FirestoreService _firestoreService = FirestoreService();
  String user = LocalStorageService().read('userName');

  List<QuickLinksModel> quickLinksList = [
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle 88.png",
      title: "BCOENM",
      url: 'https://www.bvcoenm.edu.in/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle_89.png",
      title: "Abhiyaan",
      url: 'https://abhiyaan-2023.netlify.app/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle 90.png",
      title: "Society",
      view: const SocietiesView(),
    ),
    QuickLinksModel(
      imageUrl: "assets/images/home/Rectangle_91.png",
      title: "Blogs",
      url: 'https://www.dev.com/',
    ),
  ];

  List<Activity> _activityList = [
    Activity(
      startTime: TimeOfDay(hour: 11, minute: 15),
      endTime: TimeOfDay(hour: 12, minute: 15),
      subName: "Computer Network",
      profName: "Prof. Aruna Kamble",
      location: "Floor 1, Class Room 137",
    ),
  ];

  List<Activity> get activityList => _activityList;

  List<Map<String, dynamic>> _highlights = [];
  List<Map<String, dynamic>> get highlights => _highlights;
  List<DepartmentUpdates> _departmentUpdates = [];
  List<DepartmentUpdates> get departmentUpdates => _departmentUpdates;

  Future<void> loadData() async {
    setBusy(true);
    try {
      _highlights = await _firestoreService.getAllData('Highlights');
      _departmentUpdates =
          await _firestoreService.getAllDepartmentData('DepartmentUpdate');
      notifyListeners();
      log.i(highlights);
      log.i(highlights.length);
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

