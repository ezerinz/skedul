import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository.dart';
import 'package:skedul/shared/provider/realm/model.dart';

part 'daftar_makul_provider.g.dart';

@riverpod
Stream<List<Makul>> daftarMakul(DaftarMakulRef ref) {
  final repository = ref.watch(jadwalRepositoryProvider);

  return repository.streamMakul();
}
