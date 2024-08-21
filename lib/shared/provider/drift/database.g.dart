// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MataKuliahTable extends MataKuliah
    with TableInfo<$MataKuliahTable, MataKuliahData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MataKuliahTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _hariMeta = const VerificationMeta('hari');
  @override
  late final GeneratedColumn<int> hari = GeneratedColumn<int>(
      'hari', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
      'nama', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ruanganMeta =
      const VerificationMeta('ruangan');
  @override
  late final GeneratedColumn<String> ruangan = GeneratedColumn<String>(
      'ruangan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sksMeta = const VerificationMeta('sks');
  @override
  late final GeneratedColumn<int> sks = GeneratedColumn<int>(
      'sks', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _jamMeta = const VerificationMeta('jam');
  @override
  late final GeneratedColumn<String> jam = GeneratedColumn<String>(
      'jam', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kelasMeta = const VerificationMeta('kelas');
  @override
  late final GeneratedColumn<String> kelas = GeneratedColumn<String>(
      'kelas', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, hari, nama, ruangan, sks, jam, kelas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mata_kuliah';
  @override
  VerificationContext validateIntegrity(Insertable<MataKuliahData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hari')) {
      context.handle(
          _hariMeta, hari.isAcceptableOrUnknown(data['hari']!, _hariMeta));
    } else if (isInserting) {
      context.missing(_hariMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
          _namaMeta, nama.isAcceptableOrUnknown(data['nama']!, _namaMeta));
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('ruangan')) {
      context.handle(_ruanganMeta,
          ruangan.isAcceptableOrUnknown(data['ruangan']!, _ruanganMeta));
    } else if (isInserting) {
      context.missing(_ruanganMeta);
    }
    if (data.containsKey('sks')) {
      context.handle(
          _sksMeta, sks.isAcceptableOrUnknown(data['sks']!, _sksMeta));
    } else if (isInserting) {
      context.missing(_sksMeta);
    }
    if (data.containsKey('jam')) {
      context.handle(
          _jamMeta, jam.isAcceptableOrUnknown(data['jam']!, _jamMeta));
    } else if (isInserting) {
      context.missing(_jamMeta);
    }
    if (data.containsKey('kelas')) {
      context.handle(
          _kelasMeta, kelas.isAcceptableOrUnknown(data['kelas']!, _kelasMeta));
    } else if (isInserting) {
      context.missing(_kelasMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MataKuliahData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MataKuliahData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hari: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hari'])!,
      nama: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama'])!,
      ruangan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ruangan'])!,
      sks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sks'])!,
      jam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}jam'])!,
      kelas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kelas'])!,
    );
  }

  @override
  $MataKuliahTable createAlias(String alias) {
    return $MataKuliahTable(attachedDatabase, alias);
  }
}

class MataKuliahData extends DataClass implements Insertable<MataKuliahData> {
  final int id;
  final int hari;
  final String nama;
  final String ruangan;
  final int sks;
  final String jam;
  final String kelas;
  const MataKuliahData(
      {required this.id,
      required this.hari,
      required this.nama,
      required this.ruangan,
      required this.sks,
      required this.jam,
      required this.kelas});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hari'] = Variable<int>(hari);
    map['nama'] = Variable<String>(nama);
    map['ruangan'] = Variable<String>(ruangan);
    map['sks'] = Variable<int>(sks);
    map['jam'] = Variable<String>(jam);
    map['kelas'] = Variable<String>(kelas);
    return map;
  }

  MataKuliahCompanion toCompanion(bool nullToAbsent) {
    return MataKuliahCompanion(
      id: Value(id),
      hari: Value(hari),
      nama: Value(nama),
      ruangan: Value(ruangan),
      sks: Value(sks),
      jam: Value(jam),
      kelas: Value(kelas),
    );
  }

  factory MataKuliahData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MataKuliahData(
      id: serializer.fromJson<int>(json['id']),
      hari: serializer.fromJson<int>(json['hari']),
      nama: serializer.fromJson<String>(json['nama']),
      ruangan: serializer.fromJson<String>(json['ruangan']),
      sks: serializer.fromJson<int>(json['sks']),
      jam: serializer.fromJson<String>(json['jam']),
      kelas: serializer.fromJson<String>(json['kelas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hari': serializer.toJson<int>(hari),
      'nama': serializer.toJson<String>(nama),
      'ruangan': serializer.toJson<String>(ruangan),
      'sks': serializer.toJson<int>(sks),
      'jam': serializer.toJson<String>(jam),
      'kelas': serializer.toJson<String>(kelas),
    };
  }

  MataKuliahData copyWith(
          {int? id,
          int? hari,
          String? nama,
          String? ruangan,
          int? sks,
          String? jam,
          String? kelas}) =>
      MataKuliahData(
        id: id ?? this.id,
        hari: hari ?? this.hari,
        nama: nama ?? this.nama,
        ruangan: ruangan ?? this.ruangan,
        sks: sks ?? this.sks,
        jam: jam ?? this.jam,
        kelas: kelas ?? this.kelas,
      );
  @override
  String toString() {
    return (StringBuffer('MataKuliahData(')
          ..write('id: $id, ')
          ..write('hari: $hari, ')
          ..write('nama: $nama, ')
          ..write('ruangan: $ruangan, ')
          ..write('sks: $sks, ')
          ..write('jam: $jam, ')
          ..write('kelas: $kelas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hari, nama, ruangan, sks, jam, kelas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MataKuliahData &&
          other.id == this.id &&
          other.hari == this.hari &&
          other.nama == this.nama &&
          other.ruangan == this.ruangan &&
          other.sks == this.sks &&
          other.jam == this.jam &&
          other.kelas == this.kelas);
}

class MataKuliahCompanion extends UpdateCompanion<MataKuliahData> {
  final Value<int> id;
  final Value<int> hari;
  final Value<String> nama;
  final Value<String> ruangan;
  final Value<int> sks;
  final Value<String> jam;
  final Value<String> kelas;
  const MataKuliahCompanion({
    this.id = const Value.absent(),
    this.hari = const Value.absent(),
    this.nama = const Value.absent(),
    this.ruangan = const Value.absent(),
    this.sks = const Value.absent(),
    this.jam = const Value.absent(),
    this.kelas = const Value.absent(),
  });
  MataKuliahCompanion.insert({
    this.id = const Value.absent(),
    required int hari,
    required String nama,
    required String ruangan,
    required int sks,
    required String jam,
    required String kelas,
  })  : hari = Value(hari),
        nama = Value(nama),
        ruangan = Value(ruangan),
        sks = Value(sks),
        jam = Value(jam),
        kelas = Value(kelas);
  static Insertable<MataKuliahData> custom({
    Expression<int>? id,
    Expression<int>? hari,
    Expression<String>? nama,
    Expression<String>? ruangan,
    Expression<int>? sks,
    Expression<String>? jam,
    Expression<String>? kelas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hari != null) 'hari': hari,
      if (nama != null) 'nama': nama,
      if (ruangan != null) 'ruangan': ruangan,
      if (sks != null) 'sks': sks,
      if (jam != null) 'jam': jam,
      if (kelas != null) 'kelas': kelas,
    });
  }

  MataKuliahCompanion copyWith(
      {Value<int>? id,
      Value<int>? hari,
      Value<String>? nama,
      Value<String>? ruangan,
      Value<int>? sks,
      Value<String>? jam,
      Value<String>? kelas}) {
    return MataKuliahCompanion(
      id: id ?? this.id,
      hari: hari ?? this.hari,
      nama: nama ?? this.nama,
      ruangan: ruangan ?? this.ruangan,
      sks: sks ?? this.sks,
      jam: jam ?? this.jam,
      kelas: kelas ?? this.kelas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hari.present) {
      map['hari'] = Variable<int>(hari.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (ruangan.present) {
      map['ruangan'] = Variable<String>(ruangan.value);
    }
    if (sks.present) {
      map['sks'] = Variable<int>(sks.value);
    }
    if (jam.present) {
      map['jam'] = Variable<String>(jam.value);
    }
    if (kelas.present) {
      map['kelas'] = Variable<String>(kelas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MataKuliahCompanion(')
          ..write('id: $id, ')
          ..write('hari: $hari, ')
          ..write('nama: $nama, ')
          ..write('ruangan: $ruangan, ')
          ..write('sks: $sks, ')
          ..write('jam: $jam, ')
          ..write('kelas: $kelas')
          ..write(')'))
        .toString();
  }
}

class $TugasKuliahTable extends TugasKuliah
    with TableInfo<$TugasKuliahTable, TugasKuliahData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TugasKuliahTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _makulMeta = const VerificationMeta('makul');
  @override
  late final GeneratedColumn<int> makul = GeneratedColumn<int>(
      'makul', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
      'judul', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deskripsiMeta =
      const VerificationMeta('deskripsi');
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
      'deskripsi', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<String> deadline = GeneratedColumn<String>(
      'deadline', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, makul, judul, deskripsi, deadline];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tugas_kuliah';
  @override
  VerificationContext validateIntegrity(Insertable<TugasKuliahData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('makul')) {
      context.handle(
          _makulMeta, makul.isAcceptableOrUnknown(data['makul']!, _makulMeta));
    } else if (isInserting) {
      context.missing(_makulMeta);
    }
    if (data.containsKey('judul')) {
      context.handle(
          _judulMeta, judul.isAcceptableOrUnknown(data['judul']!, _judulMeta));
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('deskripsi')) {
      context.handle(_deskripsiMeta,
          deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta));
    } else if (isInserting) {
      context.missing(_deskripsiMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TugasKuliahData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TugasKuliahData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      makul: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}makul'])!,
      judul: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}judul'])!,
      deskripsi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deskripsi'])!,
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deadline'])!,
    );
  }

  @override
  $TugasKuliahTable createAlias(String alias) {
    return $TugasKuliahTable(attachedDatabase, alias);
  }
}

class TugasKuliahData extends DataClass implements Insertable<TugasKuliahData> {
  final int id;
  final int makul;
  final String judul;
  final String deskripsi;
  final String deadline;
  const TugasKuliahData(
      {required this.id,
      required this.makul,
      required this.judul,
      required this.deskripsi,
      required this.deadline});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['makul'] = Variable<int>(makul);
    map['judul'] = Variable<String>(judul);
    map['deskripsi'] = Variable<String>(deskripsi);
    map['deadline'] = Variable<String>(deadline);
    return map;
  }

  TugasKuliahCompanion toCompanion(bool nullToAbsent) {
    return TugasKuliahCompanion(
      id: Value(id),
      makul: Value(makul),
      judul: Value(judul),
      deskripsi: Value(deskripsi),
      deadline: Value(deadline),
    );
  }

  factory TugasKuliahData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TugasKuliahData(
      id: serializer.fromJson<int>(json['id']),
      makul: serializer.fromJson<int>(json['makul']),
      judul: serializer.fromJson<String>(json['judul']),
      deskripsi: serializer.fromJson<String>(json['deskripsi']),
      deadline: serializer.fromJson<String>(json['deadline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'makul': serializer.toJson<int>(makul),
      'judul': serializer.toJson<String>(judul),
      'deskripsi': serializer.toJson<String>(deskripsi),
      'deadline': serializer.toJson<String>(deadline),
    };
  }

  TugasKuliahData copyWith(
          {int? id,
          int? makul,
          String? judul,
          String? deskripsi,
          String? deadline}) =>
      TugasKuliahData(
        id: id ?? this.id,
        makul: makul ?? this.makul,
        judul: judul ?? this.judul,
        deskripsi: deskripsi ?? this.deskripsi,
        deadline: deadline ?? this.deadline,
      );
  @override
  String toString() {
    return (StringBuffer('TugasKuliahData(')
          ..write('id: $id, ')
          ..write('makul: $makul, ')
          ..write('judul: $judul, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('deadline: $deadline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, makul, judul, deskripsi, deadline);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TugasKuliahData &&
          other.id == this.id &&
          other.makul == this.makul &&
          other.judul == this.judul &&
          other.deskripsi == this.deskripsi &&
          other.deadline == this.deadline);
}

class TugasKuliahCompanion extends UpdateCompanion<TugasKuliahData> {
  final Value<int> id;
  final Value<int> makul;
  final Value<String> judul;
  final Value<String> deskripsi;
  final Value<String> deadline;
  const TugasKuliahCompanion({
    this.id = const Value.absent(),
    this.makul = const Value.absent(),
    this.judul = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.deadline = const Value.absent(),
  });
  TugasKuliahCompanion.insert({
    this.id = const Value.absent(),
    required int makul,
    required String judul,
    required String deskripsi,
    required String deadline,
  })  : makul = Value(makul),
        judul = Value(judul),
        deskripsi = Value(deskripsi),
        deadline = Value(deadline);
  static Insertable<TugasKuliahData> custom({
    Expression<int>? id,
    Expression<int>? makul,
    Expression<String>? judul,
    Expression<String>? deskripsi,
    Expression<String>? deadline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (makul != null) 'makul': makul,
      if (judul != null) 'judul': judul,
      if (deskripsi != null) 'deskripsi': deskripsi,
      if (deadline != null) 'deadline': deadline,
    });
  }

  TugasKuliahCompanion copyWith(
      {Value<int>? id,
      Value<int>? makul,
      Value<String>? judul,
      Value<String>? deskripsi,
      Value<String>? deadline}) {
    return TugasKuliahCompanion(
      id: id ?? this.id,
      makul: makul ?? this.makul,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
      deadline: deadline ?? this.deadline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (makul.present) {
      map['makul'] = Variable<int>(makul.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<String>(deadline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TugasKuliahCompanion(')
          ..write('id: $id, ')
          ..write('makul: $makul, ')
          ..write('judul: $judul, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('deadline: $deadline')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $MataKuliahTable mataKuliah = $MataKuliahTable(this);
  late final $TugasKuliahTable tugasKuliah = $TugasKuliahTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mataKuliah, tugasKuliah];
}
