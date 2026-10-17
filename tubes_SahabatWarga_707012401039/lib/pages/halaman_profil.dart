import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/kerangka_navigasi.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 16),
            const Text(
              'Zahran Rauhillah Raziq',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Zahran@sahabatwarga.com'),
            const SizedBox(height: 30),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Pengaturan'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.pengaturan);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const KerangkaNavigasi(indeksAktif: 3),
    );
  }
}
