import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skedul/features/home/presentation/pages/beranda.dart';
import 'package:skedul/features/home/presentation/pages/kuliah.dart';
import 'package:skedul/features/home/presentation/pages/profile.dart';
import 'package:skedul/features/home/presentation/pages/tugas.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/theme/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkModeProvider);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            color: isDark ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2.0,
                spreadRadius: 1.0,
              )
            ]),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          elevation: 0.0,
          height: 65,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Beranda',
              selectedIcon: Icon(
                Icons.home,
                color: AppTheme.kColorPrimary,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.assignment_turned_in_outlined),
              label: 'Tugas',
              selectedIcon: Icon(
                Icons.assignment_turned_in,
                color: AppTheme.kColorSecondary,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Kuliah',
              selectedIcon: Icon(
                Icons.calendar_month,
                color: AppTheme.kColorPrimary,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              label: "Profil",
              selectedIcon: Icon(
                Icons.person,
                color: AppTheme.kColorSecondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
