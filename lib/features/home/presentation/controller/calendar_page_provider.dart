import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_page_provider.g.dart';

@riverpod
class CalendarPage extends _$CalendarPage {
  @override
  DateTime build() {
    return DateTime.now().toLocal();
  }

  update(DateTime value) {
    state = value;
  }
}
