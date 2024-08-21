import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:skedul/shared/provider/drift/database.dart';

class TugasRepository {
  final AppDatabase database;

  TugasRepository(this.database);

  Future<int> insertTugas(TugasKuliahCompanion tugas) {
    return database.into(database.tugasKuliah).insert(tugas);
  }

  Stream<List<TugasKuliahData>> watchTugas() {
    return (database.select(database.tugasKuliah)).watch();
  }

  Stream<List<TugasKuliahData>> watchTugasByDate(DateTime date) {
    var format = DateFormat("dd MMMM yyyy", "ID_id");
    return (database.select(database.tugasKuliah)
          ..where((tbl) {
            var filter = format.format(date);
            return tbl.deadline.contains(filter);
          }))
        .watch();
  }

  Future<int> updateTugas(int id, TugasKuliahCompanion tugas) {
    return (database.update(database.tugasKuliah)
          ..where((tbl) => tbl.id.equals(id)))
        .write(tugas);
  }

  Future<int> deleteTugas(int id) {
    return (database.delete(database.tugasKuliah)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
