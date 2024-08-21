import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/home/presentation/controllers/calendar_provider.dart';
import 'package:skedul/features/home/presentation/widgets/calendar.dart';
import 'package:skedul/features/tugas/presentation/list_tugas.dart';
import 'package:skedul/shared/theme/colors.dart';

class TugasPage extends ConsumerWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(children: [
          const CalendarContainer(rowHeight: 45.0),
          const Divider(
            thickness: 1.0,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListTugas(
              selectedDate: ref.watch(calendarProvider),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "tugas-btn",
        backgroundColor: kColorSecondary,
        foregroundColor: Colors.white,
        onPressed: () {
          context.go('/home/add-tugas');
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
