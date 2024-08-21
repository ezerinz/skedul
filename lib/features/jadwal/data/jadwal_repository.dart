import 'package:drift/drift.dart';
import 'package:skedul/shared/provider/drift/database.dart';

class JadwalRepository {
  final AppDatabase database;

  JadwalRepository(this.database);

  Future<int> insertMakul(MataKuliahCompanion makul) {
    return database.into(database.mataKuliah).insert(makul);
  }

  Stream<List<MataKuliahData>> watchMakuls() {
    return (database.select(database.mataKuliah)
          ..orderBy(
            [
              (t) => OrderingTerm(expression: t.hari),
              (t) => OrderingTerm(expression: t.jam),
            ],
          ))
        .watch();
  }

  Stream<List<MataKuliahData>> watchMakulsById(int day) {
    return (database.select(database.mataKuliah)
          ..where((tbl) => tbl.hari.equals(day))
          ..orderBy([(t) => OrderingTerm(expression: t.jam)]))
        .watch();
  }

  Future<int> updateMakul(int id, MataKuliahCompanion makul) {
    return (database.update(database.mataKuliah)
          ..where((tbl) => tbl.id.equals(id)))
        .write(makul);
  }

  Future deleteMakul(int id) {
    return (database.delete(database.mataKuliah)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
