import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/auth/data/semester_repository.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/settings/user_data.dart';
import 'package:skedul/shared/theme/theme.dart';

class InitialScreen extends ConsumerStatefulWidget {
  const InitialScreen({super.key});

  @override
  ConsumerState<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  String name = "";
  String jurusan = "";
  String semester = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppTheme.kColorSecondary.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppTheme.kColorPrimary.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Halo, ${name.split(' ')[0]}',
                    style: AppTheme.kTextSemiBold24.copyWith(fontSize: 30),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  'Selamat Datang. ${name.isNotEmpty ? "" : "Nama kamu siapa?"}',
                  style: AppTheme.kTextMedium18,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  cursorColor: AppTheme.kColorPrimary,
                  onChanged: (value) {
                    setState(() {
                      name = value.trim();
                    });
                  },
                  style: AppTheme.kTextMedium18,
                  decoration: InputDecoration(
                    hintText: "Nama",
                    hintStyle: AppTheme.kTextMedium18.copyWith(
                      color: Colors.grey,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.kColorPrimary),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  readOnly: name.isEmpty,
                  cursorColor: AppTheme.kColorPrimary,
                  onChanged: (value) {
                    setState(() {
                      jurusan = value.trim();
                    });
                  },
                  style: AppTheme.kTextMedium18,
                  decoration: InputDecoration(
                    hintText: "Jurusan",
                    hintStyle: AppTheme.kTextMedium18.copyWith(
                      color: Colors.grey,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.kColorPrimary),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  readOnly: name.isEmpty || jurusan.isEmpty,
                  cursorColor: AppTheme.kColorPrimary,
                  onChanged: (value) {
                    setState(() {
                      semester = value.trim();
                    });
                  },
                  style: AppTheme.kTextMedium18,
                  decoration: InputDecoration(
                    hintText: "Semester",
                    hintStyle: AppTheme.kTextMedium18.copyWith(
                      color: Colors.grey,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.kColorPrimary),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: name.isEmpty ||
                            jurusan.isEmpty ||
                            semester.isEmpty
                        ? null
                        : () async {
                            await ref.read(nameProvider.notifier).update(name);
                            await ref
                                .read(jurusanProvider.notifier)
                                .update(jurusan);

                            final id = ObjectId();
                            final newSemester = Semester(id, semester);
                            ref
                                .read(semesterRepositoryProvider)
                                .insert(newSemester);
                            ref
                                .read(currentSemesterProvider.notifier)
                                .update(id);

                            if (context.mounted) {
                              context.go('/home');
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: AppTheme.kColorSecondary,
                      foregroundColor: AppTheme.kColorSecondary,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Lanjut'),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppTheme.kColorPrimary.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppTheme.kColorSecondary.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
