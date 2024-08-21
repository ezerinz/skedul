import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository.dart';
import 'package:skedul/shared/provider/drift/database_provider.dart';

part 'jadwal_repository_provider.g.dart';

@riverpod
JadwalRepository jadwalRepository(JadwalRepositoryRef ref) {
  final database = ref.watch(databaseProvider);

  return JadwalRepository(database);
}
