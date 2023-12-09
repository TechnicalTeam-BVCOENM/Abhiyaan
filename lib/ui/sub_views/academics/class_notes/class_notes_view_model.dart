part of 'class_notes_view.dart';

class ClassNotesViewModel extends BaseViewModel {
  // final FirestoreService _firestoreService = FirestoreService();
  final log = getLogger('ClassNotesViewModel');

  // List<String> subName = [
  //   "Theoretical Computer Science",
  //   "Software Engineering",
  //   "Computer Network",
  //   "Data Warehousing & Mining",
  //   "Advance Datamanagement System",
  //   "Professional Communication & Ethics II",
  // ];
  // List<String> iconImages = [
  //   "tcsIMG",
  //   "seImg",
  //   "cnImg",
  //   "dwmImg",
  //   "adbmsImg",
  //   "pceImg",
  // ];

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
                       leading: AssetImagePath.tcsImg,
                      title: "Theoretical Comp. Science",
                    ),
                    const SubjectCard(
                      leading: AssetImagePath.seImg,
                      title: "Software Engineering",
                    ),
                    const SubjectCard(
                      leading: AssetImagePath.cnImg,
                      title: "Computer Network", 
                    ),
                    const SubjectCard(
                      leading: AssetImagePath.dwmImg,
                      title: "Data Warehousing & Mining",
                    ),
                    const SubjectCard(
                      leading: AssetImagePath.adbmsImg,
                      title: "Advance DBMS",
                    ),const SubjectCard(
                      leading: AssetImagePath.pceImg,
                      title: "PCE II", 
                    ),
  ];




  
  // final _navigationService = locator<NavigationService>();
}

  navigateToSettingsView() {
    // _navigationService.navigateTo(Routes.settingsView);
  }