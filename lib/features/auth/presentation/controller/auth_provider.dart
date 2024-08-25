import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/shared_prefs_helper.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  bool build() {
    final isFirstTime = ref.read(sharedPrefsHelperProvider).isFirstTime();
    return isFirstTime;
  }

  //TODO: Add logout/online database integration/something else
}
