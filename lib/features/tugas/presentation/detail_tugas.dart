import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/shared/theme/theme.dart';

class DetailTugasBottomSheet extends ConsumerWidget {
  const DetailTugasBottomSheet({super.key, required this.tugas});

  final TugasModel tugas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.40,
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    tugas.judul,
                    style: AppTheme.kTextSemiBold18,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black12,
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              "Matakuliah: ${tugas.makul.nama}",
              style: AppTheme.kTextMedium16.copyWith(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            Text(
              "Deadline: ${DateFormat("dd MMMM yyyy, HH:mm", "ID_id").format(tugas.deadline)}",
              style: AppTheme.kTextMedium16.copyWith(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              tugas.deskripsi,
              style: AppTheme.kTextMedium16.copyWith(fontSize: 12),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
