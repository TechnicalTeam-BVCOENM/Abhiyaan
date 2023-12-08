part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final FirestoreService _firestoreService = FirestoreService();

  // Variables / constants
  String user = LocalStorageService().read('userName');
  // use local storage for this
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
      title: "Society",
      view: const EventView(),
    ),
    QuickLinksModel(
      imageUrl: "assets/images/Rectangle 91.png",
      title: "Blogs",
      url: 'https://www.dev.com/',
    ),
  ];

  // Methods

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

  void toggleExpand(i) {
    try {
      departmentUpdates[i].isExpanded = !departmentUpdates[i].isExpanded;
      if (departmentUpdates[i].isExpanded) {
        departmentUpdates[i].expandedHeight = 125.sp;
        departmentUpdates[i].maxLines = 4;
        departmentUpdates[i].overflow = false;
      } else {
        departmentUpdates[i].expandedHeight = 100.sp;
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
