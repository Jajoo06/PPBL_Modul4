import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/form_laporan_model.dart';

class HalamanFormLaporan extends StatefulWidget {
  const HalamanFormLaporan({super.key});

  @override
  State<HalamanFormLaporan> createState() => _HalamanFormLaporanState();
}

class _HalamanFormLaporanState extends State<HalamanFormLaporan> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulController;
  late final TextEditingController _lokasiController;
  late final TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    final model = context.read<FormLaporanModel>();
    _judulController = TextEditingController(text: model.judul);
    _lokasiController = TextEditingController(text: model.lokasi);
    _deskripsiController = TextEditingController(text: model.deskripsi);
  }

  @override
  void dispose() {
    _judulController.dispose();
    _lokasiController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _kirimLaporan() {
    if (!_formKey.currentState!.validate()) return;

    final model = context.read<FormLaporanModel>();
    if (!model.persetujuan) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon konfirmasi kebenaran informasi laporan.'),
        ),
      );
      return;
    }

    if (!model.kirimLaporan()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan belum dapat dikirim.')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Laporan berhasil dikirim.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FormLaporanModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Laporan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              'Laporakan kepada kami',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Informasi yang jelas membantu petugas menindaklanjuti laporanmu.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: const Key('judul-laporan'),
              controller: _judulController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Judul laporan',
                hintText: 'Contoh: Lampu jalan mati',
                prefixIcon: Icon(Icons.title),
              ),
              onChanged: context.read<FormLaporanModel>().ubahJudul,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Judul laporan wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('lokasi-laporan'),
              controller: _lokasiController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Lokasi kejadian',
                hintText: 'Nama jalan atau lingkungan',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              onChanged: context.read<FormLaporanModel>().ubahLokasi,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Lokasi kejadian wajib diisi'
                  : null,
            ),
            const SizedBox(height: 22),
            Text(
              'Kategori laporan',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            RadioGroup<String>(
              groupValue: model.kategori,
              onChanged: (value) {
                if (value != null) {
                  context.read<FormLaporanModel>().ubahKategori(value);
                }
              },
              child: Column(
                children: [
                  for (final kategori in const [
                    'Keamanan',
                    'Fasilitas umum',
                    'Kebersihan',
                    'Lainnya',
                  ])
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(kategori),
                      value: kategori,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('deskripsi-laporan'),
              controller: _deskripsiController,
              minLines: 3,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Jelaskan masalah dan waktu kejadian',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.notes),
              ),
              onChanged: context.read<FormLaporanModel>().ubahDeskripsi,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Deskripsi laporan wajib diisi'
                  : null,
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: model.anonymous,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Sembunyikan nama saya'),
              subtitle: const Text('Nama tidak ditampilkan kepada warga lain.'),
              onChanged: (value) {
                context.read<FormLaporanModel>().ubahAnonymous(value ?? false);
              },
            ),
            CheckboxListTile(
              key: const Key('persetujuan-laporan'),
              contentPadding: EdgeInsets.zero,
              value: model.persetujuan,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Informasi laporan ini benar'),
              onChanged: (value) {
                context.read<FormLaporanModel>().ubahPersetujuan(
                  value ?? false,
                );
              },
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const Key('kirim-laporan'),
              onPressed: _kirimLaporan,
              icon: const Icon(Icons.send_outlined),
              label: const Text('Kirim laporan'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
