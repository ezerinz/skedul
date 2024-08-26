import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/auth/data/semester_repository.dart';
import 'package:skedul/features/settings/presentation/controller/daftar_semester_provider.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/provider/settings/user_data.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/extensions.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late ObjectId selectedSemester;
  bool editingSemester = false;
  TextEditingController namaCtrl = TextEditingController();
  TextEditingController jurusanCtrl = TextEditingController();
  TextEditingController semesterCtrl = TextEditingController();
  FocusNode semesterFocusNode = FocusNode();
  bool blocked = false;

  @override
  void initState() {
    super.initState();
    selectedSemester = ref.read(currentSemesterProvider);
    namaCtrl.text = ref.read(nameProvider);
    jurusanCtrl.text = ref.read(jurusanProvider);
  }

  @override
  Widget build(BuildContext context) {
    final daftarSemester = ref.watch(daftarSemesterProvider);
    final isDark = ref.watch(isDarkModeProvider);
    final currentSemester = ref.watch(currentSemesterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profil",
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
                  RoundedTextField(
                    hintText: 'Nama',
                    controller: namaCtrl,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RoundedTextField(
                    controller: jurusanCtrl,
                    hintText: "Jurusan",
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: editingSemester
                            ? RoundedTextField(
                                hintText: "Semester",
                                controller: semesterCtrl,
                                focusNode: semesterFocusNode,
                              )
                            : DropdownButton2(
                                isExpanded: true,
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                      color:
                                          isDark ? Colors.black : Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
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
                                hint: const Text("Semester"),
                                value: blocked ? null : selectedSemester,
                                items: blocked
                                    ? []
                                    : switch (daftarSemester) {
                                        AsyncData(:final value) => value
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.name),
                                              ),
                                            )
                                            .toList(),
                                        AsyncError() => [],
                                        _ => []
                                      },
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedSemester = ObjectId.fromHexString(
                                          value as String);
                                    },
                                  );
                                },
                              ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (editingSemester) {
                                if (semesterCtrl.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarCustom(
                                        isDark, "Jangan dikosongkan"),
                                  );
                                } else {
                                  ref.read(semesterRepositoryProvider).update(
                                        selectedSemester,
                                        semesterCtrl.text,
                                      );

                                  if (selectedSemester == currentSemester) {
                                    ref.invalidate(currentSemesterProvider);
                                  }
                                  setState(() {
                                    editingSemester = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  editingSemester = true;
                                });
                                semesterCtrl.text = ref
                                    .read(semesterRepositoryProvider)
                                    .getSemesterById(selectedSemester)!
                                    .name;
                                semesterFocusNode.requestFocus();
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: isDark
                                        ? AppTheme.kColorDarkForeground
                                        : Colors.black),
                              ),
                              child: Icon(editingSemester
                                  ? Icons.check_outlined
                                  : Icons.edit_outlined),
                            ),
                          ),
                        ),
                      ),
                      switch (daftarSemester) {
                        AsyncData(:final value) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: value.length <= 1 || editingSemester
                                    ? null
                                    : () {
                                        context.pushNamed("confirm-dialog",
                                            extra: [
                                              const Text(
                                                "Hapus",
                                                style: AppTheme.kTextSemiBold24,
                                              ),
                                              Text(
                                                "Apakah kamu yakin untuk menghapus? Semua tugas dan mata kuliah di semester ini akan ikut terhapus",
                                                textAlign: TextAlign.center,
                                                style: AppTheme.kTextMedium16
                                                    .copyWith(fontSize: 14),
                                              ),
                                              [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    foregroundColor:
                                                        AppTheme.kColorPrimary,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  child: const Text("Batal"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      blocked = true;
                                                    });
                                                    final repository = ref.read(
                                                        semesterRepositoryProvider);

                                                    repository.delete(
                                                      repository
                                                          .getSemesterById(
                                                        selectedSemester,
                                                      )!,
                                                    );

                                                    if (currentSemester ==
                                                        selectedSemester) {
                                                      ref
                                                          .read(
                                                              currentSemesterProvider
                                                                  .notifier)
                                                          .update(repository
                                                              .getFirst()
                                                              .id);
                                                    }
                                                    setState(() {
                                                      selectedSemester =
                                                          repository
                                                              .getFirst()
                                                              .id;
                                                    });
                                                    setState(() {
                                                      blocked = false;
                                                    });
                                                    if (context.mounted) {
                                                      context.pop();
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    foregroundColor: AppTheme
                                                        .kColorSecondary,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  child: const Text("Hapus"),
                                                ),
                                              ]
                                            ]);
                                      },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: isDark
                                            ? AppTheme.kColorDarkForeground
                                            : Colors.black),
                                  ),
                                  child: Icon(
                                    Icons.delete_outlined,
                                    color: value.length <= 1 || editingSemester
                                        ? isDark
                                            ? Colors.grey.shade100
                                                .withOpacity(0.3)
                                            : Colors.grey.shade400
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        AsyncError() => Container(),
                        _ => Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(),
                            ),
                            child: const Icon(Icons.delete),
                          ),
                      },
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              context.pushNamed("add-semester");
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: isDark
                                        ? AppTheme.kColorDarkForeground
                                        : Colors.black),
                              ),
                              child: const Icon(
                                Icons.add_outlined,
                              ),
                            ),
                          ),
                        ),
                      )
                    ].withSpaceBetween(width: 6.0),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (namaCtrl.text.trim().isEmpty ||
                            jurusanCtrl.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBarCustom(isDark, "Isi semua data"));
                        } else {
                          await ref
                              .read(nameProvider.notifier)
                              .update(namaCtrl.text.trim());
                          await ref.read(jurusanProvider.notifier).update(
                                jurusanCtrl.text.trim(),
                              );
                          await ref
                              .read(currentSemesterProvider.notifier)
                              .update(selectedSemester);

                          if (context.mounted) {
                            context.pop();
                          }
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
                      child: const Text("Edit"),
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
