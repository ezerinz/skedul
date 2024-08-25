import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/router/router.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';

class Skedul extends ConsumerWidget {
  const Skedul({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final isDark = ref.watch(isDarkModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Skedul",
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: AppTheme.darkThemeData,
      theme: AppTheme.themeData,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
