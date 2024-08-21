import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';

part 'system_theme_provider.g.dart';

@riverpod
class ThemeChoosen extends _$ThemeChoosen {
  @override
  bool build() {
    final sharedPrefs = ref.read(sharedPrefsHelperProvider);
    return sharedPrefs.getTheme() == true;
  }

  change(bool value) {
    state = value;

    final sharedPrefs = ref.read(sharedPrefsHelperProvider);
    sharedPrefs.saveTheme(state);
  }
}
