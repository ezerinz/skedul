import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';

part 'tugas_provider.g.dart';

@riverpod
Stream<List<TugasModel>> tugas(TugasRef ref) {
  final repository = ref.watch(tugasRepositoryProvider);

  return repository.streamTugas();
}
