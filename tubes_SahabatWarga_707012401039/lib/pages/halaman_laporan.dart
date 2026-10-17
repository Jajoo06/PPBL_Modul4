import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/favorit_model.dart';
import '../model/form_laporan_model.dart';
import '../navigation/app_routes.dart';
import '../navigation/kerangka_navigasi.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  final List<Map<String, String>> daftarLaporan = const [
    {
      'judul': 'Pencurian Kendaraan',
      'lokasi': 'Jl. Merdeka, Palembang',
      'status': 'Diproses',
      'deskripsi': 'Warga melaporkan adanya pencurian kendaraan bermotor pada malam hari.',
    },
    {
      'judul': 'Gangguan Keamanan',
      'lokasi': 'Kecamatan Ilir Timur',
      'status': 'Menunggu Verifikasi',
      'deskripsi':
          'Terdapat laporan mengenai gangguan keamanan di lingkungan warga.',
    },
    {
      'judul': 'Kerusakan Fasilitas Umum',
      'lokasi': 'Kecamatan Sukarami',
      'status': 'Selesai',
      'deskripsi':
          'Fasilitas umum mengalami kerusakan dan membutuhkan perbaikan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final favorit = context.watch<FavoritModel>();
    final laporanTerkirim = context
        .watch<FormLaporanModel>()
        .daftarLaporan
        .map((laporan) => laporan.toRouteArguments())
        .toList();
    final daftar = [...laporanTerkirim, ...daftarLaporan];

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Laporan')),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftar.length,
        itemBuilder: (context, index) {
          final laporan = daftar[index];
          final judul = laporan['judul']!;
          final sudahFavorit = favorit.isFavorit(judul);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.report)),

              title: Text(
                judul,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(
                '${laporan['lokasi']}\n'
                'Status: ${laporan['status']}',
              ),

              isThreeLine: true,

              // Tombol untuk menambahkan atau menghapus favorit.
              trailing: IconButton(
                tooltip: sudahFavorit
                    ? 'Hapus dari favorit'
                    : 'Tambahkan ke favorit',
                icon: Icon(
                  sudahFavorit ? Icons.favorite : Icons.favorite_border,
                  color: sudahFavorit ? Colors.red : null,
                ),
                onPressed: () {
                  context.read<FavoritModel>().toggleFavorit(judul);
                },
              ),

              // Ketuk bagian laporan untuk membuka halaman detail.
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detailLaporan,
                  arguments: laporan,
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.formLaporan),
        icon: const Icon(Icons.add),
        label: const Text('Buat laporan'),
      ),
      bottomNavigationBar: const KerangkaNavigasi(indeksAktif: 1),
    );
  }
}
