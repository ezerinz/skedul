import 'package:realm/realm.dart';

part 'model.realm.dart';

@RealmModel()
class _Tugas {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String judul;
  late String deskripsi;
  late DateTime deadline;
  late bool selesai;
}

@RealmModel()
class _Waktu {
  late int hour;
  late int minute;
}

@RealmModel()
class _Makul {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late int hari;
  late String nama;
  late String ruangan;
  late int sks;
  late String kelas;
  late _Waktu? jam;
  late List<_Tugas> tugas;
}

@RealmModel()
class _Semester {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;
  late List<_Makul> makul;
}
