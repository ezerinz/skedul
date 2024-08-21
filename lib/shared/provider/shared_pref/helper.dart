import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences? _prefs;

  SharedPreferencesHelper(this._prefs);

  Future<void> saveName(String name) async {
    await _prefs?.setString('name', name);
  }

  Future<void> saveTheme(bool value) async {
    await _prefs?.setBool("theme", value);
  }

  Future<void> saveKuliahBesok(bool value) async {
    await _prefs?.setBool("kuliah-tmrw", value);
  }

  bool? getKuliahBesok() {
    final theme = _prefs?.getBool('kuliah-tmrw');
    return theme;
  }

  bool? getTheme() {
    final theme = _prefs?.getBool('theme');
    return theme;
  }

  String? getName() {
    final name = _prefs?.getString('name');
    return name;
  }

  bool isFirstTime() {
    final name = getName();
    return name == null;
  }
}
