import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/date/datenow.dart';

part 'calendar_provider.g.dart';

@riverpod
class Calendar extends _$Calendar {
  @override
  DateTime build() {
    return ref.watch(todayDateProvider);
  }

  updateSelected(DateTime date) {
    state = date;
  }
}
