import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_day_provider.g.dart';

@riverpod
class ActiveDay extends _$ActiveDay {
  @override
  int build() {
    return 1;
    // return ref.watch(todayDateProvider).weekday + 1;
  }

  update(int index) {
    state = index + 1;
  }
}
