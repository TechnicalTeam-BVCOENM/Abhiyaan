part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final FirestoreService _firestoreService = FirestoreService();
  final navigationService = locator<NavigationService>();
  List<String> firstname = [];
  List<Activity> get activityList => _activityList;
  List<Map<String, dynamic>> _highlights = [];
  List<Map<String, dynamic>> get highlights => _highlights;
  List<DepartmentUpdates> _departmentUpdates = [];
  List<DepartmentUpdates> get departmentUpdates => _departmentUpdates;
  late bool isUserNew = LocalStorageService().read('isUserNew');


  String splitusername() {
    final user = LocalStorageService().read('userName');
    firstname = user.split(' ');
    log.i(isUserNew);
    return firstname[0];
  }

  bool toggleUpgradePopup() {
    isUserNew = false;
    _firestoreService
        .updateUserStatus()
        .then((value) => LocalStorageService().write('isUserNew', isUserNew));
    notifyListeners();
    return isUserNew;
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
      _highlights = await _firestoreService.getHighlights();
      _departmentUpdates = await _firestoreService.getCollegeUpdates();
      notifyListeners();
      log.i(highlights);
      log.i(highlights.length);
      if (isUserNew == true) {
        showWelcomPopUp(context);
      }
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

  void showWelcomPopUp(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();
    showAdaptiveDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: context.colorScheme.secondaryWhiteColor,
            title: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                AnimationAssets.welcome,
                repeat: true,
                reverse: false,
                frameRate: FrameRate(60),
                fit: BoxFit.contain,
              ),
            ),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  Text(
                    splitusername(),
                    style: fontThemeClass.title(
                      context,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Image.asset(
                        AssetImagePath.community,
                        width: 40.w,
                        height: 40.h,
                      ).animate(delay: 300.ms).fadeIn().shake(
                            delay: 500.ms,
                            curve: Curves.easeInOut,
                            duration: 1000.ms,
                          ),
                      16.horizontalSpace,
                      Expanded(
                        child: Text(
                          "We are thrilled to have you join our digital community!",
                          style: fontThemeClass.body(context),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Image.asset(
                        AssetImagePath.poper,
                        width: 40.w,
                        height: 40.h,
                      ).animate(delay: 300.ms).fadeIn().shake(
                            delay: 500.ms,
                            curve: Curves.easeInOut,
                            duration: 1000.ms,
                          ),
                      16.horizontalSpace,
                      Expanded(
                        child: Text(
                          "Explore events, from cultural festivals to academic seminars.",
                          style: fontThemeClass.body(context),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12).r,
                ),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    toggleUpgradePopup();
                    Navigator.of(context).pop();
                    debugPrint("✅✅ Upgrade Popup Shown $isUserNew");
                  },
                  child: Text(
                    "Let's Go!",
                    style: fontThemeClass.body(
                      context,
                      color: context.colorScheme.secondaryWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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
