import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/features/home/presentation/controllers/selected_color_provider.dart';
import 'package:skedul/router/router.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';

class Skedul extends ConsumerWidget {
  const Skedul({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final isDark = ref.watch(themeChoosenProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Skedul",
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: "KumbhSans",
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: kColorDark,
          indicatorColor: Colors.black.withOpacity(0.00),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
                color: ref.watch(selectedColorProvider),
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "KumbhSans",
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.black.withOpacity(0.00),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: 12,
              color: ref.watch(selectedColorProvider),
              fontWeight: FontWeight.w500,
            ),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
