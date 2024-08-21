import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:skedul/features/jadwal/domain/mata_kuliah.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:skedul/features/tugas/domain/tugas_kuliah.dart';

part 'database.g.dart';

@DriftDatabase(tables: [MataKuliah, TugasKuliah])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'skedul.sqlite'));
      return NativeDatabase.createInBackground(file);
    },
  );
}
