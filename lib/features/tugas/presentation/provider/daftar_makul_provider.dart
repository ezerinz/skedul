import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository_provider.dart';
import 'package:skedul/shared/provider/drift/database.dart';

part 'daftar_makul_provider.g.dart';

@riverpod
Stream<List<MataKuliahData>> daftarMakul(DaftarMakulRef ref) {
  final repository = ref.watch(jadwalRepositoryProvider);

  final data = repository.watchMakuls();

  return data.map((makul) => makul);
}
