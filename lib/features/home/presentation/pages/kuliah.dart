import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:skedul/features/home/presentation/controllers/active_day_provider.dart';
import 'package:skedul/features/jadwal/presentation/list_jadwal.dart';
import 'package:skedul/shared/provider/date/weekday.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class KuliahPage extends ConsumerStatefulWidget {
  const KuliahPage({super.key});

  @override
  ConsumerState<KuliahPage> createState() => _TabKuliahState();
}

class _TabKuliahState extends ConsumerState<KuliahPage> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     itemScrollController.jumpTo(
    //         index: ref.watch(activeDayProvider), alignment: 0.5);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final day = ref.watch(weekdayProvider);
    final activeDay = ref.watch(activeDayProvider);
    final isDark = ref.watch(themeChoosenProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        SizedBox(
          height: 53,
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
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
                    ref.watch(activeDayProvider.notifier).update(index);
                  },
                  child: DottedBorder(
                    padding: EdgeInsets.zero,
                    // color: index == activeDay ? kColorPrimary : Colors.black,
                    borderType: BorderType.RRect,
                    color: isDark ? kColorDarkForeground : Colors.black,
                    radius: const Radius.circular(8.0),
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        color: (activeDay - 1) == index
                            ? isDark
                                ? kColorPrimary.withOpacity(0.5)
                                : kColorPrimary.withOpacity(0.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          day[index],
                          style: kTextSemiBold24.copyWith(
                            fontSize: 16,
                            color: index == (activeDay - 1)
                                ? Colors.white
                                : isDark
                                    ? kColorDarkForeground
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListJadwal(
              day: activeDay - 1,
              forHomescreen: false,
            ),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: "kuliah-btn",
        backgroundColor: kColorPrimary,
        foregroundColor: Colors.white,
        onPressed: () {
          context.go('/home/add-jadwal');
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
