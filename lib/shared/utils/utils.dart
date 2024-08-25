import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/shared/theme/theme.dart';

SnackBar snackBarCustom(bool isDark, String message) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: isDark ? AppTheme.kColorDark : Colors.white,
    margin: const EdgeInsets.all(15.0),
    content: Text(
      message,
      style: TextStyle(
        color: isDark ? AppTheme.kColorDarkForeground : AppTheme.kColorDark,
        fontWeight: FontWeight.w500,
        fontFamily: 'KumbhSans',
      ),
    ),
  );
}

String calculateEndTime(String time, int sks) {
  DateFormat timeFormat = DateFormat("HH:mm");
  DateTime clock = timeFormat.parse(time);

  Duration add = Duration(minutes: 50 * sks);
  DateTime result = clock.add(add);
  return "${result.hour.toString().padLeft(2, "0")}:${result.minute.toString().padLeft(2, "0")}";
}

String intToDay(int day) {
  String result = "Senin";
  switch (day) {
    case 1:
      result = "Senin";
      break;
    case 2:
      result = "Selasa";
      break;
    case 3:
      result = "Rabu";
      break;
    case 4:
      result = "Kamis";
      break;
    case 5:
      result = "Jumat";
      break;
    case 6:
      result = "Sabtu";
      break;
    case 7:
      result = "Minggu";
      break;
  }

  return result;
}

int dayToInt(String day) {
  int result = 1;
  switch (day) {
    case "Senin":
      result = 1;
      break;
    case "Selasa":
      result = 2;
      break;
    case "Rabu":
      result = 3;
      break;
    case "Kamis":
      result = 4;
      break;
    case "Jumat":
      result = 5;
      break;
    case "Sabtu":
      result = 6;
      break;
    case "Minggu":
      result = 7;
      break;
  }

  return result;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

List<TugasModel> getEventsForRange(DateTime start, DateTime end,
    LinkedHashMap<DateTime, List<TugasModel>> data) {
  final days = daysInRange(start, end);

  return [
    for (final d in days) ...data[d] ?? [],
  ];
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
