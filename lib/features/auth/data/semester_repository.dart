import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/realm/realm.dart';

part 'semester_repository.g.dart';

class SemesterRepository {
  final Realm realm;

  SemesterRepository(this.realm);

  void insert(Semester newSemester) {
    realm.write(() {
      realm.add(newSemester);
    });
  }

  void update(Semester updatedSemester) {
    realm.write(() {
      realm.add(updatedSemester, update: true);
    });
  }

  void delete(Semester semester) {
    realm.write(() {
      realm.delete(semester);
    });
  }

  Stream<List<Semester>> streamSemester() async* {
    await for (var c in realm.all<Semester>().changes) {
      yield c.results.map((e) => e).toList();
    }
  }

  Semester? getSemesterById(ObjectId id) {
    return realm.find<Semester>(id);
  }

  Semester getFirst() {
    return realm.all<Semester>().first;
  }
}

@riverpod
SemesterRepository semesterRepository(SemesterRepositoryRef ref) {
  final realm = ref.watch(realmProvider);

  return SemesterRepository(realm);
}
