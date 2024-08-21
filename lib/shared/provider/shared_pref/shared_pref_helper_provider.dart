import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/helper.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_instance_provider.dart';

part 'shared_pref_helper_provider.g.dart';

@riverpod
SharedPreferencesHelper sharedPrefsHelper(SharedPrefsHelperRef ref) {
  final prefs = ref.watch(sharedPrefsInstanceProvider);

  return SharedPreferencesHelper(prefs);
}
