import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/auth/data/semester_repository.dart';
import 'package:skedul/features/jadwal/presentation/list_jadwal.dart';
import 'package:skedul/features/tugas/presentation/controller/tugas_by_date_provider.dart';
import 'package:skedul/features/tugas/presentation/list_tugas.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/provider/settings/user_data.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/extensions.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/dotted_card_loading.dart';

class BerandaPage extends ConsumerWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);
    final jurusan = ref.watch(jurusanProvider);
    final isKuliahBesok = ref.watch(isKuliahBesokProvider);
    final semester = ref.watch(semesterRepositoryProvider).getSemesterById(
          ref.watch(currentSemesterProvider),
        );
    final today = ref.read(todayDateProvider);
    final startDate = today;
    final batasHari = ref.watch(batasTugasProvider);
    final endDate = today.add(Duration(days: batasHari + 1)).withTime(0, 0);
    final dataTugas = ref.watch(
      tugasByDateProvider(startDate, endDate),
    );
    final emoji = <String>[
      "❤️",
      "🥰",
      "😘",
      "☺️",
      "🤗",
      "😚",
      "😍",
      "🤭",
      "🫶",
      "🫰",
      "👋",
    ];
    final random = Random();
    final isDark = ref.watch(isDarkModeProvider);
    final profilePicPath = ref.watch(profilePathProvider);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${name.split(' ')[0]}${emoji[random.nextInt(emoji.length)]}',
                      style: AppTheme.kTextSemiBold24,
                    ),
                    Text(
                      "$jurusan | ${int.tryParse(semester?.name ?? "") != null ? "Semester ${semester?.name}" : "${semester?.name}"}",
                      style: AppTheme.kTextMedium16,
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? Colors.grey.shade100.withOpacity(0.1)
                      : Colors.grey.shade100,
                  image: profilePicPath.isEmpty
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(profilePicPath),
                          ),
                        ),
                ),
                child: profilePicPath.isEmpty
                    ? const Icon(
                        Icons.person_outlined,
                        size: 25,
                      )
                    : null,
              ),
            ],
          ),
        ),
        Divider(
          height: 1.0,
          thickness: 1.0,
          color: isDark
              ? AppTheme.kColorDarkForeground.withOpacity(0.5)
              : AppTheme.kColorDark,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom: 92.0, left: 15.0, right: 15.0, top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kuliah hari ini',
                  style: AppTheme.kTextSemiBold24,
                ),
                Text(
                  DateFormat('EEEE, d MMMM', "id_ID").format(
                    ref.watch(todayDateProvider),
                  ),
                  style: AppTheme.kTextMedium16,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ListJadwal(
                  ref.watch(todayDateProvider).weekday,
                  slidable: false,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                if (isKuliahBesok) ...[
                  const Text(
                    'Kuliah besok',
                    style: AppTheme.kTextSemiBold24,
                  ),
                  Text(
                    DateFormat('EEEE, d MMMM', "id_ID").format(
                      ref.watch(todayDateProvider).add(
                            const Duration(days: 1),
                          ),
                    ),
                    style: AppTheme.kTextMedium16,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListJadwal(
                    ref
                        .watch(todayDateProvider)
                        .add(const Duration(days: 1))
                        .weekday,
                    slidable: false,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
                const Text(
                  'Tugas yang dekat',
                  style: AppTheme.kTextSemiBold24,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                switch (dataTugas) {
                  AsyncData(:final value) => ListTugas(
                      getEventsForRange(startDate, endDate, value),
                      slidable: false,
                    ),
                  AsyncError(:final error) => Text("$error"),
                  _ => const DottedCardLoading(),
                }
              ],
            ),
          ),
        ),
      ],
    );
  }
}
