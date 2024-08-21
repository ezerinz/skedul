import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/auth/presentation/auth_gate.dart';
import 'package:skedul/features/auth/presentation/initial.dart';
import 'package:skedul/features/home/presentation/home_screen.dart';
import 'package:skedul/features/jadwal/presentation/edit_jadwal.dart';
import 'package:skedul/features/settings/ganti_name.dart';
import 'package:skedul/features/settings/setting_screen.dart';
import 'package:skedul/features/siakad_integration/presentation/siakad_integration.dart';
import 'package:skedul/features/tugas/presentation/edit_tugas.dart';
import 'package:skedul/shared/widgets/dialog_page.dart';

part 'router.g.dart';

@riverpod
class Router extends _$Router {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GoRouter build() {
    return GoRouter(
      navigatorKey: _navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const AuthGate();
          },
        ),
        GoRoute(
          path: '/initial',
          builder: (context, state) {
            return const InitialScreen();
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: "siakad-integration",
              name: "siakad",
              builder: (_, __) => const SiakadIntegration(),
            ),
            GoRoute(
              path: "ganti-nama",
              name: "gantinama",
              pageBuilder: (context, state) => DialogPage(
                builder: (context) => const GantiNama(),
              ),
            ),
            GoRoute(
              path: 'add-jadwal',
              name: "tambahjadwal",
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return EditJadwalScreen(
                    day: extra?["day"],
                    edit: extra?["edit"],
                    data: extra?["data"]);
              },
            ),
            GoRoute(
              path: 'add-tugas',
              name: "tambahtugas",
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return EditTugasScreen(
                  date: extra?["date"],
                  edit: extra?["edit"],
                  tugas: extra?["tugas"],
                );
                // return EditJadwalScreen(
                //     day: extra?["day"],
                //     edit: extra?["edit"],
                //     data: extra?["data"]);
              },
            ),
            GoRoute(
              path: 'pengaturan',
              name: 'pengaturan',
              builder: (_, __) => const SettingScreen(),
            )
          ],
        ),
      ],
    );
  }
}
