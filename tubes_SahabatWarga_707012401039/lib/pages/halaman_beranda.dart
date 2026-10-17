import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat_model.dart';
import '../model/favorit_model.dart';
import '../model/form_laporan_model.dart';
import '../navigation/app_routes.dart';
import '../navigation/kerangka_navigasi.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final jumlahFavorit = context.select<FavoritModel, int>(
      (model) => model.daftarFavorit.length,
    );
    final jumlahLaporan = context.select<FormLaporanModel, int>(
      (model) => model.daftarLaporan.length,
    );
    final chat = context.watch<ChatModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sahabat Warga'),
        actions: [
          IconButton(
            tooltip: 'Buka chat',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
            icon: Badge(
              label: Text('${chat.jumlahPesan}'),
              child: const Icon(Icons.chat_bubble_outline),
            ),
          ),
        ],
      ),

      drawer: NavigationDrawer(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 32, 16, 16),
            child: Text(
              'Sahabat Warga',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          NavigationDrawerDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: const Text('Beranda'),
            enabled: true,
          ),

          NavigationDrawerDestination(
            icon: const Icon(Icons.report_outlined),
            selectedIcon: const Icon(Icons.report),
            label: const Text('Laporan'),
            enabled: true,
          ),

          NavigationDrawerDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: const Text('Profil'),
            enabled: true,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.pengaturan);
            },
          ),

          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Chat warga'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.chat);
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang di Sahabat Warga',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Sampaikan aspirasi dan tetap terhubung dengan warga sekitar.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0x33FFFFFF),
                      child: Icon(Icons.groups_outlined, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Laporan Kamu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$jumlahLaporan laporan sudah kamu kirim',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 32,
                ),
                title: const Text(
                  'Laporan Favorit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Jumlah laporan yang kamu tandai sebagai favorit.',
                ),
                trailing: CircleAvatar(child: Text('$jumlahFavorit')),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.campaign_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Buat Laporan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Laporkan kejadian atau masalah yang terjadi di lingkungan sekitar.',
                    ),

                    const SizedBox(height: 16),

                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.formLaporan);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Buat laporan'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .secondaryContainer,
                  child: const Icon(Icons.chat_bubble_outline),
                ),
                title: const Text(
                  'Ruang obrolan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(chat.pesanTerbaru, maxLines: 1),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, AppRoutes.chat),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.laporan),
                child: const Text('Lihat semua laporan'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const KerangkaNavigasi(indeksAktif: 0),
    );
  }
}
