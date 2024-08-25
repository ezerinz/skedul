import 'dart:io';

import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/shared_pref/shared_prefs_helper.dart';

part 'user_data.g.dart';

@riverpod
class CurrentSemester extends _$CurrentSemester {
  @override
  ObjectId build() {
    final stringId = ref.read(sharedPrefsHelperProvider).getSemester();
    return ObjectId.fromHexString(stringId ?? "");
  }

  Future<void> update(ObjectId value) async {
    await ref.read(sharedPrefsHelperProvider).saveSemester(value.toString());
    state = value;
  }
}

@riverpod
class Name extends _$Name {
  @override
  String build() {
    return ref.read(sharedPrefsHelperProvider).getName() ?? "";
  }

  Future<void> update(String value) async {
    await ref.read(sharedPrefsHelperProvider).saveName(value);
    state = value;
  }
}

@riverpod
class Jurusan extends _$Jurusan {
  @override
  String build() {
    return ref.read(sharedPrefsHelperProvider).getJurusan() ?? "";
  }

  Future<void> update(String value) async {
    await ref.read(sharedPrefsHelperProvider).saveJurusan(value);
    state = value;
  }
}

@riverpod
class ProfilePath extends _$ProfilePath {
  @override
  String build() {
    return ref.read(sharedPrefsHelperProvider).getProfilePath() ?? "";
  }

  Future<void> update(String value) async {
    await ref.read(sharedPrefsHelperProvider).saveProfilePath(value);
    state = value;
  }

  Future<void> delete(String path) async {
    await ref.read(sharedPrefsHelperProvider).saveProfilePath("");
    await File(path).delete();
    state = "";
  }
}
