import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository.dart';
import 'package:skedul/shared/provider/drift/database_provider.dart';

part 'tugas_repository_provider.g.dart';

@riverpod
TugasRepository tugasRepository(TugasRepositoryRef ref) {
  final db = ref.watch(databaseProvider);

  return TugasRepository(db);
}
