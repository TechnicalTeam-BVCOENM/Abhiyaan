part of 'societies_view.dart';

class SocietiesViewModel extends BaseViewModel {
  final log = getLogger('SocietiesViewModel');

  void init() async {
    await loadData();
  }

  final List<SocietyData> _societyDataList = [];
  List<SocietyData> get societyDataList => _societyDataList;

  Future<void> loadData() async {
    setBusy(true);
    try {
      log.i(_societyDataList[0].title);
      notifyListeners();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
    log.i("Subject Loaded");
  }

  List<SocietyData> allsocietyCards = [
    const SocietyData(
      title: "Nautanki",
      value:
          "The Nautanki Club is where dreams take center stage, and reality plays a supporting role.",
      leading: AssetImagePath.nautankiImg,
    ),
    const SocietyData(
      title: "Crew 5678",
      value:
          "Dance is the hidden language of the soul, and in our crew, we speak it fluently.",
      leading: AssetImagePath.crew_5678Img,
    ),
    const SocietyData(
      title: "CamEra",
      value:
          "Photography is the art of frozen time. Our club, the artists of the shutter, freeze memories to last a lifetime.",
      leading: AssetImagePath.camEraImg,
    ),
    const SocietyData(
      title: "Literature",
      value:
          "Literature is art of crafting world with words, & our club is a canvas where literary masterpieces come to life.",
      leading: AssetImagePath.literatureImg,
    ),
    const SocietyData(
      title: "Mudrakala",
      value:
          "Within the strokes of our imagination, the Mudrakala Club unveils a gallery of creativity.",
      leading: AssetImagePath.mudrakalaImg,
    ),
    const SocietyData(
      title: "Crescendo",
      value:
          "Club where individual notes unite in a symphony of diversity, composing the vibrant melody of our shared passion.",
      leading: AssetImagePath.crescendoImg,
    ),
  ];
}

class SocietyData {
  final String title;
  final String value;
  final String leading;

  const SocietyData({
    required this.title,
    required this.value,
    required this.leading,
  });
}
