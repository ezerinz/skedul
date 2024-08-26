import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/home/presentation/controller/calendar_page_provider.dart';
import 'package:skedul/features/home/presentation/controller/calendar_provider.dart';
import 'package:skedul/features/home/presentation/widgets/calendar.dart';
import 'package:skedul/features/tugas/presentation/controller/tugas_by_date_provider.dart';
import 'package:skedul/features/tugas/presentation/list_tugas.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/widgets/dotted_card.dart';
import 'package:skedul/shared/widgets/dotted_card_loading.dart';

class TugasPage extends ConsumerWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(calendarProvider);
    final calendarPages = ref.watch(calendarPageProvider);
    final startDate =
        calendarPages.copyWith(day: 1).subtract(const Duration(days: 1));
    final endDate =
        calendarPages.copyWith(month: calendarPages.month + 1, day: 1);

    final dataTugas = ref.watch(
      tugasByDateProvider(startDate, endDate),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            switch (dataTugas) {
              AsyncData(:final value) =>
                CalendarContainer(value, rowHeight: 45.0),
              AsyncError(:final error) => Text("$error"),
              _ => CalendarContainer(LinkedHashMap(), rowHeight: 45.0)
            },
            const Divider(
              thickness: 1.0,
            ),
            switch (dataTugas) {
              AsyncData(:final value) => Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 92.0),
                  child: Column(
                    children: [
                      ListTugas(
                        value[selectedDay.toLocal()] ?? [],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          context.goNamed(
                            "tambahtugas",
                            extra: {"date": ref.watch(calendarProvider)},
                          );
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: DottedCard(
                            icon: Icons.add,
                            text:
                                "Tambahkan tugas\nuntuk ${DateFormat("dd MMMM", "ID_id").format(ref.watch(calendarProvider))}"),
                      )
                    ],
                  ),
                ),
              AsyncError(:final error) => Text("$error"),
              _ => const DottedCardLoading(),
            },
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: kBottomNavigationBarHeight * 1.7),
        child: FloatingActionButton(
          heroTag: "tugas-btn",
          backgroundColor: AppTheme.kColorSecondary,
          foregroundColor: Colors.white,
          onPressed: () {
            context.go('/home/add-tugas');
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
