part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = FirestoreService();

  // Variables / constants
  String user = "Kiran"; // use local storage for this
  final fontTheme = FontThemeClass();
  bool isExpanded = false;


  List<QuickLinksModel> quickLinksList = [
    QuickLinksModel(
      imageUrl: "assets/images/Rectangle 88.png",
      title: "BCOENM",
      url: 'https://www.bvcoenm.edu.in/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/Rectangle 89.png",
      title: "Abhiyaan",
      url: 'https://abhiyaan-2023.netlify.app/',
    ),
    QuickLinksModel(
      imageUrl: "assets/images/Rectangle 90.png",
      title: "Event",
      view: const EventView(),
    ),
    QuickLinksModel(
      imageUrl: "assets/images/Rectangle 91.png",
      title: "Blogs",
      url: 'https://www.dev.com/',
    ),
  ];

  // Methods

  List<Map<String, dynamic>> highlights = [];
  List<Map<String, dynamic>> get _highlights => highlights;
  List<DepartmentUpdates> departmentUpdates = [];
  List<DepartmentUpdates> get _departmentUpdates => departmentUpdates;

  Future<void> loadData() async {
    setBusy(true);
    try {
      highlights = await _firestoreService.getAllData('Highlights');
      departmentUpdates =
          await _firestoreService.getAllDepartmentData('DepartmentUpdate');
      notifyListeners();
      log.i(highlights);
      log.i(highlights.length);
      print(DateFormat("MMMM d").format((departmentUpdates[0].date).toDate()));
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
  }

  void toggleExpand(i) {
    try {
      departmentUpdates[i].isExpanded = !departmentUpdates[i].isExpanded;
      if (departmentUpdates[i].isExpanded) {
        departmentUpdates[i].expandedHeight = 125.hWise;
        departmentUpdates[i].maxLines = 4;
        departmentUpdates[i].overflow = false;
      } else {
        departmentUpdates[i].expandedHeight = 100.hWise;
        departmentUpdates[i].maxLines = 2;
        departmentUpdates[i].overflow = true;
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void updateActiveIndex(int newIndex) {
    _activeIndex = newIndex;
    notifyListeners();
  }

  Future<void> signOut() async {
    setBusy(true);
    final success = await _authenticationService.signOut();
    if (success) {
      log.i('sign out success');
      _navigationService.clearStackAndShow(Routes.authView);
    } else {
      log.i('sign out failed');
    }
    setBusy(false);
  }
}

void handleQuickLinksNavigation(List model, int i) {
  try {
    if (model[i].url != '' && model[i].url != null) {
      debugPrint("Route Url");
      UrlLauncher externalUrlHandler = UrlLauncher();
      externalUrlHandler.launchURL(
        Uri.parse(model[i].url),
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
  bool isExpanded;
  double expandedHeight;
  int maxLines;
  bool overflow;

  DepartmentUpdates({
    required this.title,
    required this.description,
    required this.date,
    this.isExpanded = false,
    this.expandedHeight = 100.0,
    this.maxLines = 2,
    this.overflow = true,
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
