import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datenow.g.dart';

@riverpod
DateTime todayDate(TodayDateRef ref) {
  return DateTime.now();
}
