import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository.dart';
import 'package:skedul/shared/provider/realm/model.dart';

part 'jadwal_provider.g.dart';

@riverpod
Stream<List<Makul>> jadwal(JadwalRef ref, int day) {
  final repository = ref.watch(jadwalRepositoryProvider);

  return day == 0 ? repository.streamMakul() : repository.streamMakulByDay(day);
}
