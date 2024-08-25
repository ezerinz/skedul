import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository.dart';
import 'package:skedul/features/jadwal/presentation/controller/jadwal_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/extensions.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/dotted_card.dart';
import 'package:skedul/shared/widgets/dotted_card_loading.dart';
import 'package:skedul/shared/widgets/slidable_card.dart';

class ListJadwal extends ConsumerStatefulWidget {
  const ListJadwal(this.day, {super.key, this.slidable = true});

  final int day;
  final bool slidable;

  @override
  ConsumerState<ListJadwal> createState() => _ListJadwalState();
}

class _ListJadwalState extends ConsumerState<ListJadwal> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(
      jadwalProvider(
        widget.day,
      ),
    );

    return switch (data) {
      AsyncData(:final value) => value.isEmpty
          ? const DottedCard(
              icon: Icons.not_interested,
              text: "Tidak ada kuliah,\nselamat berlibur",
            )
          : Column(
              children: List.generate(value.length, (index) {
                final data = value[index];
                return SlidableCard(
                  title: "${data.nama} - ${data.kelas}",
                  subtitle1: data.ruangan,
                  subtitle2:
                      "${widget.day == 0 ? "${intToDay(data.hari)}, " : ""}${data.jam!.hour.toString().padLeft(2, "0")}:${data.jam!.minute.toString().padLeft(2, "0")} - ${calculateEndTime("${data.jam!.hour}:${data.jam!.minute}", data.sks)}",
                  backgroundColor: AppTheme.kColorPrimarySilver,
                  foregroundColor: AppTheme.kColorPrimary,
                  slidable: widget.slidable,
                  edit: () {
                    context.goNamed("tambahjadwal", extra: {
                      "edit": true,
                      "data": data,
                    });
                  },
                  delete: () {
                    context.pushNamed("confirm-dialog", extra: [
                      const Text(
                        "Hapus",
                        style: AppTheme.kTextSemiBold24,
                      ),
                      Text(
                        "Apakah kamu yakin untuk menghapus? Semua tugas untuk mata kuliah ini akan terhapus",
                        textAlign: TextAlign.center,
                        style: AppTheme.kTextMedium16.copyWith(fontSize: 14),
                      ),
                      [
                        ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: AppTheme.kColorPrimary,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .watch(jadwalRepositoryProvider)
                                .deleteMakul(data.id);
                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: AppTheme.kColorSecondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text("Hapus"),
                        ),
                      ]
                    ]);
                  },
                );
              }).withSpaceBetween(height: 10.0),
            ),
      AsyncError(
        :final error,
      ) =>
        Text("$error"),
      _ => const DottedCardLoading()
    };
  }
}
