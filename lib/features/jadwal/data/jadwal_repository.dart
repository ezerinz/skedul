import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/realm/realm.dart';
import 'package:skedul/shared/provider/settings/user_data.dart';

part 'jadwal_repository.g.dart';

class JadwalRepository {
  final Realm realm;
  final ObjectId semesterId;

  JadwalRepository(this.realm, this.semesterId);

  void insertMakul(Makul newMakul) {
    final semester = realm.find<Semester>(semesterId);
    if (semester != null) {
      realm.write(() {
        semester.makul.add(newMakul);
      });
    }
  }

  void updateMakul(Makul newMakul) {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      Makul makul = semester.makul.firstWhere((t) => t.id == newMakul.id);

      realm.write(() {
        makul.nama = newMakul.nama;
        makul.hari = newMakul.hari;
        makul.jam = newMakul.jam;
        makul.sks = newMakul.sks;
        makul.kelas = newMakul.kelas;
        makul.ruangan = newMakul.ruangan;
      });
    }
  }

  void deleteMakul(ObjectId makulId) {
    final semester = realm.find<Semester>(semesterId);

    if (semester != null) {
      realm.write(() {
        semester.makul.removeWhere((t) => t.id == makulId);
      });
    }
  }

  Stream<List<Makul>> streamMakul() async* {
    final semester = realm.find<Semester>(semesterId);
    if (semester != null) {
      // ignore: unused_local_variable
      await for (var c in semester.makul.changes) {
        final data = List<Makul>.from(semester.makul);
        data.sort(
          (a, b) =>
              DateTime(2024, 1, a.hari, a.jam!.hour, a.jam!.minute).compareTo(
            DateTime(2024, 1, b.hari, b.jam!.hour, b.jam!.minute),
          ),
        );

        yield data;
      }
    } else {
      yield [];
    }
  }

  Stream<List<Makul>> streamMakulByDay(int day) async* {
    final semester = realm.find<Semester>(semesterId);
    if (semester != null) {
      // ignore: unused_local_variable
      await for (var c in semester.makul.changes) {
        final data = List<Makul>.from(semester.makul)
            .where((t) => t.hari == day)
            .toList();
        data.sort(
          (a, b) =>
              DateTime(2024, 1, a.hari, a.jam!.hour, a.jam!.minute).compareTo(
            DateTime(2024, 1, b.hari, b.jam!.hour, b.jam!.minute),
          ),
        );

        yield data;
      }
    } else {
      yield [];
    }
  }
}

@riverpod
JadwalRepository jadwalRepository(JadwalRepositoryRef ref) {
  final realm = ref.watch(realmProvider);
  final semesterId = ref.watch(currentSemesterProvider);

  return JadwalRepository(realm, semesterId);
}
