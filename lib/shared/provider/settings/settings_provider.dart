import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/shared_prefs_helper.dart';

part 'settings_provider.g.dart';

@riverpod
class IsDarkMode extends _$IsDarkMode {
  @override
  bool build() {
    return ref.read(sharedPrefsHelperProvider).getDarkMode() == true;
  }

  Future<void> update(bool value) async {
    await ref.read(sharedPrefsHelperProvider).saveDarkMode(value);
    state = value;
  }
}

@riverpod
class IsKuliahBesok extends _$IsKuliahBesok {
  @override
  bool build() {
    return ref.read(sharedPrefsHelperProvider).getKuliahBesok() ?? true;
  }

  Future<void> update(bool value) async {
    await ref.read(sharedPrefsHelperProvider).saveKuliahBesok(value);
    state = value;
  }
}

@riverpod
class BatasTugas extends _$BatasTugas {
  @override
  int build() {
    return ref.read(sharedPrefsHelperProvider).getBatasTugas() ?? 3;
  }

  Future<void> update(int value) async {
    await ref.read(sharedPrefsHelperProvider).saveBatasTugas(value);
    state = value;
  }
}
