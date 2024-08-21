import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/home/controller/count_tugas_provider.dart';
import 'package:skedul/features/home/presentation/widgets/statistic_card.dart';
import 'package:skedul/features/jadwal/presentation/controller/jadwal_provider.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jadwal = ref.watch(jadwalProvider(0));
    final tugas = ref.watch(countTugasProvider);
    final isDark = ref.watch(themeChoosenProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ref.watch(sharedPrefsHelperProvider).getName() ?? "",
              style: kTextSemiBold24,
            ),
            const SizedBox(
              height: 10.0,
            ),
            switch (jadwal) {
              AsyncData(:final value) => StatisticCard(
                  number: value.length.toString(),
                  text: "Mata Kuliah",
                  backgroundColor: kColorPrimary,
                  foregroundColor: kColorPrimaryDeep,
                ),
              AsyncError() => const Text("Terjadi Masalah"),
              _ => const StatisticCard(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  number: "0",
                  text: "Mata Kuliah",
                  backgroundColor: kColorPrimary,
                  foregroundColor: kColorPrimaryDeep,
                )
            },
            const SizedBox(
              height: 10.0,
            ),
            switch (tugas) {
              AsyncData(:final value) => StatisticCard(
                  number: value.length.toString(),
                  text: "Total Tugas",
                  backgroundColor: kColorSecondary,
                  foregroundColor: kColorSecondaryDeep,
                ),
              AsyncError() => const Text("Terjadi Masalah"),
              _ => const StatisticCard(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  number: "0",
                  text: "Total Tugas",
                  backgroundColor: kColorSecondary,
                  foregroundColor: kColorSecondaryDeep,
                )
            },
            const SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade100.withOpacity(0.2)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.goNamed("gantinama");
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "Ganti Nama",
                            style: kTextMedium16,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                      color: isDark ? kColorDarkForeground : kColorDark,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.goNamed("pengaturan");
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "Pengaturan",
                            style: kTextMedium16,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                      color: isDark ? kColorDarkForeground : kColorDark,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.goNamed("siakad");
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "Integrasi Siakad",
                            style: kTextMedium16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
