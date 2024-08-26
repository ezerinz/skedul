import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';

part 'tugas_by_date_provider.g.dart';

@riverpod
Stream<LinkedHashMap<DateTime, List<TugasModel>>> tugasByDate(
    TugasByDateRef ref, DateTime start, DateTime end) {
  final repository = ref.watch(tugasRepositoryProvider);
  return repository.streamTugasByDate(start, end);
}
