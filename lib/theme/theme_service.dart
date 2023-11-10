import 'package:darpan/file_exporter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeService {
  static const String key = "isDark";

  static final localStorage = locator<LocalStorageService>();

  final ValueNotifier<bool> brightnessListner =
      ValueNotifier(localStorage.read<bool>(key) ?? false);

  Brightness get brightness =>
      brightnessListner.value ? Brightness.dark : Brightness.light;

  void updateTheme(bool isDark) {
    brightnessListner.value = isDark;
    localStorage.write(key, brightnessListner.value);
  }
}
