part of 'societies_view.dart';

class SocietiesViewModel extends BaseViewModel {
  // final FirestoreService _firestoreService = FirestoreService();
  final log = getLogger('SocietiesViewModel');

  void init() async {
    await loadData();
  }

  final List<SocietyCard> _societyCard = [];
  List<SocietyCard> get societyCard => _societyCard;

  Future<void> loadData() async {
    setBusy(true);
    try {
      // _subCard = await _firestoreService.getallSubCards();

      log.i(_societyCard[0].title);
      notifyListeners();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
    log.i("Subject Loaded");
  }

  List<SocietyCard> allsocietyCards = [
    const SocietyCard(
                    title: "Nautanki",
                    value: "The Nautanki Club is where dreams take center stage, and reality plays a supporting role.",
                    leading: AssetImagePath.nautankiImg,
                  ),
                  const SocietyCard(
                    title: "Crew 5678",
                    value: "Dance is the hidden language of the soul, and in our crew, we speak it fluently.",
                    leading: AssetImagePath.crew_5678Img,
                  ),
                  const SocietyCard(
                    title: "CamEra",
                    value: "Photography is the art of frozen time. Our club, the artists of the shutter, freeze memories to last a lifetime.",
                    leading: AssetImagePath.camEraImg,
                  ),
                  const SocietyCard(
                    title: "Literature",
                    value: "Literature is art of crafting world with words, & our club is a canvas where literary masterpieces come to life.",
                    leading: AssetImagePath.literatureImg,
                  ),
                  const SocietyCard(
                    title: "Mudrakala",
                    value: "Within the strokes of our imagination, the Mudrakala Club unveils a gallery of creativity.",
                    leading: AssetImagePath.mudrakalaImg,
                  ),
                  const SocietyCard(
                    title: "Crescendo",
                    value: "Club where individual notes unite in a symphony of diversity, composing the vibrant melody of our shared passion.",
                    leading: AssetImagePath.crescendoImg,
    ),
  ];

  // final _navigationService = locator<NavigationService>();
}

navigateToSettingsView() {
  // _navigationService.navigateTo(Routes.settingsView);
}
