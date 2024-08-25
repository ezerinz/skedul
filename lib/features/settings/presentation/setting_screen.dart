import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/utils.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  switchThemeMode(bool isDark) {
    ref.read(isDarkModeProvider.notifier).update(!isDark);
  }

  TextEditingController batasTugasCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    batasTugasCtrl.text = "${ref.read(batasTugasProvider)}";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkModeProvider);
    final isKuliahBesok = ref.watch(isKuliahBesokProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        titleTextStyle: AppTheme.kTextSemiBold18.copyWith(
            fontFamily: "KumbhSans",
            color:
                isDark ? AppTheme.kColorDarkForeground : AppTheme.kColorDark),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                switchThemeMode(isDark);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Mode Gelap",
                        style: AppTheme.kTextMedium18,
                      ),
                    ),
                    Switch(
                      activeColor: AppTheme.kColorPrimary,
                      inactiveThumbColor: AppTheme.kColorSecondary,
                      inactiveTrackColor: Colors.grey.shade100,
                      value: isDark,
                      onChanged: (value) {
                        switchThemeMode(isDark);
                      },
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
              height: 1.0,
              color: isDark
                  ? AppTheme.kColorDarkForeground.withOpacity(0.5)
                  : AppTheme.kColorDark.withOpacity(0.5),
            ),
            InkWell(
              onTap: () {
                ref.read(isKuliahBesokProvider.notifier).update(!isKuliahBesok);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tampilkan Kuliah Besok",
                            style: AppTheme.kTextMedium18,
                          ),
                          Text(
                            "Tampilkan kuliah besok di halaman beranda",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Switch(
                      activeColor: AppTheme.kColorPrimary,
                      inactiveThumbColor: AppTheme.kColorSecondary,
                      inactiveTrackColor: Colors.transparent,
                      value: isKuliahBesok,
                      onChanged: (value) {
                        ref
                            .read(isKuliahBesokProvider.notifier)
                            .update(!isKuliahBesok);
                      },
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
              height: 1.0,
              color: isDark
                  ? AppTheme.kColorDarkForeground.withOpacity(0.5)
                  : AppTheme.kColorDark.withOpacity(0.5),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Batas Tugas",
                            style: AppTheme.kTextMedium18,
                          ),
                          Text(
                            "Batas hari untuk tugas di halaman beranda",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: RoundedTextField(
                        hintText: "",
                        textAlign: TextAlign.center,
                        digitOnly: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textStyle:
                            AppTheme.kTextMedium16.copyWith(fontSize: 13),
                        controller: batasTugasCtrl,
                      ),
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            if (batasTugasCtrl.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarCustom(isDark, "Isi batas hari!"),
                              );
                            } else {
                              await ref
                                  .read(batasTugasProvider.notifier)
                                  .update(
                                    int.parse(
                                      batasTugasCtrl.text.trim(),
                                    ),
                                  );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarCustom(
                                      isDark, "Batas hari berhasil diubah"),
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: isDark
                                      ? AppTheme.kColorDarkForeground
                                      : Colors.black),
                            ),
                            child: const Icon(
                              Icons.check_outlined,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
