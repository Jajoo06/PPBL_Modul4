import 'package:flutter/material.dart';

class HalamanDetailLaporan extends StatelessWidget {
  final String judul;
  final String lokasi;
  final String status;
  final String deskripsi;

  const HalamanDetailLaporan({
    super.key,
    required this.judul,
    required this.lokasi,
    required this.status,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Laporan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.description, size: 60),
            const SizedBox(height: 16),
            Text(
              judul,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Lokasi', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(lokasi),
            const SizedBox(height: 16),
            const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
            Chip(label: Text(status)),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(deskripsi),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Laporan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
