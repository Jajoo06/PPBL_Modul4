import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_chat.dart';
import '../pages/halaman_laporan.dart';
import '../pages/halaman_detail_laporan.dart';
import '../pages/halaman_form_laporan.dart';
import '../pages/halaman_profil.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_tentang.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String laporan = '/laporan';
  static const String formLaporan = '/laporan/buat';
  static const String detailLaporan = '/detail-laporan';
  static const String chat = '/chat';
  static const String profil = '/profil';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const HalamanBeranda(),
      laporan: (context) => const HalamanLaporan(),
      formLaporan: (context) => const HalamanFormLaporan(),
      chat: (context) => const HalamanChat(),
      profil: (context) => const HalamanProfil(),
      pengaturan: (context) => const HalamanPengaturan(),
      tentang: (context) => const HalamanTentang(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLaporan) {
      final arguments = settings.arguments;

      if (arguments is Map<String, String>) {
        return MaterialPageRoute(
          builder: (context) => HalamanDetailLaporan(
            judul: arguments['judul'] ?? 'Tidak ada judul',
            lokasi: arguments['lokasi'] ?? 'Tidak diketahui',
            status: arguments['status'] ?? 'Tidak diketahui',
            deskripsi: arguments['deskripsi'] ?? 'Tidak ada deskripsi',
          ),
          settings: settings,
        );
      }

      return MaterialPageRoute(
        builder: (context) => const HalamanDetailLaporan(
          judul: 'Data Tidak Tersedia',
          lokasi: 'Tidak diketahui',
          status: 'Tidak diketahui',
          deskripsi: 'Data laporan tidak dikirim dengan benar.',
        ),
        settings: settings,
      );
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 80, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Route Tidak Ditemukan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Route "${settings.name}" tidak tersedia.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.beranda,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Kembali ke Beranda'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
