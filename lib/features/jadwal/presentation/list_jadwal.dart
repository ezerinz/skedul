import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository_provider.dart';
import 'package:skedul/features/jadwal/presentation/controller/jadwal_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/card.dart';
import 'package:skedul/shared/widgets/dotted_card.dart';
import 'package:skedul/shared/widgets/dotted_card_loading.dart';
import 'package:skedul/shared/widgets/slidable_quick_actions.dart';

class ListJadwal extends ConsumerStatefulWidget {
  const ListJadwal(
      {super.key,
      required this.day,
      this.forHomescreen = true,
      this.isTomorrow = false});

  final int day;
  final bool forHomescreen;
  final bool isTomorrow;

  @override
  ConsumerState<ListJadwal> createState() => _ListJadwalState();
}

class _ListJadwalState extends ConsumerState<ListJadwal>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(jadwalProvider(widget.day));
    return switch (data) {
      AsyncData(:final value) => value.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  DottedCard(
                    icon: Icons.not_interested,
                    text: widget.day == 0
                        ? "Jadwal Kosong"
                        : "Jadwal${!widget.isTomorrow ? " hari" : ""} ${widget.forHomescreen ? widget.isTomorrow ? "besok" : "ini" : intToDay(widget.day).toLowerCase()} kosong.\n Selamat berlibur",
                  ),
                  if (!widget.forHomescreen)
                    const SizedBox(
                      height: 15.0,
                    ),
                  if (!widget.forHomescreen)
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        final extra = {"day": intToDay(widget.day)};
                        context.go("/home/add-jadwal",
                            extra: widget.day == 0 ? null : extra);
                      },
                      child: DottedCard(
                        icon: Icons.add,
                        text: widget.day == 0
                            ? "Tambah jadwal"
                            : "Tambah jadwal untuk\nhari ${intToDay(widget.day).toLowerCase()}",
                      ),
                    ),
                ],
              ),
            )
          : SlidableAutoCloseBehavior(
              child: Column(
                children: [
                  ...List.generate(
                    value.length * 2,
                    (index) {
                      final slidableController = SlidableController(this);
                      if (index % 2 == 0) {
                        return const SizedBox(
                          height: 10.0,
                        );
                      } else {
                        var i = index ~/ 2;
                        var kuliah = value[i];
                        return widget.forHomescreen
                            ? CustomCard(
                                title: kuliah.nama,
                                percentColor: kColorPrimary,
                                titleWidget: Row(children: [
                                  Flexible(
                                    child: Text(
                                      kuliah.nama,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "- ${kuliah.kelas}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  )
                                ]),
                                subtitle1: kuliah.ruangan,
                                subtitle2:
                                    "${kuliah.jam} - ${calculateEndTime(kuliah.jam, kuliah.sks)}",
                                backgroundColor: kColorPrimarySilver,
                                foregroundColor: kColorPrimaryDeep,
                              )
                            : SlidableQuickActions(
                                controller: slidableController,
                                delete: () {
                                  ref
                                      .watch(jadwalRepositoryProvider)
                                      .deleteMakul(kuliah.id)
                                      .then((value) {
                                    if (context.canPop()) context.pop();
                                  });
                                },
                                edit: (context) {
                                  context.go("/home/add-jadwal",
                                      extra: {"edit": true, "data": kuliah});
                                },
                                child: ValueListenableBuilder<int>(
                                  valueListenable: slidableController.direction,
                                  builder: (context, value, child) =>
                                      CustomCard(
                                    title: kuliah.nama,
                                    titleWidget: Row(children: [
                                      Flexible(
                                        child: Text(
                                          kuliah.nama,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "- ${kuliah.kelas}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      )
                                    ]),
                                    subtitle1: kuliah.ruangan,
                                    subtitle2:
                                        "${widget.day == 0 ? "${intToDay(kuliah.hari)}, " : ""}${kuliah.jam} - ${calculateEndTime(kuliah.jam, kuliah.sks)}",
                                    backgroundColor: kColorPrimarySilver,
                                    foregroundColor: kColorPrimaryDeep,
                                    percentColor: kColorPrimary,
                                    actionIcon: value == 0
                                        ? Icons.arrow_back_ios_new
                                        : Icons.close,
                                    actionPressed: () {
                                      if (value == 0) {
                                        slidableController.openEndActionPane();
                                      } else {
                                        slidableController.close();
                                      }
                                    },
                                  ),
                                ),
                              );
                      }
                    },
                  ),
                  if (!widget.forHomescreen)
                    const SizedBox(
                      height: 10.0,
                    ),
                  if (!widget.forHomescreen)
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        final extra = {"day": intToDay(widget.day)};
                        context.go("/home/add-jadwal", extra: extra);
                      },
                      child: const DottedCard(
                        icon: Icons.add,
                        text: "Tambah jadwal",
                      ),
                    ),
                  if (!widget.forHomescreen)
                    const SizedBox(
                      height: 15.0,
                    ),
                ],
              ),
            ),
      AsyncError(:final error) => Text(error.toString()),
      _ => const DottedCardLoading()
    };
  }
}
