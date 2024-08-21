import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekday.g.dart';

@riverpod
List<String> weekday(WeekdayRef ref) {
  return [
    "Semua",
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];
}
