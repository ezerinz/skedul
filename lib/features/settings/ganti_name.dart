import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/shared/provider/shared_pref/shared_pref_helper_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class GantiNama extends ConsumerStatefulWidget {
  const GantiNama({super.key});

  @override
  ConsumerState<GantiNama> createState() => _GantiNamaState();
}

class _GantiNamaState extends ConsumerState<GantiNama> {
  TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCtrl,
            textAlign: TextAlign.center,
            onChanged: (text) {
              setState(() {});
            },
            cursorColor: kColorPrimary,
            style: kTextMedium18,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kColorPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: nameCtrl.text.isEmpty
                  ? null
                  : () async {
                      await ref
                          .watch(sharedPrefsHelperProvider)
                          .saveName(nameCtrl.text.trim());

                      ref.invalidate(sharedPrefsHelperProvider);
                      if (context.mounted) context.pop();
                    },
              style: ElevatedButton.styleFrom(
                  surfaceTintColor: kColorSecondary,
                  foregroundColor: kColorSecondary,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  )),
              child: const Text('Ganti'),
            ),
          ),
        ],
      ),
    );
  }
}
