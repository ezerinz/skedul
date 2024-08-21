import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository_provider.dart';
import 'package:skedul/shared/provider/drift/database.dart';

part 'count_tugas_provider.g.dart';

@riverpod
Stream<List<TugasKuliahData>> countTugas(CountTugasRef ref) {
  final repository = ref.watch(tugasRepositoryProvider);
  final tugas = repository.watchTugas();

  return tugas.map((event) => event);
}
