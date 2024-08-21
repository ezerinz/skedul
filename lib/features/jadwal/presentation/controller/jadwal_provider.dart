import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository_provider.dart';
import 'package:skedul/shared/provider/drift/database.dart';

part 'jadwal_provider.g.dart';

@riverpod
Stream<List<MataKuliahData>> jadwal(JadwalRef ref, int day) {
  final repository = ref.watch(jadwalRepositoryProvider);
  final makuls =
      day == 0 ? repository.watchMakuls() : repository.watchMakulsById(day);

  return makuls.map((event) => event);
}
