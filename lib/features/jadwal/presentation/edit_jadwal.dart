import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository_provider.dart';
import 'package:skedul/shared/provider/date/weekday.dart';
import 'package:skedul/shared/provider/drift/database.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class EditJadwalScreen extends ConsumerStatefulWidget {
  const EditJadwalScreen({super.key, this.day, this.edit, this.data});

  final String? day;
  final bool? edit;
  final MataKuliahData? data;

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
      jamCtrl.text = widget.data!.jam;
      var splitJam = widget.data!.jam.split(":");
      _time = Time(
        hour: int.parse(splitJam[0]),
        minute: int.parse(splitJam[1]),
      );
    } else {
      selectedDay = widget.day;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(themeChoosenProvider);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "${widget.edit != null ? "Edit" : "Tambah"} Jadwal",
        ),
        titleTextStyle: kTextSemiBold18.copyWith(
            color: isDark ? kColorDarkForeground : Colors.black,
            fontFamily: "KumbhSans"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ref.watch(themeChoosenProvider) ? kColorDark : Colors.white,
          border: const Border(
            bottom: BorderSide(
              width: 0.0,
              color: kColorPrimary,
            ),
            left: BorderSide(color: kColorPrimary, width: 0.0),
            right: BorderSide(color: kColorPrimary, width: 0.0),
            top: BorderSide(color: kColorPrimary, width: 1.0),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              DropdownButton2(
                isExpanded: true,
                underline: Container(),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? kColorDarkForeground : Colors.black,
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
                      // themeData: ThemeData(),
                      height: 350,
                      cancelText: "Batal",
                      okText: "Simpan",
                      accentColor: kColorPrimary,
                      buttonStyle:
                          TextButton.styleFrom(foregroundColor: kColorPrimary),
                      value: _time,
                      is24HrFormat: true,
                      onChange: (time) {
                        jamCtrl.text =
                            "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
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
                      final snackbar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: isDark ? kColorDark : Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        content: Text(
                          "Isi semua data",
                          style: TextStyle(
                              color:
                                  isDark ? kColorDarkForeground : kColorDark),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } else {
                      final repository = ref.watch(jadwalRepositoryProvider);
                      final data = MataKuliahCompanion.insert(
                          hari: dayToInt(selectedDay!),
                          nama: makulCtrl.text,
                          ruangan: ruanganCtrl.text,
                          kelas: kelasCtrl.text,
                          sks: int.parse(sksCtrl.text),
                          jam: jamCtrl.text);
                      if (widget.edit != null && widget.edit == true) {
                        await repository.updateMakul(widget.data!.id, data);
                      } else {
                        await repository.insertMakul(data);
                      }

                      if (context.mounted) context.pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: kColorPrimary,
                    foregroundColor: kColorPrimary,
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
                            Hero(tag: "kuliah-btn", child: Icon(Icons.add))
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
