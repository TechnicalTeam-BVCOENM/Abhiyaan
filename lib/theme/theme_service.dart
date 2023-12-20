import 'package:abhiyaan/file_exporter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeService {
  static const String _key = 'isDark';
  static final _localStorageService = locator<LocalStorageService>();

  final ValueNotifier<bool> valueListenable =
      ValueNotifier<bool>(_localStorageService.read<bool>(_key) ?? false);

  Brightness get brightness =>
      valueListenable.value ? Brightness.dark : Brightness.light;

  void updateTheme() {
    valueListenable.value = !valueListenable.value;
    _localStorageService.write(_key, valueListenable.value);
  }
}
