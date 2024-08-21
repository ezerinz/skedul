import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class InitialScreen extends ConsumerStatefulWidget {
  const InitialScreen({super.key});

  @override
  ConsumerState<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kColorSecondary.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: kColorPrimary.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Halo, ${name.split(' ')[0]}${name.isNotEmpty ? "!" : ""}',
                    style: kTextSemiBold24.copyWith(fontSize: 30),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  'Selamat Datang. ${name.isNotEmpty ? "" : "Nama kamu siapa?"}',
                  style: kTextMedium18,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  cursorColor: kColorPrimary,
                  onChanged: (value) {
                    setState(() {
                      name = value.trim();
                    });
                  },
                  style: kTextMedium18,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kColorPrimary),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: name.isEmpty
                        ? null
                        : () async {
                            await ref
                                .watch(sharedPrefsHelperProvider)
                                .saveName(name);
                            if (context.mounted) context.go('/home');
                          },
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: kColorSecondary,
                      foregroundColor: kColorSecondary,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Lanjut'),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: kColorPrimary.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kColorSecondary.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
