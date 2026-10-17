import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  String _tanggal(DateTime tanggal) =>
      '${tanggal.day.toString().padLeft(2, '0')}/${tanggal.month.toString().padLeft(2, '0')}/${tanggal.year}';

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final pengajuan = model.daftarPengajuan;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pengajuan.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 70,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada pengajuan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Tekan tombol + untuk membuat pengajuan pertama.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pengajuan.length,
              itemBuilder: (context, index) {
                final item = pengajuan[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.rincianPengajuan,
                    arguments: item,
                  ),
                  onLongPress: () {
                    if (!item.selesai) {
                      model.tandaiSelesai(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pengajuan ditandai selesai ditindaklanjuti.',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pengajuan ini sudah selesai.'),
                        ),
                      );
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: item.selesai
                                ? const Color(0xFFE2F6E9)
                                : const Color(0xFFE4ECFF),
                            child: Icon(
                              item.selesai
                                  ? Icons.check_circle
                                  : Icons.assignment_outlined,
                              color: item.selesai
                                  ? Colors.green
                                  : const Color(0xFF2457C5),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.bidang,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(item.nama),
                                Text(
                                  _tanggal(item.tanggal),
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.selesai
                                      ? 'Selesai ditindaklanjuti'
                                      : 'Menunggu tindak lanjut',
                                  style: TextStyle(
                                    color: item.selesai
                                        ? Colors.green
                                        : Colors.orange.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.rincianLayanan),
        icon: const Icon(Icons.add),
        label: const Text('Pengajuan Baru'),
      ),
    );
  }
}
