part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('HomeViewModel');
  final fontTheme = FontThemeClass();
  final currentIndex = 3;
  String user = "Sachin";

  final PageController pageController = PageController();
  List<DepartmentUpdates> departmentUpdatesList = [
    DepartmentUpdates(
        name: "Placement",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        date: "Today"),
    DepartmentUpdates(
        name: "Placement",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        date: "20-08-23"),
    DepartmentUpdates(
        name: "Placement",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        date: "18-09-23"),
  ];

  // Container expand controller
  bool isExpanded = false;
  var expandedHeight = 90.hWise;
  var maxLines = 2;
  void toggleExpand() {
    isExpanded = !isExpanded;
    if (isExpanded) {
      expandedHeight = 200.hWise;
      maxLines = 10;
    } else {
      expandedHeight = 90.hWise;
      maxLines = 2;
    }
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

// Deparament Updates Model
class DepartmentUpdates {
  late String name;
  late String description;
  late String date;

  DepartmentUpdates({
    required this.name,
    required this.description,
    required this.date,
  });
}
