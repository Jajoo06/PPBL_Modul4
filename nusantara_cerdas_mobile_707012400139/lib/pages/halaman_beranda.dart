import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xFF2457C5),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_city, color: Colors.white, size: 42),
              SizedBox(height: 18),
              Text(
                'Halo, Warga!',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              Text(
                'Layanan kota dalam satu genggaman.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Ajukan layanan dan pantau perkembangannya dengan mudah.',
                style: TextStyle(color: Colors.white, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Total Pengajuan',
                value: '${model.jumlahPengajuan}',
                icon: Icons.assignment,
                color: const Color(0xFF2457C5),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Selesai',
                value: '${model.jumlahSelesai}',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'Layanan Utama',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            _MenuCard(
              icon: Icons.assignment_outlined,
              title: 'Buat Pengajuan',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.rincianLayanan),
            ),
            _MenuCard(
              icon: Icons.chat_bubble_outline,
              title: 'Tanya Petugas',
              onTap: () => Navigator.pushNamed(context, AppRoutes.tanyaPetugas),
            ),
            _MenuCard(
              icon: Icons.map_outlined,
              title: 'Lokasi Kantor',
              onTap: () => Navigator.pushNamed(context, AppRoutes.lokasiKantor),
            ),
            _MenuCard(
              icon: Icons.bar_chart,
              title: 'Statistik Layanan',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.statistikLayanan),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    ),
  );
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Ink(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 34, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
