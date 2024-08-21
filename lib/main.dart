import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_instance_provider.dart';
import 'package:skedul/skedul.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsInstanceProvider.overrideWithValue(sharedPreferences),
      ],
      child: const Skedul(),
    ),
  );
}
