import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/home/presentation/controller/calendar_provider.dart';
import 'package:skedul/features/tugas/data/tugas_repository.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/features/tugas/presentation/detail_tugas.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/extensions.dart';
import 'package:skedul/shared/widgets/dotted_card.dart';
import 'package:skedul/shared/widgets/slidable_card.dart';

class ListTugas extends ConsumerWidget {
  const ListTugas(this.value, {super.key, this.slidable = true});
  final List<TugasModel> value;
  final bool slidable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.isEmpty
        ? DottedCard(
            icon: Icons.not_interested,
            text:
                "Tidak ada tugas\n ${slidable ? "pada ${DateFormat("dd MMMM", "ID_id").format(
                    ref.watch(calendarProvider),
                  )}" : "${ref.watch(batasTugasProvider)} hari kedepan"}",
          )
        : Column(
            children: List.generate(
              value.length,
              (index) {
                List<TugasModel> datas = List.from(value);
                datas.sort((a, b) => a.deadline.compareTo(b.deadline));
                final data = datas[index];
                int difference = 0;
                if (!slidable) {
                  difference = data.deadline
                      .toLocal()
                      .difference(ref.read(todayDateProvider).toLocal())
                      .inDays;
                }
                return SlidableCard(
                  title: data.judul,
                  subtitle1: data.makul.nama,
                  subtitle2: "${DateFormat(
                    slidable ? "HH:mm" : "dd MMMM yyyy, HH:mm",
                    "ID_id",
                  ).format(
                    data.deadline.toLocal(),
                  )}${slidable ? "" : " (${difference > 0 ? "$difference hari lagi" : "hari ini"})"}",
                  backgroundColor: AppTheme.kColorPrimarySilver,
                  foregroundColor: AppTheme.kColorSecondary,
                  slidable: slidable,
                  onCardTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      builder: (context) {
                        return DetailTugasBottomSheet(tugas: data);
                      },
                    );
                  },
                  edit: () {
                    context.goNamed("tambahtugas", extra: {
                      "edit": true,
                      "tugas": data,
                    });
                  },
                  delete: () {
                    context.pushNamed("confirm-dialog", extra: [
                      const Text(
                        "Hapus",
                        style: AppTheme.kTextSemiBold24,
                      ),
                      Text(
                        "Apakah kamu yakin untuk menghapus?",
                        style: AppTheme.kTextMedium16.copyWith(fontSize: 14),
                      ),
                      [
                        ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: AppTheme.kColorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.watch(tugasRepositoryProvider).deleteTugas(
                                  data.makul.id,
                                  ObjectId.fromHexString(data.id),
                                );
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
              },
            ).withSpaceBetween(height: 10.0),
          );
  }

  //   final data = ref.watch(
  //     tugasByDateProvider(start, end),
  //   );
  //   return switch (data) {
  //     AsyncData(:final value) => value.isEmpty
  //         ? emptyTugas()
  //         : Column(
  //             children: List.generate(
  //               value.length,
  //               (index) {
  //                 final data = value[index];
  //                 return SlidableCard(
  //                   title: data.judul,
  //                   subtitle1: data.makul.nama,
  //                   subtitle2: DateFormat(
  //                     "dd MMMM yyyy, HH:mm",
  //                     "ID_id",
  //                   ).format(
  //                     data.deadline.toLocal(),
  //                   ),
  //                   backgroundColor: kColorPrimarySilver,
  //                   foregroundColor: kColorSecondary,
  //                   slidable: slidable,
  //                   edit: () {
  //                     context.goNamed("tambahtugas", extra: {
  //                       "edit": true,
  //                       "tugas": data,
  //                     });
  //                   },
  //                   delete: () {
  //                     context.pushNamed("confirm-dialog", extra: [
  //                       const Text(
  //                         "Hapus",
  //                         style: kTextSemiBold24,
  //                       ),
  //                       Text(
  //                         "Apakah kamu yakin untuk menghapus?",
  //                         style: kTextMedium16.copyWith(fontSize: 14),
  //                       ),
  //                       [
  //                         ElevatedButton(
  //                           onPressed: () {
  //                             context.pop();
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             surfaceTintColor: kColorPrimary,
  //                             foregroundColor: kColorPrimary,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                             ),
  //                           ),
  //                           child: const Text("Batal"),
  //                         ),
  //                         ElevatedButton(
  //                           onPressed: () {
  //                             ref.watch(tugasRepositoryProvider).deleteTugas(
  //                                   data.makul.id,
  //                                   ObjectId.fromHexString(data.id),
  //                                 );
  //                             context.pop();
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             surfaceTintColor: kColorSecondary,
  //                             foregroundColor: kColorSecondary,
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                             ),
  //                           ),
  //                           child: const Text("Hapus"),
  //                         ),
  //                       ]
  //                     ]);
  //                   },
  //                 );
  //               },
  //             ).withSpaceBetween(height: 10.0),
  //           ),
  //     AsyncError(:final error) => Text("$error"),
  //     _ => const DottedCardLoading(),
  //   };
  // }
  //
  Padding emptyTugas() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: DottedCard(
        icon: Icons.not_interested,
        text: "Tidak ada tugas\npada tanggal ini",
      ),
    );
  }
}

