import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/auth/data/semester_repository.dart';

part 'daftar_semester_provider.g.dart';

@riverpod
Stream<List> daftarSemester(DaftarSemesterRef ref) {
  final repository = ref.watch(semesterRepositoryProvider);

  return repository.streamSemester();
}
