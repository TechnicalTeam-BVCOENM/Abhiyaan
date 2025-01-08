import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  static String? appName;
  static String? packageName;
  static String? version;
  static String? buildNumber;

  static Future<void> setUpPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    } catch (e) {
      appName = "Abhiyaan";
      version = "0.0.0";
    }
  }
}
