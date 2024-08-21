import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/shared/provider/settings/kuliah_besok_provider.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  switchThemeMode(bool isDark) {
    ref.read(themeChoosenProvider.notifier).change(!isDark);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeChoosenProvider);
    final isKuliahBesok = ref.watch(isKuliahBesokProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        titleTextStyle: kTextSemiBold18.copyWith(
            fontFamily: "KumbhSans",
            color: isDark ? kColorDarkForeground : kColorDark),
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
                        style: kTextMedium18,
                      ),
                    ),
                    Switch(
                      activeColor: kColorPrimary,
                      inactiveThumbColor: kColorSecondary,
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
                  ? kColorDarkForeground.withOpacity(0.5)
                  : kColorDark.withOpacity(0.5),
            ),
            InkWell(
              onTap: () {
                ref.read(isKuliahBesokProvider.notifier).change(!isKuliahBesok);
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
                            style: kTextMedium18,
                          ),
                          Text(
                            "Tampilkan kuliah besok di halaman beranda",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Switch(
                      activeColor: kColorPrimary,
                      inactiveThumbColor: kColorSecondary,
                      inactiveTrackColor: Colors.transparent,
                      value: isKuliahBesok,
                      onChanged: (value) {
                        ref
                            .read(isKuliahBesokProvider.notifier)
                            .change(!isKuliahBesok);
                      },
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
