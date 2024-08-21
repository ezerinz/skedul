import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/features/home/presentation/controllers/selected_color_provider.dart';
import 'package:skedul/features/home/presentation/pages/beranda.dart';
import 'package:skedul/features/home/presentation/pages/kuliah.dart';
import 'package:skedul/features/home/presentation/pages/profile.dart';
import 'package:skedul/features/home/presentation/pages/tugas.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/theme/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final pages = [
    const BerandaPage(),
    const TugasPage(),
    const KuliahPage(),
    const ProfilePage()
  ];

  final colors = [kColorPrimary, kColorSecondary];

  @override
  Widget build(BuildContext context) {
    Color selectedColor = ref.watch(selectedColorProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: selectedColor,
              ),
              left: BorderSide(color: selectedColor, width: 0.01),
              right: BorderSide(color: selectedColor, width: 0.01),
              top: BorderSide(color: selectedColor, width: 0.01),
            ),
            color: ref.watch(themeChoosenProvider) ? kColorDark : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0.0,
        // backgroundColor: _selectedColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            ref.read(selectedColorProvider.notifier).update(colors[index % 2]);
            // selectedColor = colors[index % 2];
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
            selectedIcon: Icon(
              Icons.home,
              color: kColorPrimary,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'Tugas',
            selectedIcon: Icon(
              Icons.assignment_turned_in,
              color: kColorSecondary,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Kuliah',
            selectedIcon: Icon(
              Icons.calendar_month,
              color: kColorPrimary,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: "Pengaturan",
            selectedIcon: Icon(
              Icons.settings,
              color: kColorSecondary,
            ),
          )
        ],
      ),
    );
  }
}
