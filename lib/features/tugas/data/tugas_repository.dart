import 'dart:collection';

import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/tugas/domain/tugas_model.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/realm/realm.dart';
import 'package:skedul/shared/provider/settings/user_data.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

part 'tugas_repository.g.dart';

class TugasRepository {
  final Realm realm;
  final ObjectId semesterId;

  TugasRepository(this.realm, this.semesterId);

  void insertTugas(Tugas newTugas, ObjectId makulId) {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      final makul = semester.makul.firstWhere(
        (m) => m.id == makulId,
      );
      realm.write(
        () {
          makul.tugas.add(newTugas);
        },
      );
    }
  }

  void updateTugas(
    Tugas updatedTugas,
    ObjectId makulId,
    ObjectId oldMakulId,
    ObjectId tugasId,
  ) {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      if (makulId != oldMakulId) {
        deleteTugas(oldMakulId, tugasId);
      }

      Makul makul = semester.makul.firstWhere((m) => m.id == makulId);

      realm.write(
        () {
          if (makulId != oldMakulId) {
            makul.tugas.add(updatedTugas);
          } else {
            final tugas = makul.tugas.firstWhere((t) => t.id == tugasId);
            tugas.judul = updatedTugas.judul;
            tugas.deskripsi = updatedTugas.deskripsi;
            tugas.deadline = updatedTugas.deadline;
          }
        },
      );
    }
  }

  void deleteTugas(
    ObjectId makulId,
    ObjectId tugasId,
  ) {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      Makul makul = semester.makul.firstWhere((m) => m.id == makulId);

      realm.write(
        () {
          makul.tugas.removeWhere((t) => t.id == tugasId);
        },
      );
    }
  }

  Stream<List<TugasModel>> streamTugas() async* {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      await for (var c in semester.makul.changes) {
        final List<TugasModel> tugasList = [];
        for (Makul makul in semester.makul) {
          for (Tugas tugas in makul.tugas) {
            tugasList.add(
              TugasModel(
                tugas.id.toString(),
                makul,
                tugas.judul,
                tugas.deskripsi,
                tugas.deadline.toLocal(),
              ),
            );
          }
        }
        yield tugasList;
      }
    } else {
      yield [];
    }
  }

  Stream<LinkedHashMap<DateTime, List<TugasModel>>> streamTugasByDate(
      DateTime start, DateTime end) async* {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      // ignore: unused_local_variable
      await for (var c in semester.makul.changes) {
        final tugasList = LinkedHashMap<DateTime, List<TugasModel>>(
            equals: isSameDay, hashCode: getHashCode);
        Map<DateTime, List<TugasModel>> tugasByDate = {};
        for (Makul makul in semester.makul) {
          for (Tugas tugas in makul.tugas) {
            final deadlineLocal = tugas.deadline.toLocal();
            if (deadlineLocal.isAfter(start) && deadlineLocal.isBefore(end)) {
              final key = DateTime(deadlineLocal.year, deadlineLocal.month,
                      deadlineLocal.day)
                  .toLocal();
              if (!tugasByDate.containsKey(key)) {
                tugasByDate[key] = [];
              }

              tugasByDate[key]!.add(
                TugasModel(
                  tugas.id.toString(),
                  makul,
                  tugas.judul,
                  tugas.deskripsi,
                  tugas.deadline.toLocal(),
                ),
              );
            }
          }
        }
        tugasList.addAll(tugasByDate);
        yield tugasList;
      }
    } else {
      yield LinkedHashMap<DateTime, List<TugasModel>>();
    }
  }
}

@riverpod
TugasRepository tugasRepository(TugasRepositoryRef ref) {
  final realm = ref.watch(realmProvider);
  final semesterId = ref.watch(currentSemesterProvider);

  return TugasRepository(realm, semesterId);
}
