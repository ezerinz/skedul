import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  bool build() {
    final isFirstTime = ref.watch(sharedPrefsHelperProvider).isFirstTime();
    return isFirstTime;
  }

  //TODO: Add logout/something else
}
