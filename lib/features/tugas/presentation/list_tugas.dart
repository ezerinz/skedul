import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/tugas/data/tugas_repository_provider.dart';
import 'package:skedul/features/tugas/presentation/detail_tugas.dart';
import 'package:skedul/features/tugas/presentation/provider/daftar_makul_provider.dart';
import 'package:skedul/features/tugas/presentation/provider/tugas_provider.dart';
import 'package:skedul/shared/provider/drift/database.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/widgets/card.dart';
import 'package:skedul/shared/widgets/dotted_card.dart';
import 'package:skedul/shared/widgets/dotted_card_loading.dart';
import 'package:skedul/shared/widgets/slidable_quick_actions.dart';

class ListTugas extends ConsumerStatefulWidget {
  const ListTugas(
      {super.key, required this.selectedDate, this.forHomescreen = false});

  final DateTime selectedDate;
  final bool forHomescreen;

  @override
  ConsumerState<ListTugas> createState() => _ListTugasState();
}

class _ListTugasState extends ConsumerState<ListTugas>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(
      tugasProvider(widget.selectedDate, tugasDekat: widget.forHomescreen),
    );

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
                    text: widget.forHomescreen
                        ? "Tidak ada tugas untuk\n 3 hari kedepan"
                        : "Tidak ada tugas\npada tanggal ini",
                  ),
                  if (!widget.forHomescreen)
                    const SizedBox(
                      height: 15.0,
                    ),
                  if (!widget.forHomescreen)
                    InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        final extra = {"date": widget.selectedDate};
                        context.go("/home/add-tugas", extra: extra);
                      },
                      child: DottedCard(
                        icon: Icons.add,
                        text:
                            "Tambah tugas untuk untuk\n${DateFormat("dd MMMM", "ID_id").format(widget.selectedDate)}",
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
                      if (index % 2 == 0) {
                        return const SizedBox(
                          height: 10.0,
                        );
                      } else {
                        var i = index ~/ 2;
                        var tugas = value[i];
                        final dataMakuls = ref.watch(daftarMakulProvider);
                        List<MataKuliahData> makuls = dataMakuls.when(
                          data: (d) => d,
                          error: (_, __) => [],
                          loading: () => [],
                        );
                        var makul = "";
                        for (MataKuliahData data in makuls) {
                          if (data.id == tugas.makul) {
                            makul = data.nama;
                            break;
                          }
                        }
                        final slidableCtrl = SlidableController(this);

                        return widget.forHomescreen
                            ? CustomCard(
                                title: tugas.judul,
                                subtitle1: makul,
                                subtitle2: widget.forHomescreen
                                    ? "${tugas.deadline} (${tugas.difference == 0 ? "hari ini" : "${tugas.difference} hari lagi"})"
                                    : tugas.deadline.split(",")[1].trim(),
                                backgroundColor: kColorSecondary,
                                foregroundColor: kColorSecondaryDeep,
                                onCardTap: () {
                                  showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return DetailTugasBottomSheet(
                                          tugas: tugas);
                                    },
                                  );
                                },
                              )
                            : SlidableQuickActions(
                                groupTag: "1",
                                controller: slidableCtrl,
                                edit: (BuildContext context) {
                                  final extra = {"edit": true, "tugas": tugas};
                                  context.go("/home/add-tugas", extra: extra);
                                },
                                delete: () {
                                  ref
                                      .watch(tugasRepositoryProvider)
                                      .deleteTugas(tugas.id)
                                      .then(
                                    (value) {
                                      context.pop();
                                    },
                                  );
                                },
                                child: ValueListenableBuilder<int>(
                                  valueListenable: slidableCtrl.direction,
                                  builder: (context, value, child) {
                                    return CustomCard(
                                      title: tugas.judul,
                                      subtitle1: makul,
                                      subtitle2: widget.forHomescreen
                                          ? "${tugas.deadline} (${tugas.difference == 0 ? "hari ini" : "${tugas.difference} hari lagi"})"
                                          : tugas.deadline.split(",")[1].trim(),
                                      backgroundColor: kColorSecondary,
                                      foregroundColor: kColorSecondaryDeep,
                                      actionIcon: value == 0
                                          ? Icons.arrow_back_ios_new
                                          : Icons.close,
                                      actionPressed: () {
                                        if (value == 0) {
                                          slidableCtrl.openEndActionPane();
                                        } else {
                                          slidableCtrl.close();
                                        }
                                      },
                                      onCardTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return DetailTugasBottomSheet(
                                                tugas: tugas);
                                          },
                                        );
                                      },
                                    );
                                  },
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
                        final extra = {"date": widget.selectedDate};
                        context.go("/home/add-tugas", extra: extra);
                      },
                      child: DottedCard(
                        icon: Icons.add,
                        text:
                            "Tambah tugas untuk untuk\n${DateFormat("dd MMMM", "ID_id").format(widget.selectedDate)}",
                      ),
                    ),
                  if (!widget.forHomescreen)
                    const SizedBox(
                      height: 15.0,
                    ),
                ],
              ),
            ),
      AsyncError(:final error) => Text("$error"),
      _ => const DottedCardLoading(),
    };
  }
}
