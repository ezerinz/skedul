import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_instance_provider.dart';

part 'shared_prefs_helper.g.dart';

class SharedPreferencesHelper {
  final SharedPreferences? _prefs;

  SharedPreferencesHelper(this._prefs);

  Future<void> saveName(String name) async {
    await _prefs?.setString('nama', name);
  }

  Future<void> saveDarkMode(bool value) async {
    await _prefs?.setBool("afakah-gelap", value);
  }

  Future<void> saveKuliahBesok(bool value) async {
    await _prefs?.setBool("kuliah-tomorrow", value);
  }

  Future<void> saveJurusan(String value) async {
    await _prefs?.setString("jurusan", value);
  }

  Future<void> saveSemester(String value) async {
    await _prefs?.setString("semester", value);
  }

  Future<void> saveProfilePath(String value) async {
    await _prefs?.setString("profile-path", value);
  }

  Future<void> saveBatasTugas(int value) async {
    await _prefs?.setInt("batas-tugas", value);
  }

  bool? getKuliahBesok() {
    return _prefs?.getBool("kuliah-tomorrow");
  }

  bool? getDarkMode() {
    return _prefs?.getBool("afakah-gelap");
  }

  String? getName() {
    return _prefs?.getString('nama');
  }

  bool isFirstTime() {
    final name = getName();
    return name == null;
  }

  String? getJurusan() {
    return _prefs?.getString("jurusan");
  }

  String? getSemester() {
    return _prefs?.getString("semester");
  }

  String? getProfilePath() {
    return _prefs?.getString("profile-path");
  }

  int? getBatasTugas() {
    return _prefs?.getInt("batas-tugas");
  }
}

@riverpod
SharedPreferencesHelper sharedPrefsHelper(SharedPrefsHelperRef ref) {
  final prefs = ref.watch(sharedPrefsInstanceProvider);

  return SharedPreferencesHelper(prefs);
}
