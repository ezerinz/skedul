import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class DeadlineCalendar extends ConsumerStatefulWidget {
  const DeadlineCalendar(this.selectedDate, this.onAccept, {super.key});
  final DateTime selectedDate;
  final ValueChanged<DateTime?>? onAccept;

  @override
  ConsumerState<DeadlineCalendar> createState() => _DeadlineCalendarState();
}

class _DeadlineCalendarState extends ConsumerState<DeadlineCalendar> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            currentDay: selectedDate,
            availableCalendarFormats: const {CalendarFormat.month: "month"},
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                selectedDate = selectedDay;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            locale: "id_ID",
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
            headerStyle: const HeaderStyle(
              headerPadding: EdgeInsets.only(bottom: 8.0),
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
              return Center(
                child: Text(
                  DateFormat("EEE", "id_ID").format(day).toUpperCase(),
                  style: AppTheme.kTextSemiBold24.copyWith(fontSize: 14),
                ),
              );
            }),
            focusedDay: selectedDate,
            firstDay: ref.watch(todayDateProvider).subtract(
                  const Duration(
                    days: 365 * 5,
                  ),
                ),
            lastDay: ref.watch(todayDateProvider).add(
                  const Duration(
                    days: 365 * 5,
                  ),
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "KumbhSans",
                  ),
                  foregroundColor: AppTheme.kColorSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                  ),
                ),
                child: const Text(
                  "Batal",
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onAccept?.call(selectedDate);
                  context.pop();
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontFamily: "KumbhSans"),
                  foregroundColor: AppTheme.kColorSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                  ),
                ),
                child: const Text("Simpan"),
              )
            ],
          )
        ],
      ),
    );
  }
}
