import 'package:flutter/foundation.dart';

class PesanChat {
  final String teks;
  final bool dariWarga;
  final DateTime waktu;

  PesanChat({required this.teks, required this.dariWarga, DateTime? waktu})
    : waktu = waktu ?? DateTime.now();
}

class ChatModel extends ChangeNotifier {
  final List<PesanChat> _pesan = [
    PesanChat(
      teks: 'Halo, selamat datang di layanan Tanya Petugas. Ada yang bisa kami bantu?',
      dariWarga: false,
    ),
  ];

  List<PesanChat> get pesan => List.unmodifiable(_pesan);

  void kirimPesan(String teks) {
    final isi = teks.trim();
    if (isi.isEmpty) return;
    _pesan.add(PesanChat(teks: isi, dariWarga: true));
    _pesan.add(
      PesanChat(
        teks: 'Terima kasih. Pesan Anda sudah diterima dan akan ditindaklanjuti petugas.',
        dariWarga: false,
      ),
    );
    notifyListeners();
  }
}
