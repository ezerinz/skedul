import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository_provider.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';

part 'tugas_provider.g.dart';

@riverpod
Stream<List<TugasModel>> tugas(TugasRef ref, DateTime date,
    {bool tugasDekat = false}) {
  final repository = ref.watch(tugasRepositoryProvider);
  final data =
      tugasDekat ? repository.watchTugas() : repository.watchTugasByDate(date);

  return data.map(
    (tugas) {
      if (tugasDekat) {
        var data = tugas.map((e) {
          var format = DateFormat("dd MMMM yyyy, HH:mm", "ID_id");

          var deadline = format.parse(e.deadline);
          Duration difference = deadline.difference(date);
          if (difference.inMinutes >= 0 && difference.inDays < 3) {
            return TugasModel(e.id, e.makul, e.judul, e.deskripsi, e.deadline,
                difference.inDays);
          }
        }).toList();
        List<TugasModel> result = data.whereType<TugasModel>().toList();
        result.sort(
          (a, b) =>
              a.deadline.substring(0, 2).compareTo(b.deadline.substring(0, 2)),
        );
        return result;
      } else {
        return tugas.map((e) {
          return TugasModel(
            e.id,
            e.makul,
            e.judul,
            e.deskripsi,
            e.deadline,
            0,
          );
        }).toList();
      }
    },
  );
}
