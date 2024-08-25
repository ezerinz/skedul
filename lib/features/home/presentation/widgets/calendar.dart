import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/home/presentation/controller/calendar_page.dart';
import 'package:skedul/features/home/presentation/controller/calendar_provider.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarContainer extends ConsumerStatefulWidget {
  const CalendarContainer(this.events, {super.key, required this.rowHeight});
  final double rowHeight;
  final LinkedHashMap<DateTime, List<TugasModel>> events;

  @override
  ConsumerState<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends ConsumerState<CalendarContainer> {
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(calendarProvider);
    final todayDate = ref.watch(todayDateProvider).toLocal();

    return TableCalendar(
      calendarFormat: calendarFormat,
      onPageChanged: (date) {
        ref.read(calendarProvider.notifier).updateSelected(
              selectedDate.copyWith(
                  month: date.month,
                  day: calendarFormat == CalendarFormat.week ? date.day : null),
            );
        ref.read(calendarPageProvider.notifier).update(date);
      },
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(selectedDate, selectedDay)) {
          ref.watch(calendarProvider.notifier).updateSelected(selectedDay);
        }
      },
      currentDay: ref.watch(todayDateProvider).toLocal(),
      eventLoader: (dates) {
        return widget.events[dates] ?? [];
      },
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat("MMMM yyyy", "ID_id").format(day),
                  style: AppTheme.kTextSemiBold18,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (CalendarFormat.month == calendarFormat) {
                      calendarFormat = CalendarFormat.week;
                    } else {
                      calendarFormat = CalendarFormat.month;
                    }
                  });
                },
                icon: Icon(calendarFormat == CalendarFormat.month
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ),
            ],
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              "${day.day}",
              style: const TextStyle(
                color: AppTheme.kColorSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return Center(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: AppTheme.kColorSecondary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "${focusedDay.day}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              DateFormat("EEE", "id_ID").format(day).toUpperCase(),
              style: AppTheme.kTextSemiBold24.copyWith(fontSize: 14),
            ),
          );
        },
        singleMarkerBuilder: (context, day, event) {
          return Container(
            height: 4.0,
            width: 4.0,
            margin: EdgeInsets.only(
                top: selectedDate == day ? 8.0 : 0, left: 0.5, right: 0.5),
            decoration: const BoxDecoration(
              color: AppTheme.kColorSecondary,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
      headerStyle: const HeaderStyle(
        headerPadding: EdgeInsets.only(bottom: 8.0),
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppTheme.kColorSecondary,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(fontWeight: FontWeight.w600),
        weekendTextStyle: TextStyle(fontWeight: FontWeight.w600),
        todayTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      // onFormatChanged: (format) {
      //   setState(() {
      //     calendarFormat = format;
      //   });
      // },
      availableCalendarFormats: const {
        CalendarFormat.month: "",
        CalendarFormat.week: ""
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: "id_ID",
      rowHeight: widget.rowHeight,
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
