import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/data/tugas_repository.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/shared/provider/realm/model.dart';

part 'tugas_by_date_provider.g.dart';

@riverpod
Stream<LinkedHashMap<DateTime, List<TugasModel>>> tugasByDate(
    TugasByDateRef ref, DateTime start, DateTime end) {
  final repository = ref.watch(tugasRepositoryProvider);
  // return LinkedHashMap<DateTime, List<Tugas>>(
  //   equals: isSameDay,
  // hashCode: getHashCode
  // )..addAll(Map.fromIterable(repository.));
  return repository.streamTugasByDate(start, end);
}
