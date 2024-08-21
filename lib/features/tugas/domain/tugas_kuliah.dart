import 'package:drift/drift.dart';

class TugasKuliah extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get makul => integer()();
  TextColumn get judul => text()();
  TextColumn get deskripsi => text()();
  TextColumn get deadline => text()();
}
