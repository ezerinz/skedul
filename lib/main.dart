import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/realm/realm.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_instance_provider.dart';
import 'package:skedul/skedul.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  final sharedPreferences = await SharedPreferences.getInstance();
  final config = Configuration.local([
    Semester.schema,
    Makul.schema,
    Waktu.schema,
    Tugas.schema,
  ]);
  final realm = Realm(config);

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsInstanceProvider.overrideWithValue(sharedPreferences),
        realmProvider.overrideWithValue(realm),
      ],
      child: const Skedul(),
    ),
  );
}
