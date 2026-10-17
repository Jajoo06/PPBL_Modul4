import 'package:flutter/foundation.dart';

class Pengajuan {
  final String id;
  final String nama;
  final String email;
  final String bidang;
  final String sesi;
  final DateTime tanggal;
  bool selesai;

  Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.bidang,
    required this.sesi,
    required this.tanggal,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuan = [];

  List<Pengajuan> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);
  int get jumlahPengajuan => _daftarPengajuan.length;
  int get jumlahSelesai => _daftarPengajuan.where((p) => p.selesai).length;
  int get jumlahBelumSelesai =>
      _daftarPengajuan.where((p) => !p.selesai).length;

  Map<String, int> get jumlahPerBidang {
    final hasil = <String, int>{
      'Administrasi': 0,
      'Infrastruktur': 0,
      'Kesehatan': 0,
      'Keamanan': 0,
      'Lainnya': 0,
    };
    for (final pengajuan in _daftarPengajuan) {
      hasil[pengajuan.bidang] = (hasil[pengajuan.bidang] ?? 0) + 1;
    }
    return hasil;
  }

  void tambahPengajuan({
    required String nama,
    required String email,
    required String bidang,
    required String sesi,
  }) {
    _daftarPengajuan.insert(
      0,
      Pengajuan(
        id: 'NC${DateTime.now().millisecondsSinceEpoch}',
        nama: nama.trim(),
        email: email.trim(),
        bidang: bidang,
        sesi: sesi,
        tanggal: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final indeks = _daftarPengajuan.indexWhere((p) => p.id == id);
    if (indeks == -1) return;
    _daftarPengajuan[indeks].selesai = true;
    notifyListeners();
  }
}
