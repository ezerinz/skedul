import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/features/auth/presentation/auth_gate.dart';
import 'package:skedul/features/auth/presentation/initial.dart';
import 'package:skedul/features/home/presentation/home_screen.dart';
import 'package:skedul/features/jadwal/presentation/edit_jadwal.dart';
import 'package:skedul/features/settings/presentation/add_semester.dart';
import 'package:skedul/features/settings/presentation/edit_profile_screen.dart';
import 'package:skedul/features/settings/presentation/setting_screen.dart';
import 'package:skedul/features/siakad_integration/presentation/siakad_integration.dart';
import 'package:skedul/features/tugas/presentation/edit_tugas.dart';
import 'package:skedul/features/tugas/presentation/widgets/deadline_calendar.dart';
import 'package:skedul/shared/widgets/confirmation_dialog.dart';
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
          builder: (context, state) => const InitialScreen(),
        ),
        GoRoute(
          path: "/confirm-dialog",
          name: "confirm-dialog",
          pageBuilder: (context, state) {
            final extra = state.extra as List;
            return DialogPage(
              builder: (_) => ConfirmationDialog(
                  buttons: extra[2], title: extra[0], subtitle: extra[1]),
            );
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
              },
              routes: [
                GoRoute(
                    path: "deadline-date",
                    name: "deadline-date",
                    pageBuilder: (context, state) {
                      final extra = state.extra as List;
                      return DialogPage(
                        builder: (context) =>
                            DeadlineCalendar(extra[0], extra[1]),
                      );
                    })
              ],
            ),
            GoRoute(
              path: 'pengaturan',
              name: 'pengaturan',
              builder: (_, __) => const SettingScreen(),
            ),
            GoRoute(
                path: "edit-profile",
                name: "edit-profile",
                builder: (_, __) => const EditProfileScreen(),
                routes: [
                  GoRoute(
                    path: "add-semester",
                    name: "add-semester",
                    pageBuilder: (context, state) => DialogPage(
                      builder: (context) => const AddSemester(),
                    ),
                  )
                ])
          ],
        ),
      ],
    );
  }
}
