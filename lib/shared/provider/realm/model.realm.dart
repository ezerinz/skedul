// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Tugas extends _Tugas with RealmEntity, RealmObjectBase, RealmObject {
  Tugas(
    ObjectId id,
    String judul,
    String deskripsi,
    DateTime deadline,
    bool selesai,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'judul', judul);
    RealmObjectBase.set(this, 'deskripsi', deskripsi);
    RealmObjectBase.set(this, 'deadline', deadline);
    RealmObjectBase.set(this, 'selesai', selesai);
  }

  Tugas._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get judul => RealmObjectBase.get<String>(this, 'judul') as String;
  @override
  set judul(String value) => RealmObjectBase.set(this, 'judul', value);

  @override
  String get deskripsi =>
      RealmObjectBase.get<String>(this, 'deskripsi') as String;
  @override
  set deskripsi(String value) => RealmObjectBase.set(this, 'deskripsi', value);

  @override
  DateTime get deadline =>
      RealmObjectBase.get<DateTime>(this, 'deadline') as DateTime;
  @override
  set deadline(DateTime value) => RealmObjectBase.set(this, 'deadline', value);

  @override
  bool get selesai => RealmObjectBase.get<bool>(this, 'selesai') as bool;
  @override
  set selesai(bool value) => RealmObjectBase.set(this, 'selesai', value);

  @override
  Stream<RealmObjectChanges<Tugas>> get changes =>
      RealmObjectBase.getChanges<Tugas>(this);

  @override
  Stream<RealmObjectChanges<Tugas>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Tugas>(this, keyPaths);

  @override
  Tugas freeze() => RealmObjectBase.freezeObject<Tugas>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'judul': judul.toEJson(),
      'deskripsi': deskripsi.toEJson(),
      'deadline': deadline.toEJson(),
      'selesai': selesai.toEJson(),
    };
  }

  static EJsonValue _toEJson(Tugas value) => value.toEJson();
  static Tugas _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'judul': EJsonValue judul,
        'deskripsi': EJsonValue deskripsi,
        'deadline': EJsonValue deadline,
        'selesai': EJsonValue selesai,
      } =>
        Tugas(
          fromEJson(id),
          fromEJson(judul),
          fromEJson(deskripsi),
          fromEJson(deadline),
          fromEJson(selesai),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Tugas._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Tugas, 'Tugas', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('judul', RealmPropertyType.string),
      SchemaProperty('deskripsi', RealmPropertyType.string),
      SchemaProperty('deadline', RealmPropertyType.timestamp),
      SchemaProperty('selesai', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Waktu extends _Waktu with RealmEntity, RealmObjectBase, RealmObject {
  Waktu(
    int hour,
    int minute,
  ) {
    RealmObjectBase.set(this, 'hour', hour);
    RealmObjectBase.set(this, 'minute', minute);
  }

  Waktu._();

  @override
  int get hour => RealmObjectBase.get<int>(this, 'hour') as int;
  @override
  set hour(int value) => RealmObjectBase.set(this, 'hour', value);

  @override
  int get minute => RealmObjectBase.get<int>(this, 'minute') as int;
  @override
  set minute(int value) => RealmObjectBase.set(this, 'minute', value);

  @override
  Stream<RealmObjectChanges<Waktu>> get changes =>
      RealmObjectBase.getChanges<Waktu>(this);

  @override
  Stream<RealmObjectChanges<Waktu>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Waktu>(this, keyPaths);

  @override
  Waktu freeze() => RealmObjectBase.freezeObject<Waktu>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'hour': hour.toEJson(),
      'minute': minute.toEJson(),
    };
  }

  static EJsonValue _toEJson(Waktu value) => value.toEJson();
  static Waktu _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'hour': EJsonValue hour,
        'minute': EJsonValue minute,
      } =>
        Waktu(
          fromEJson(hour),
          fromEJson(minute),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Waktu._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Waktu, 'Waktu', [
      SchemaProperty('hour', RealmPropertyType.int),
      SchemaProperty('minute', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Makul extends _Makul with RealmEntity, RealmObjectBase, RealmObject {
  Makul(
    ObjectId id,
    int hari,
    String nama,
    String ruangan,
    int sks,
    String kelas, {
    Waktu? jam,
    Iterable<Tugas> tugas = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'hari', hari);
    RealmObjectBase.set(this, 'nama', nama);
    RealmObjectBase.set(this, 'ruangan', ruangan);
    RealmObjectBase.set(this, 'sks', sks);
    RealmObjectBase.set(this, 'kelas', kelas);
    RealmObjectBase.set(this, 'jam', jam);
    RealmObjectBase.set<RealmList<Tugas>>(
        this, 'tugas', RealmList<Tugas>(tugas));
  }

  Makul._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int get hari => RealmObjectBase.get<int>(this, 'hari') as int;
  @override
  set hari(int value) => RealmObjectBase.set(this, 'hari', value);

  @override
  String get nama => RealmObjectBase.get<String>(this, 'nama') as String;
  @override
  set nama(String value) => RealmObjectBase.set(this, 'nama', value);

  @override
  String get ruangan => RealmObjectBase.get<String>(this, 'ruangan') as String;
  @override
  set ruangan(String value) => RealmObjectBase.set(this, 'ruangan', value);

  @override
  int get sks => RealmObjectBase.get<int>(this, 'sks') as int;
  @override
  set sks(int value) => RealmObjectBase.set(this, 'sks', value);

  @override
  String get kelas => RealmObjectBase.get<String>(this, 'kelas') as String;
  @override
  set kelas(String value) => RealmObjectBase.set(this, 'kelas', value);

  @override
  Waktu? get jam => RealmObjectBase.get<Waktu>(this, 'jam') as Waktu?;
  @override
  set jam(covariant Waktu? value) => RealmObjectBase.set(this, 'jam', value);

  @override
  RealmList<Tugas> get tugas =>
      RealmObjectBase.get<Tugas>(this, 'tugas') as RealmList<Tugas>;
  @override
  set tugas(covariant RealmList<Tugas> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Makul>> get changes =>
      RealmObjectBase.getChanges<Makul>(this);

  @override
  Stream<RealmObjectChanges<Makul>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Makul>(this, keyPaths);

  @override
  Makul freeze() => RealmObjectBase.freezeObject<Makul>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'hari': hari.toEJson(),
      'nama': nama.toEJson(),
      'ruangan': ruangan.toEJson(),
      'sks': sks.toEJson(),
      'kelas': kelas.toEJson(),
      'jam': jam.toEJson(),
      'tugas': tugas.toEJson(),
    };
  }

  static EJsonValue _toEJson(Makul value) => value.toEJson();
  static Makul _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'hari': EJsonValue hari,
        'nama': EJsonValue nama,
        'ruangan': EJsonValue ruangan,
        'sks': EJsonValue sks,
        'kelas': EJsonValue kelas,
      } =>
        Makul(
          fromEJson(id),
          fromEJson(hari),
          fromEJson(nama),
          fromEJson(ruangan),
          fromEJson(sks),
          fromEJson(kelas),
          jam: fromEJson(ejson['jam']),
          tugas: fromEJson(ejson['tugas']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Makul._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Makul, 'Makul', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('hari', RealmPropertyType.int),
      SchemaProperty('nama', RealmPropertyType.string),
      SchemaProperty('ruangan', RealmPropertyType.string),
      SchemaProperty('sks', RealmPropertyType.int),
      SchemaProperty('kelas', RealmPropertyType.string),
      SchemaProperty('jam', RealmPropertyType.object,
          optional: true, linkTarget: 'Waktu'),
      SchemaProperty('tugas', RealmPropertyType.object,
          linkTarget: 'Tugas', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Semester extends _Semester
    with RealmEntity, RealmObjectBase, RealmObject {
  Semester(
    ObjectId id,
    String name, {
    Iterable<Makul> makul = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<Makul>>(
        this, 'makul', RealmList<Makul>(makul));
  }

  Semester._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<Makul> get makul =>
      RealmObjectBase.get<Makul>(this, 'makul') as RealmList<Makul>;
  @override
  set makul(covariant RealmList<Makul> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Semester>> get changes =>
      RealmObjectBase.getChanges<Semester>(this);

  @override
  Stream<RealmObjectChanges<Semester>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Semester>(this, keyPaths);

  @override
  Semester freeze() => RealmObjectBase.freezeObject<Semester>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'makul': makul.toEJson(),
    };
  }

  static EJsonValue _toEJson(Semester value) => value.toEJson();
  static Semester _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        Semester(
          fromEJson(id),
          fromEJson(name),
          makul: fromEJson(ejson['makul']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Semester._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Semester, 'Semester', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('makul', RealmPropertyType.object,
          linkTarget: 'Makul', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
