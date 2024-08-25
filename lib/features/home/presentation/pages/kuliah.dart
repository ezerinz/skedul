import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/home/presentation/controller/active_day_provider.dart';
import 'package:skedul/features/jadwal/presentation/list_jadwal.dart';
import 'package:skedul/shared/provider/date/weekday.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/dotted_card.dart';

class KuliahPage extends ConsumerStatefulWidget {
  const KuliahPage({super.key});

  @override
  ConsumerState<KuliahPage> createState() => _TabKuliahState();
}

class _TabKuliahState extends ConsumerState<KuliahPage> {
  @override
  Widget build(BuildContext context) {
    final day = ref.watch(weekdayProvider);
    final activeDay = ref.watch(activeDayProvider);
    final isDark = ref.watch(isDarkModeProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        SizedBox(
          height: 53,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    ref.read(activeDayProvider.notifier).update(index);
                  },
                  child: DottedBorder(
                    padding: EdgeInsets.zero,
                    // color: index == activeDay ? kColorPrimary : Colors.black,
                    borderType: BorderType.RRect,
                    color:
                        isDark ? AppTheme.kColorDarkForeground : Colors.black,
                    radius: const Radius.circular(8.0),
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        color: (activeDay - 1) == index
                            ? isDark
                                ? AppTheme.kColorPrimary.withOpacity(0.5)
                                : AppTheme.kColorPrimary.withOpacity(0.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          day[index],
                          style: AppTheme.kTextSemiBold24.copyWith(
                            fontSize: 16,
                            color: index == (activeDay - 1)
                                ? Colors.white
                                : isDark
                                    ? AppTheme.kColorDarkForeground
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: day.length,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 92.0),
            child: Column(
              children: [
                ListJadwal(
                  activeDay - 1,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    context.goNamed("tambahjadwal", extra: {
                      "day": activeDay - 1 == 0 ? null : intToDay(activeDay - 1)
                    });
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: DottedCard(
                    icon: Icons.add,
                    text: (activeDay - 1) == 0
                        ? "Tambah jadwal"
                        : "Tambah jadwal untuk\nhari ${intToDay(activeDay - 1)}",
                  ),
                )
              ],
            ),
          ),
        )
      ]),
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: kBottomNavigationBarHeight * 1.42),
        child: FloatingActionButton(
          heroTag: "kuliah-btn",
          backgroundColor: AppTheme.kColorPrimary,
          foregroundColor: Colors.white,
          onPressed: () {
            context.go('/home/add-jadwal');
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
