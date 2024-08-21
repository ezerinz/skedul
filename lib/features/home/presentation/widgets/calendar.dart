import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/home/presentation/controllers/calendar_provider.dart';
import 'package:skedul/features/tugas/presentation/provider/tugas_all_provider.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class CalendarContainer extends ConsumerWidget {
  const CalendarContainer({super.key, required this.rowHeight});
  final double rowHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(calendarProvider);
    final todayDate = ref.watch(todayDateProvider);
    return TableCalendar(
      onDaySelected: (selectedDay, focusedDay) {
        ref.watch(calendarProvider.notifier).updateSelected(selectedDay);
      },
      currentDay: selectedDate,
      eventLoader: (day) {
        final date = ref.watch(tugasAllProvider);
        String currentDay = day.toString();
        currentDay = currentDay.substring(0, currentDay.length - 1);

        return switch (date) {
          AsyncData(:final value) => value[currentDay] ?? [],
          AsyncError() => [],
          _ => [],
        };
      },
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              DateFormat("EEE", "id_ID").format(day).toUpperCase(),
              style: kTextSemiBold24.copyWith(fontSize: 14),
            ),
          );
        },
        singleMarkerBuilder: (context, day, event) {
          if (day == selectedDate) {
            return Container();
          }
          return Container(
            height: 6.0,
            width: 6.0,
            decoration: const BoxDecoration(
              color: kColorSecondary,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
      headerStyle: const HeaderStyle(
        headerPadding: EdgeInsets.only(bottom: 8.0),
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: kColorSecondary,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(fontWeight: FontWeight.w600),
        weekendTextStyle: TextStyle(fontWeight: FontWeight.w600),
        todayTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      availableCalendarFormats: const {CalendarFormat.month: "month"},
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: "id_ID",
      rowHeight: 45.0,
      firstDay: todayDate.subtract(
        const Duration(days: 365 * 2),
      ),
      lastDay: todayDate.add(
        const Duration(days: 365 * 10),
      ),
      focusedDay: selectedDate,
    );
  }
}
