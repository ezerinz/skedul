import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository_provider.dart';
import 'package:skedul/shared/provider/drift/database.dart';

part 'tugas_all_provider.g.dart';

@riverpod
Stream<Map<String, List<dynamic>>> tugasAll(TugasAllRef ref) {
  final repository = ref.watch(tugasRepositoryProvider);
  final data = repository.watchTugas();

  return data.map((data) {
    List<TugasKuliahData> tugas = data;
    Map<String, List<String>> result = {};
    for (var element in tugas) {
      var format = DateFormat("dd MMMM yyyy", "ID_id");
      var key = format.parse(element.deadline).toString();

      result[key] = [""];
    }
    return result;
  });
}
