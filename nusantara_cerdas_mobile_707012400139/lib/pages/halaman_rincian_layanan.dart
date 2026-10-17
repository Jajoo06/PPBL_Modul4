import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class HalamanRincianLayanan extends StatefulWidget {
  const HalamanRincianLayanan({super.key});

  @override
  State<HalamanRincianLayanan> createState() => _HalamanRincianLayananState();
}

class _HalamanRincianLayananState extends State<HalamanRincianLayanan> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  String? _bidang;
  String? _sesi;
  bool _setuju = false;
  bool _mengirim = false;

  bool get _formSiap =>
      _namaController.text.trim().isNotEmpty &&
      _emailController.text.trim().contains('@') &&
      _bidang != null &&
      _sesi != null &&
      _setuju &&
      !_mengirim;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirimPengajuan() async {
    if (!_formKey.currentState!.validate() ||
        !_setuju ||
        _sesi == null ||
        _bidang == null)
      return;
    setState(() => _mengirim = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.read<PengajuanModel>().tambahPengajuan(
      nama: _namaController.text,
      email: _emailController.text,
      bidang: _bidang!,
      sesi: _sesi!,
    );
    setState(() => _mengirim = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pengajuan berhasil disimpan.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pengajuan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE4ECFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 36,
                    color: Color(0xFF2457C5),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pengajuan Layanan Warga',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('Lengkapi data berikut untuk mengirim pengajuan.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nama lengkap',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _namaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
              onChanged: (_) => setState(() {}),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Nama wajib diisi.'
                  : null,
            ),
            const SizedBox(height: 16),
            const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'nama@email.com',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return 'Email wajib diisi.';
                if (!value.contains('@'))
                  return 'Email harus mengandung karakter @.';
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Bidang layanan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _bidang,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
                hintText: 'Pilih bidang layanan',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Administrasi',
                  child: Text('Administrasi'),
                ),
                DropdownMenuItem(
                  value: 'Infrastruktur',
                  child: Text('Infrastruktur'),
                ),
                DropdownMenuItem(value: 'Kesehatan', child: Text('Kesehatan')),
                DropdownMenuItem(value: 'Keamanan', child: Text('Keamanan')),
                DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
              ],
              onChanged: (value) => setState(() => _bidang = value),
              validator: (value) =>
                  value == null ? 'Pilih bidang layanan.' : null,
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih sesi kunjungan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: const Text('Pagi (08.00–11.00)'),
              value: 'Pagi',
              groupValue: _sesi,
              onChanged: (value) => setState(() => _sesi = value),
            ),
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: const Text('Siang (11.00–14.00)'),
              value: 'Siang',
              groupValue: _sesi,
              onChanged: (value) => setState(() => _sesi = value),
            ),
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: const Text('Sore (14.00–16.00)'),
              value: 'Sore',
              groupValue: _sesi,
              onChanged: (value) => setState(() => _sesi = value),
            ),
            if (_sesi == null)
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Pilih salah satu sesi kunjungan.',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            const SizedBox(height: 12),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _setuju,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) => setState(() => _setuju = value ?? false),
              title: const Text(
                'Saya menyetujui penggunaan data pribadi untuk keperluan layanan.',
              ),
              subtitle: !_setuju
                  ? const Text('Persetujuan wajib diberikan.')
                  : null,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _formSiap ? _kirimPengajuan : null,
                icon: _mengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _mengirim ? 'Mengirim pengajuan...' : 'Kirim Pengajuan',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tombol aktif setelah semua data valid, sesi dipilih, dan persetujuan dicentang.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
