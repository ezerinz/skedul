import 'package:intl/intl.dart';

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
