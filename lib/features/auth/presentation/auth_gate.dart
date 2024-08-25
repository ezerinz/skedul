import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/auth/presentation/controller/auth_provider.dart';
import 'package:skedul/shared/theme/theme.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstTime = ref.watch(authProvider);

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        if (isFirstTime) {
          context.go("/initial");
        } else {
          context.go("/home");
        }
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/Icon.png',
              width: 200,
            ),
            const Spacer(),
            const Text(
              'Skedul',
              style: AppTheme.kTextMedium18,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
