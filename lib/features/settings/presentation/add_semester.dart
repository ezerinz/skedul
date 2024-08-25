import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/auth/data/semester_repository.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/theme/theme.dart';

class AddSemester extends ConsumerStatefulWidget {
  const AddSemester({super.key});

  @override
  ConsumerState<AddSemester> createState() => _GantiNamaState();
}

class _GantiNamaState extends ConsumerState<AddSemester> {
  TextEditingController semesterCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: semesterCtrl,
            textAlign: TextAlign.center,
            onChanged: (text) {
              setState(() {});
            },
            cursorColor: AppTheme.kColorPrimary,
            style: AppTheme.kTextMedium18,
            decoration: const InputDecoration(
              hintText: "Tambah Semester",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.kColorPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: semesterCtrl.text.isEmpty
                  ? null
                  : () {
                      ref.watch(semesterRepositoryProvider).insert(
                            Semester(
                              ObjectId(),
                              semesterCtrl.text.trim(),
                            ),
                          );
                      context.pop();
                    },
              style: ElevatedButton.styleFrom(
                  surfaceTintColor: AppTheme.kColorSecondary,
                  foregroundColor: AppTheme.kColorSecondary,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  )),
              child: const Text('Tambah'),
            ),
          ),
        ],
      ),
    );
  }
}
