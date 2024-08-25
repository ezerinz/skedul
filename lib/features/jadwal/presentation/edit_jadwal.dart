import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository.dart';
import 'package:skedul/shared/provider/date/weekday.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class EditJadwalScreen extends ConsumerStatefulWidget {
  const EditJadwalScreen({super.key, this.day, this.edit, this.data});

  final String? day;
  final bool? edit;
  final Makul? data;

  @override
  ConsumerState<EditJadwalScreen> createState() => _AddJadwalScreenState();
}

class _AddJadwalScreenState extends ConsumerState<EditJadwalScreen> {
  String? selectedDay;
  Time _time = Time(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  TextEditingController makulCtrl = TextEditingController();
  TextEditingController ruanganCtrl = TextEditingController();
  TextEditingController sksCtrl = TextEditingController();
  TextEditingController jamCtrl = TextEditingController();
  TextEditingController kelasCtrl = TextEditingController();

  @override
  void initState() {
    final edit = widget.edit ?? false;
    if (edit) {
      selectedDay = intToDay(widget.data!.hari);
      makulCtrl.text = widget.data!.nama;
      kelasCtrl.text = widget.data!.kelas;
      ruanganCtrl.text = widget.data!.ruangan;
      sksCtrl.text = widget.data!.sks.toString();
      jamCtrl.text =
          "${widget.data!.jam!.hour.toString().padLeft(2, "0")}:${widget.data!.jam!.minute.toString().padLeft(2, "0")}";
      _time = Time(
        hour: widget.data!.jam!.hour,
        minute: widget.data!.jam!.minute,
      );
    } else {
      selectedDay = widget.day;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(isDarkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.edit != null ? "Edit" : "Tambah"} Jadwal",
        ),
        titleTextStyle: AppTheme.kTextSemiBold18.copyWith(
            color: isDark ? AppTheme.kColorDarkForeground : Colors.black,
            fontFamily: "KumbhSans"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            DropdownButton2(
              isExpanded: true,
              underline: Container(),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    color: isDark ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isDark ? AppTheme.kColorDarkForeground : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              hint: const Text("Pilih Hari"),
              value: selectedDay,
              items: ref
                  .watch(weekdayProvider)
                  .map((e) {
                    if (e != "Semua") {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }
                  })
                  .toList()
                  .whereType<DropdownMenuItem>()
                  .toList(),
              onChanged: (value) {
                setState(
                  () {
                    selectedDay = value;
                  },
                );
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            RoundedTextField(
              hintText: "Mata Kuliah",
              controller: makulCtrl,
            ),
            const SizedBox(
              height: 15.0,
            ),
            RoundedTextField(
              hintText: "Kelas",
              controller: kelasCtrl,
            ),
            const SizedBox(
              height: 15.0,
            ),
            RoundedTextField(
              hintText: "Ruangan",
              controller: ruanganCtrl,
            ),
            const SizedBox(
              height: 15.0,
            ),
            RoundedTextField(
              hintText: "SKS",
              digitOnly: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: sksCtrl,
            ),
            const SizedBox(
              height: 15.0,
            ),
            RoundedTextField(
              hintText: "Jam Mulai",
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
                    value: _time,
                    is24HrFormat: true,
                    onChange: (time) {
                      jamCtrl.text =
                          "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";

                      setState(() {
                        _time = time;
                      });
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
                  if (selectedDay == null ||
                      makulCtrl.text.trim() == "" ||
                      ruanganCtrl.text.trim() == "" ||
                      sksCtrl.text.trim() == "" ||
                      jamCtrl.text.trim() == "" ||
                      kelasCtrl.text.trim() == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarCustom(isDark, "Isi semua data"),
                    );
                  } else {
                    final repository = ref.watch(jadwalRepositoryProvider);
                    if (widget.edit != null && widget.edit == true) {
                      repository.updateMakul(
                        Makul(
                          widget.data!.id,
                          dayToInt(selectedDay!),
                          makulCtrl.text,
                          ruanganCtrl.text,
                          int.parse(sksCtrl.text),
                          kelasCtrl.text,
                          jam: Waktu(_time.hour, _time.minute),
                        ),
                      );
                    } else {
                      repository.insertMakul(
                        Makul(
                          ObjectId(),
                          dayToInt(selectedDay!),
                          makulCtrl.text,
                          ruanganCtrl.text,
                          int.parse(sksCtrl.text),
                          kelasCtrl.text,
                          jam: Waktu(_time.hour, _time.minute),
                        ),
                      );
                    }

                    if (context.mounted) context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: AppTheme.kColorPrimary,
                  foregroundColor: AppTheme.kColorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: widget.edit == true
                    ? const Text("Edit")
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tambah"),
                          Hero(
                            tag: "kuliah-btn",
                            child: Icon(Icons.add),
                          )
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
