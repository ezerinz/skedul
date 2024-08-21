import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';
import 'package:skedul/shared/theme/text.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstTime = ref.watch(sharedPrefsHelperProvider).isFirstTime();

    Future.delayed(Duration(seconds: 2), () {
      if (isFirstTime) {
        context.go("/initial");
      } else {
        context.go("/home");
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'assets/Icon.png',
              width: 200,
            ),
            Spacer(),
            Text(
              'Skedul',
              style: kTextMedium18,
            ),
            SizedBox(
              height: kBottomNavigationBarHeight,
            )
          ],
        ),
      ),
    );
  }
}