// class ListTugas extends ConsumerStatefulWidget {
//   const ListTugas(
//       {super.key, required this.selectedDate, this.forHomescreen = false});
//
//   final DateTime selectedDate;
//   final bool forHomescreen;
//
//   @override
//   ConsumerState<ListTugas> createState() => _ListTugasState();
// }
//
// class _ListTugasState extends ConsumerState<ListTugas>
//     with TickerProviderStateMixin {
//   //late SlidableController slidableCtrl;
//   late final SlidableController slidableCtrl = SlidableController(this);
//
//   @override
//   Widget build(BuildContext context) {
//     final data = ref.watch(
//       tugasProvider(widget.selectedDate, tugasDekat: widget.forHomescreen),
//     );
//
//     return switch (data) {
//       AsyncData(:final value) => value.isEmpty
//           ? emptyTugas(context)
//           : SlidableAutoCloseBehavior(
//               child: Column(
//                 children: [
//                   ...List.generate(
//                     value.length * 2,
//                     (index) {
//                       if (index % 2 == 0) {
//                         return const SizedBox(
//                           height: 10.0,
//                         );
//                       } else {
//                         var i = index ~/ 2;
//                         var tugas = value[i];
//                         final dataMakuls = ref.watch(daftarMakulProvider);
//                         List<MataKuliahData> makuls = dataMakuls.when(
//                           data: (d) => d,
//                           error: (_, __) => [],
//                           loading: () => [],
//                         );
//                         var makul = "";
//                         for (MataKuliahData data in makuls) {
//                           if (data.id == tugas.makul) {
//                             makul = data.nama;
//                             break;
//                           }
//                         }
//
//                         SlideController ctrl = SlideController();
//
//                         return widget.forHomescreen
//                             ? CustomCard(
//                                 title: tugas.judul,
//                                 subtitle1: makul,
//                                 subtitle2: widget.forHomescreen
//                                     ? "${tugas.deadline} (${tugas.difference == 0 ? "hari ini" : "${tugas.difference} hari lagi"})"
//                                     : tugas.deadline.split(",")[1].trim(),
//                                 backgroundColor: kColorSecondary,
//                                 foregroundColor: kColorSecondaryDeep,
//                                 onCardTap: () {
//                                   showModalBottomSheet(
//                                     shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10.0),
//                                         topRight: Radius.circular(10.0),
//                                       ),
//                                     ),
//                                     context: context,
//                                     builder: (context) {
//                                       return DetailTugasBottomSheet(
//                                           tugas: tugas);
//                                     },
//                                   );
//                                 },
//                               )
//                             : SlidableCard(
//                                 title: tugas.judul,
//                                 subtitle1: makul,
//                                 subtitle2: widget.forHomescreen
//                                     ? "${tugas.deadline} (${tugas.difference == 0 ? "hari ini" : "${tugas.difference} hari lagi"})"
//                                     : tugas.deadline.split(",")[1].trim(),
//                                 backgroundColor: kColorSecondary,
//                                 foregroundColor: kColorSecondaryDeep,
//                                 onCardTap: () {
//                                   showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) {
//                                       return DetailTugasBottomSheet(
//                                           tugas: tugas);
//                                     },
//                                   );
//                                 },
//                               );
//                       }
//                     },
//                   ),
//                   if (!widget.forHomescreen)
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                   if (!widget.forHomescreen)
//                     InkWell(
//                       borderRadius: BorderRadius.circular(10.0),
//                       onTap: () {
//                         final extra = {"date": widget.selectedDate};
//                         context.go("/home/add-tugas", extra: extra);
//                       },
//                       child: DottedCard(
//                         icon: Icons.add,
//                         text:
//                             "Tambah tugas untuk untuk\n${DateFormat("dd MMMM", "ID_id").format(widget.selectedDate)}",
//                       ),
//                     ),
//                   if (!widget.forHomescreen)
//                     const SizedBox(
//                       height: 15.0,
//                     ),
//                 ],
//               ),
//             ),
//       AsyncError(:final error) => Text("$error"),
//       _ => const DottedCardLoading(),
//     };
//   }
//

//   }
// }
