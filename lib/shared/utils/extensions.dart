import 'package:flutter/material.dart';

extension ListSpaceBetween on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) => [
        for (int i = 0; i < length; i++) ...[
          if (i > 0) SizedBox(width: width, height: height),
          this[i],
        ],
      ];
}

extension DateTimeExtensions on DateTime {
  /// Creates a new date time with the given date but with the time
  /// specified from [time]
  DateTime withTime([int hour = 0, int minute = 0]) =>
      DateTime(year, month, day, hour, minute);
}
