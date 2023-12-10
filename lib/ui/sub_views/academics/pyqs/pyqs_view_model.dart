part of 'pyqs_view.dart';

class PyqsViewModel extends BaseViewModel {
  // final FirestoreService _firestoreService = FirestoreService();
  final log = getLogger('PyqsViewModel');

  void init() async {
    await loadData();
  }

  final List<SubjectCard> _subCard = [];
  List<SubjectCard> get subCard => _subCard;

  Future<void> loadData() async {
    setBusy(true);
    try {
      // _subCard = await _firestoreService.getallSubCards();

      log.i(_subCard[0].title);
      notifyListeners();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
    log.i("Subject Loaded");
  }

  List<SubjectCard> allSubCards = [
    const SubjectCard(
      title: "Theoretical Computer Science",
    ),
    const SubjectCard(
      title: "Software Engineering",
    ),
    const SubjectCard(
      title: "Computer Network",
    ),
    const SubjectCard(
      title: "Data Warehousing & Mining",
    ),
    const SubjectCard(
      title: "Advance Database Management",
    ),
  ];

  // final _navigationService = locator<NavigationService>();
}

navigateToSettingsView() {
  // _navigationService.navigateTo(Routes.settingsView);
}
