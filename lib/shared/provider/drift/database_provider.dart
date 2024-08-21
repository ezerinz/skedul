import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/drift/database.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase database(DatabaseRef ref) {
  return AppDatabase();
}
