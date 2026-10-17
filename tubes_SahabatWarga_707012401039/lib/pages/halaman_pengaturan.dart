import 'package:flutter/material.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  // State lokal untuk mengatur notifikasi.
  bool notifikasiAktif = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan'), centerTitle: true),

      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Preferensi Aplikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Pengaturan notifikasi menggunakan setState().
          SwitchListTile(
            secondary: Icon(
              notifikasiAktif
                  ? Icons.notifications_active
                  : Icons.notifications_off,
            ),
            title: const Text('Notifikasi'),
            subtitle: Text(
              notifikasiAktif
                  ? 'Notifikasi laporan aktif'
                  : 'Notifikasi laporan dinonaktifkan',
            ),
            value: notifikasiAktif,
            onChanged: (value) {
              setState(() {
                notifikasiAktif = value;
              });
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Bahasa'),
            subtitle: const Text('Bahasa Indonesia'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Bahasa aplikasi saat ini adalah Bahasa Indonesia.',
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privasi'),
            subtitle: const Text('Informasi mengenai privasi pengguna'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Privasi Pengguna'),
                    content: const Text(
                      'Gunakan Sahabat Warga dengan bijak. '
                      'Pastikan laporan yang dikirimkan benar '
                      'dan tidak menyebarkan informasi pribadi '
                      'orang lain tanpa izin.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Mengerti'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
