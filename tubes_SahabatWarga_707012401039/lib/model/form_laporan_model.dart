import 'package:flutter/foundation.dart';

class LaporanWarga {
  const LaporanWarga({
    required this.judul,
    required this.lokasi,
    required this.kategori,
    required this.deskripsi,
    required this.tanggal,
    required this.anonymous,
  });

  final String judul;
  final String lokasi;
  final String kategori;
  final String deskripsi;
  final DateTime tanggal;
  final bool anonymous;

  Map<String, String> toRouteArguments() => {
    'judul': judul,
    'lokasi': lokasi,
    'status': 'Menunggu Verifikasi',
    'deskripsi': '[$kategori] $deskripsi',
  };
}

class FormLaporanModel extends ChangeNotifier {
  String _judul = '';
  String _lokasi = '';
  String _deskripsi = '';
  String _kategori = 'Keamanan';
  bool _anonymous = false;
  bool _persetujuan = false;
  final List<LaporanWarga> _daftarLaporan = [];

  String get judul => _judul;
  String get lokasi => _lokasi;
  String get deskripsi => _deskripsi;
  String get kategori => _kategori;
  bool get anonymous => _anonymous;
  bool get persetujuan => _persetujuan;
  List<LaporanWarga> get daftarLaporan => List.unmodifiable(_daftarLaporan);

  void ubahJudul(String nilai) {
    _judul = nilai;
    notifyListeners();
  }

  void ubahLokasi(String nilai) {
    _lokasi = nilai;
    notifyListeners();
  }

  void ubahDeskripsi(String nilai) {
    _deskripsi = nilai;
    notifyListeners();
  }

  void ubahKategori(String nilai) {
    _kategori = nilai;
    notifyListeners();
  }

  void ubahAnonymous(bool nilai) {
    _anonymous = nilai;
    notifyListeners();
  }

  void ubahPersetujuan(bool nilai) {
    _persetujuan = nilai;
    notifyListeners();
  }

  bool kirimLaporan() {
    if (_judul.trim().isEmpty ||
        _lokasi.trim().isEmpty ||
        _deskripsi.trim().isEmpty ||
        !_persetujuan) {
      return false;
    }

    _daftarLaporan.insert(
      0,
      LaporanWarga(
        judul: _judul.trim(),
        lokasi: _lokasi.trim(),
        kategori: _kategori,
        deskripsi: _deskripsi.trim(),
        tanggal: DateTime.now(),
        anonymous: _anonymous,
      ),
    );
    _resetForm();
    notifyListeners();
    return true;
  }

  void _resetForm() {
    _judul = '';
    _lokasi = '';
    _deskripsi = '';
    _kategori = 'Keamanan';
    _anonymous = false;
    _persetujuan = false;
  }
}
