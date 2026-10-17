import 'package:flutter/material.dart';

import '../model/pengajuan_model.dart';

class HalamanRincianPengajuan extends StatelessWidget {
  final Pengajuan pengajuan;
  const HalamanRincianPengajuan({super.key, required this.pengajuan});

  @override
  Widget build(BuildContext context) {
    final tanggal = pengajuan.tanggal;
    final tanggalTeks =
        '${tanggal.day.toString().padLeft(2, '0')}/${tanggal.month.toString().padLeft(2, '0')}/${tanggal.year} ${tanggal.hour.toString().padLeft(2, '0')}:${tanggal.minute.toString().padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Pengajuan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.assignment_turned_in,
                  size: 48,
                  color: Color(0xFF2457C5),
                ),
                const SizedBox(height: 12),
                Text(
                  pengajuan.bidang,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nomor pengajuan: ${pengajuan.id}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const Divider(height: 28),
                _BarisRincian(label: 'Nama', value: pengajuan.nama),
                _BarisRincian(label: 'Email', value: pengajuan.email),
                _BarisRincian(label: 'Bidang layanan', value: pengajuan.bidang),
                _BarisRincian(label: 'Sesi kunjungan', value: pengajuan.sesi),
                _BarisRincian(label: 'Tanggal', value: tanggalTeks),
                _BarisRincian(
                  label: 'Status',
                  value: pengajuan.selesai
                      ? 'Selesai ditindaklanjuti'
                      : 'Menunggu tindak lanjut',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarisRincian extends StatelessWidget {
  final String label;
  final String value;
  const _BarisRincian({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 125,
          child: Text(label, style: const TextStyle(color: Colors.black54)),
        ),
        const Text(': '),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
