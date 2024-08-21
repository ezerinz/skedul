import 'package:drift/drift.dart';

class MataKuliah extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get hari => integer()();
  TextColumn get nama => text()();
  TextColumn get ruangan => text()();
  IntColumn get sks => integer()();
  TextColumn get jam => text()();
  TextColumn get kelas => text()();
}
