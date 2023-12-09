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

  List<SubjectCard> _subCard = [];
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
                      SubjectCard(
                       leading: AssetImagePath.tcsImg,
                      title: "Theoretical Comp. Science",
                    ),
                    SubjectCard(
                      leading: AssetImagePath.seImg,
                      title: "Software Engineering",
                    ),
                    SubjectCard(
                      leading: AssetImagePath.cnImg,
                      title: "Computer Network", 
                    ),
                    SubjectCard(
                      leading: AssetImagePath.dwmImg,
                      title: "Data Warehousing & Mining",
                    ),
                    SubjectCard(
                      leading: AssetImagePath.adbmsImg,
                      title: "Advance DBMS",
                    ),SubjectCard(
                      leading: AssetImagePath.pceImg,
                      title: "PCE II", 
                    ),
  ];




  
  // final _navigationService = locator<NavigationService>();
}

  navigateToSettingsView() {
    // _navigationService.navigateTo(Routes.settingsView);
  }