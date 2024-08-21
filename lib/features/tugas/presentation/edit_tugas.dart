import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/tugas/data/tugas_repository_provider.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/features/tugas/presentation/provider/daftar_makul_provider.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/provider/drift/database.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';
import 'package:table_calendar/table_calendar.dart';

class EditTugasScreen extends ConsumerStatefulWidget {
  const EditTugasScreen({super.key, this.date, this.edit, this.tugas});
  final DateTime? date;
  final bool? edit;
  final TugasModel? tugas;

  @override
  ConsumerState<EditTugasScreen> createState() => _EditTugasScreenState();
}

class _EditTugasScreenState extends ConsumerState<EditTugasScreen> {
  int? selectedMakul;
  Time time = Time(hour: 23, minute: 59);
  TextEditingController jamCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController judulCtrl = TextEditingController();
  TextEditingController deskripsiCtrl = TextEditingController();

  @override
  void initState() {
    final edit = widget.edit ?? false;

    if (edit) {
      DateTime d = DateFormat("dd MMMM yyyy, HH:mm", "ID_id")
          .parse(widget.tugas!.deadline);
      time = Time(hour: d.hour, minute: d.minute);
      judulCtrl.text = widget.tugas!.judul;
      jamCtrl.text =
          "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
      Future.delayed(Duration.zero, () {
        dateCtrl.text = DateFormat("dd MMMM yyyy", "ID_id").format(d);
      });
      deskripsiCtrl.text = widget.tugas!.deskripsi;
      selectedMakul = widget.tugas!.makul;
    } else {
      jamCtrl.text =
          "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
      Future.delayed(Duration.zero, () {
        dateCtrl.text = DateFormat("dd MMMM yyyy", "ID_id")
            .format(widget.date ?? ref.watch(todayDateProvider));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final makul = ref.watch(daftarMakulProvider);
    final isDark = ref.watch(themeChoosenProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "${widget.edit == null ? "Tambah" : "Edit"} Tugas",
        ),
        titleTextStyle: kTextSemiBold18.copyWith(
          color: isDark ? kColorDarkForeground : Colors.black,
          fontFamily: "KumbhSans",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? kColorDark : Colors.white,
          border: const Border(
            bottom: BorderSide(
              width: 0.0,
              color: kColorSecondary,
            ),
            left: BorderSide(color: kColorSecondary, width: 0.0),
            right: BorderSide(color: kColorSecondary, width: 0.0),
            top: BorderSide(color: kColorSecondary, width: 1.0),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    DropdownButton2(
                      isExpanded: true,
                      underline: Container(),
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  isDark ? kColorDarkForeground : Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      hint: const Text("Pilih Matakuliah"),
                      value: selectedMakul,
                      items: switch (makul) {
                        AsyncData(:final value) => value
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(e.nama),
                              ),
                            )
                            .toList(),
                        AsyncError() => [],
                        _ => []
                      },
                      onChanged: (value) {
                        setState(
                          () {
                            selectedMakul = value as int;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RoundedTextField(
                      hintText: 'Judul',
                      controller: judulCtrl,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RoundedTextField(
                      controller: deskripsiCtrl,
                      hintText: "Deskripsi",
                      maxLines: null,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Deadline",
                      style: kTextMedium18,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    RoundedTextField(
                      hintText: '',
                      controller: dateCtrl,
                      readOnly: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            DateTime selectedDate = DateFormat(
                              "dd MMMM yyyy",
                              "ID_id",
                            ).parse(dateCtrl.text);
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              // backgroundColor: Colors.white,
                              surfaceTintColor: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StatefulBuilder(
                                        builder: (context, stateSet) {
                                      return TableCalendar(
                                        currentDay: selectedDate,
                                        availableCalendarFormats: const {
                                          CalendarFormat.month: "month"
                                        },
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          stateSet(() {
                                            selectedDate = selectedDay;
                                          });
                                        },
                                        startingDayOfWeek:
                                            StartingDayOfWeek.monday,
                                        locale: "id_ID",
                                        calendarStyle: const CalendarStyle(
                                          todayDecoration: BoxDecoration(
                                            color: kColorSecondary,
                                            shape: BoxShape.circle,
                                          ),
                                          defaultTextStyle: TextStyle(
                                              fontWeight: FontWeight.w600),
                                          weekendTextStyle: TextStyle(
                                              fontWeight: FontWeight.w600),
                                          todayTextStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        headerStyle: const HeaderStyle(
                                          headerPadding:
                                              EdgeInsets.only(bottom: 8.0),
                                          titleCentered: true,
                                          titleTextStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        calendarBuilders: CalendarBuilders(
                                            dowBuilder: (context, day) {
                                          return Center(
                                            child: Text(
                                              DateFormat("EEE", "id_ID")
                                                  .format(day)
                                                  .toUpperCase(),
                                              style: kTextSemiBold24.copyWith(
                                                  fontSize: 14),
                                            ),
                                          );
                                        }),
                                        focusedDay: selectedDate,
                                        firstDay: ref
                                            .watch(todayDateProvider)
                                            .subtract(
                                              const Duration(
                                                days: 365 * 5,
                                              ),
                                            ),
                                        lastDay:
                                            ref.watch(todayDateProvider).add(
                                                  const Duration(
                                                    days: 365 * 10,
                                                  ),
                                                ),
                                      );
                                    }),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          style: TextButton.styleFrom(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                            foregroundColor: kColorSecondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                4.0,
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            "Batal",
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            dateCtrl.text = DateFormat(
                                                    "dd MMMM yyyy", "ID_id")
                                                .format(selectedDate);
                                            context.pop();
                                          },
                                          style: TextButton.styleFrom(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                            foregroundColor: kColorSecondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                4.0,
                                              ),
                                            ),
                                          ),
                                          child: const Text("Simpan"),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RoundedTextField(
                      hintText: 'Jam',
                      controller: jamCtrl,
                      readOnly: true,
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            height: 350,
                            cancelText: "Batal",
                            okText: "Simpan",
                            accentColor: kColorSecondary,
                            buttonStyle: TextButton.styleFrom(
                                foregroundColor: kColorSecondary),
                            value: time,
                            is24HrFormat: true,
                            onChange: (t) {
                              setState(() {
                                time = t;
                              });
                              jamCtrl.text =
                                  "${t.hour.toString().padLeft(2, "0")}:${t.minute.toString().padLeft(2, "0")}";
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          if (selectedMakul == null ||
                              judulCtrl.text.trim().isEmpty ||
                              deskripsiCtrl.text.trim().isEmpty ||
                              dateCtrl.text.trim().isEmpty ||
                              jamCtrl.text.trim().isEmpty) {
                            const snackbar = SnackBar(
                              content: Text("Isi semua data"),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            final repository =
                                ref.watch(tugasRepositoryProvider);
                            final companion = TugasKuliahCompanion.insert(
                              makul: selectedMakul!,
                              judul: judulCtrl.text.trim(),
                              deskripsi: deskripsiCtrl.text.trim(),
                              deadline: "${dateCtrl.text}, ${jamCtrl.text}",
                            );
                            if (widget.edit == null) {
                              await repository.insertTugas(companion);
                            } else {
                              await repository.updateTugas(
                                  widget.tugas!.id, companion);
                            }
                            if (context.mounted) context.pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: kColorSecondary,
                          foregroundColor: kColorSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        child: widget.edit == true
                            ? const Text("Edit")
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Tambah"),
                                  Hero(tag: "tugas-btn", child: Icon(Icons.add))
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
