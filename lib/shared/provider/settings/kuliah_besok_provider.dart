import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';

part 'kuliah_besok_provider.g.dart';

@riverpod
class IsKuliahBesok extends _$IsKuliahBesok {
  @override
  bool build() {
    final sharedPrefs = ref.watch(sharedPrefsHelperProvider);
    bool? kuliahBesok = sharedPrefs.getKuliahBesok();
    if (kuliahBesok == null) {
      sharedPrefs.saveKuliahBesok(true);
    }

    return kuliahBesok ?? true;
  }

  change(bool value) {
    state = value;

    ref.read(sharedPrefsHelperProvider).saveKuliahBesok(value);
  }
}
