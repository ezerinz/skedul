import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/tugas/data/tugas_repository.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/features/tugas/presentation/controller/daftar_makul_provider.dart';
import 'package:skedul/shared/provider/date/datenow.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/extensions.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';

class EditTugasScreen extends ConsumerStatefulWidget {
  const EditTugasScreen({super.key, this.date, this.edit, this.tugas});
  final DateTime? date;
  final bool? edit;
  final TugasModel? tugas;

  @override
  ConsumerState<EditTugasScreen> createState() => _EditTugasScreenState();
}

class _EditTugasScreenState extends ConsumerState<EditTugasScreen> {
  String? selectedMakul;
  Time time = Time(hour: 23, minute: 59);
  TextEditingController jamCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController judulCtrl = TextEditingController();
  TextEditingController deskripsiCtrl = TextEditingController();
  ObjectId? oldMakulId;

  @override
  void initState() {
    final edit = widget.edit ?? false;

    if (edit) {
      DateTime d = widget.tugas!.deadline.toLocal();
      oldMakulId = widget.tugas!.makul.id;
      time = Time(hour: d.hour, minute: d.minute);
      judulCtrl.text = widget.tugas!.judul;
      jamCtrl.text =
          "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
      Future.delayed(Duration.zero, () {
        dateCtrl.text = DateFormat("dd MMMM yyyy", "ID_id").format(d);
      });
      deskripsiCtrl.text = widget.tugas!.deskripsi;
      selectedMakul = widget.tugas!.makul.id.toString();
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
    final isDark = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.edit == null ? "Tambah" : "Edit"} Tugas",
        ),
        titleTextStyle: AppTheme.kTextSemiBold18.copyWith(
          color: isDark ? AppTheme.kColorDarkForeground : Colors.black,
          fontFamily: "KumbhSans",
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  DropdownButton2(
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                          color: isDark ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    underline: Container(),
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isDark
                                ? AppTheme.kColorDarkForeground
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    hint: const Text("Pilih Matakuliah"),
                    value: selectedMakul,
                    items: switch (makul) {
                      AsyncData(:final value) => value
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.id.toString(),
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
                          selectedMakul = value as String;
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
                    style: AppTheme.kTextMedium18,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  RoundedTextField(
                    hintText: '',
                    controller: dateCtrl,
                    readOnly: true,
                    onTap: () {
                      DateTime selectedDate = DateFormat(
                        "dd MMMM yyyy",
                        "ID_id",
                      ).parse(dateCtrl.text);
                      final extra = [
                        selectedDate,
                        (DateTime? value) {
                          dateCtrl.text = DateFormat("dd MMMM yyyy", "ID_id")
                              .format(value!);
                        }
                      ];
                      context.pushNamed("deadline-date", extra: extra);
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
                          height: 200,
                          cancelText: "Batal",
                          okText: "Simpan",
                          barrierDismissible: false,
                          borderRadius: 10.0,
                          blurredBackground: true,
                          dialogInsetPadding: const EdgeInsets.all(15.0),
                          accentColor: AppTheme.kColorSecondary,
                          backgroundColor: isDark
                              ? ThemeData.dark().scaffoldBackgroundColor
                              : ThemeData().dialogTheme.backgroundColor,
                          buttonStyle: ElevatedButton.styleFrom(
                            foregroundColor: AppTheme.kColorSecondary,
                            surfaceTintColor: AppTheme.kColorSecondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarCustom(isDark, "Isi semua data"),
                          );
                        } else {
                          final repository = ref.watch(tugasRepositoryProvider);
                          final format = DateFormat("dd MMMM yyyy", "ID_id");
                          final date = format.parse(dateCtrl.text);
                          if (widget.edit == null) {
                            repository.insertTugas(
                              Tugas(
                                ObjectId(),
                                judulCtrl.text.trim(),
                                deskripsiCtrl.text.trim(),
                                date.withTime(time.hour, time.minute),
                                false,
                              ),
                              ObjectId.fromHexString(selectedMakul!),
                            );
                          } else {
                            repository.updateTugas(
                              Tugas(
                                ObjectId(),
                                judulCtrl.text.trim(),
                                deskripsiCtrl.text.trim(),
                                date.withTime(time.hour, time.minute),
                                false,
                              ),
                              ObjectId.fromHexString(selectedMakul!),
                              oldMakulId!,
                              ObjectId.fromHexString(widget.tugas!.id),
                            );
                          }
                          if (context.mounted) context.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: AppTheme.kColorSecondary,
                        foregroundColor: AppTheme.kColorSecondary,
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
    );
  }
}
