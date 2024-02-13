part of 'societies_view.dart';

final AnalyticsService _analyticsService = locator<AnalyticsService>();

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
      _analyticsService.logScreen(screenName: 'SocietiesView Screen Opened');
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
  }

  List<SocietyData> allsocietyCards = [
    const SocietyData(
      title: "Nautanki",
      value:
          "The Nautanki Club is where dreams take center stage, and reality plays a supporting role.",
      leading: AssetImagePath.nautankiImg,
      url: "https://www.instagram.com/nautanki_bvcoenm/",
    ),
    const SocietyData(
      title: "Crew 5678",
      value:
          "Dance is the hidden language of the soul, and in our crew, we speak it fluently.",
      leading: AssetImagePath.crew_5678Img,
      url: "https://www.instagram.com/crew_5678/",
    ),
    const SocietyData(
      title: "CamEra",
      value:
          "Photography is the art of frozen time. Our club, the artists of the shutter, freeze memories to last a lifetime.",
      leading: AssetImagePath.camEraImg,
      url: "https://www.instagram.com/_cam_era/",
    ),
    const SocietyData(
      title: "Literature",
      value:
          "Literature is art of crafting world with words, & our club is a canvas where literary masterpieces come to life.",
      leading: AssetImagePath.literatureImg,
      url: "https://www.instagram.com/the.literature.club/",
    ),
    const SocietyData(
      title: "Mudrakala",
      value:
          "Within the strokes of our imagination, the Mudrakala Club unveils a gallery of creativity.",
      leading: AssetImagePath.mudrakalaImg,
      url: "https://www.instagram.com/mudra_kala/",
    ),
    const SocietyData(
      title: "Crescendo",
      value:
          "Club where individual notes unite in a symphony of diversity, composing the vibrant melody of our shared passion.",
      leading: AssetImagePath.crescendoImg,
      url: "https://www.instagram.com/crescendo_the.music.society/",
    ),
  ];
}

class SocietyData {
  final String title;
  final String value;
  final String leading;
  final String url;

  const SocietyData({
    required this.title,
    required this.value,
    required this.leading,
    required this.url,
  });
}
