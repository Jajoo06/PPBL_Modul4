import 'package:flutter/material.dart';

import 'app_routes.dart';

class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key, required this.indeksAktif});

  final int indeksAktif;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: indeksAktif,
      onDestinationSelected: (indeks) {
        const routes = [
          AppRoutes.beranda,
          AppRoutes.laporan,
          AppRoutes.chat,
          AppRoutes.profil,
        ];
        if (indeks != indeksAktif) {
          Navigator.pushReplacementNamed(context, routes[indeks]);
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.report_outlined),
          selectedIcon: Icon(Icons.report),
          label: 'Laporan',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          selectedIcon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
