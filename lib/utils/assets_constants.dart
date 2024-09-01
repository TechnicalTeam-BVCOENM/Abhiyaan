import 'package:abhiyaan/services/local_storage_service.dart';

class AssetImagePath {
  static const String copyImg = 'assets/images/profile/copy.png';
  static const String login = 'assets/images/login.png';
  static const String settingImg = 'assets/images/profile/setting.png';
  static const String misImg = 'assets/images/profile/mis.png';
  static const String prnImg = 'assets/images/profile/prn_no.png';
  static const String idImg = 'assets/images/profile/id.png';
  static const String instagramImg =
      'assets/images/profile/instagram_square.png';
  static const String libraryImg = 'assets/images/profile/library.png';
  static const String xImg =
      'assets/images/profile/twitter_square-modified.png';
  static const String emailImg = 'assets/images/profile/gmail.png';
  static const String phoneImg = 'assets/images/profile/phone.png';
  static const String certificateImg = 'assets/images/profile/certificate.png';
  static const String linkedinImg = 'assets/images/profile/linkedin_square.png';
  static const String logoImg = 'assets/images/abhiyaan_logo.png';
  static const String boy = 'assets/images/onboarding/boy1.png';
  static const String heart = 'assets/images/onboarding/heart.png';
  static const String connect = 'assets/images/onboarding/connect.png';
  static const String events = 'assets/images/onboarding/events.png';

  static const String darkMode = 'assets/images/profile/dark_mode.png';
  static const String profileBackLines = 'assets/images/profile/lines.png';
  static const String help = 'assets/images/profile/help.png';
  static const String logout = 'assets/images/profile/logout.png';
  static const String pass = 'assets/images/profile/pass.png';
  static const String privacy = 'assets/images/profile/privacy.png';
  static const String nautankiImg = 'assets/images/home/societies/Nautanki.png';
  static const String crew_5678Img =
      'assets/images/home/societies/Crew_5678.png';
  static const String camEraImg = 'assets/images/home/societies/CamEra.png';
  static const String literatureImg =
      'assets/images/home/societies/Literature.png';
  static const String mudrakalaImg =
      'assets/images/home/societies/Mudrakala.png';
  static const String crescendoImg =
      'assets/images/home/societies/Crescendo.png';
  static const String poper = 'assets/images/home/poper.png';
  static const String community = 'assets/images/home/community.webp';
  static const String emptyPerson = 'assets/images/community/profile.png';
  static const String bulb = 'assets/images/community/bulb.webp';
}

class AssetUrls {
  static String profileImageUrl =
      LocalStorageService().read('userProfileImageUrl');
  static const dummyImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/darpan-b94d6.appspot.com/o/user%2Fimages.jpeg?alt=media&token=a9889ba7-3958-4784-9708-e43ade1016d4";
  static const instagramUrl = "https://www.instagram.com/thedevcrew/";
  static const linkedinUrl = "https://www.linkedin.com/company/the-dev-crew/";
  static const twitterUrl = "https://x.com/thedevcrew_";
}

class AnimationAssets {
  static const String welcome = 'assets/animations/welcome.json';
  static const String handLoading = 'assets/animations/hand_loading.json';
}

class AppConstants {
  static const String appVersion = '1.1.5';
}
