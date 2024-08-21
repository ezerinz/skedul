import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/jadwal/presentation/list_jadwal.dart';
import 'package:skedul/features/tugas/presentation/list_tugas.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/provider/settings/kuliah_besok_provider.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';
import 'package:skedul/shared/theme/text.dart';

class BerandaPage extends ConsumerWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(sharedPrefsHelperProvider).getName();
    final isKuliahBesok = ref.watch(isKuliahBesokProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, ${name == null ? "" : name.split(' ')[0]}!',
            style: kTextMedium18,
          ),
          const Text(
            'Kuliah Hari Ini',
            style: kTextSemiBold24,
          ),
          Text(
            DateFormat('EEEE, d MMMM', "id_ID").format(
              ref.watch(todayDateProvider),
            ),
            style: kTextMedium16,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListJadwal(
                    day: ref.watch(todayDateProvider).weekday,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  if (isKuliahBesok)
                    const Text(
                      'Kuliah besok',
                      style: kTextSemiBold24,
                    ),
                  if (isKuliahBesok)
                    Text(
                      DateFormat('EEEE, d MMMM', "id_ID").format(
                        ref.watch(todayDateProvider).add(
                              const Duration(days: 1),
                            ),
                      ),
                      style: kTextMedium16,
                    ),
                  if (isKuliahBesok)
                    ListJadwal(
                      day: ref
                          .watch(todayDateProvider)
                          .add(const Duration(days: 1))
                          .weekday,
                      isTomorrow: true,
                    ),
                  if (isKuliahBesok)
                    const SizedBox(
                      height: 15.0,
                    ),
                  const Text(
                    'Tugas yang dekat',
                    style: kTextSemiBold24,
                  ),
                  ListTugas(
                    selectedDate: ref.watch(todayDateProvider),
                    forHomescreen: true,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
