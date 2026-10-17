import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';

class ChatModel extends ChangeNotifier {
  static final ChatUser pengguna = ChatUser(id: 'warga-1', firstName: 'Saya');
  static final ChatUser petugas = ChatUser(
    id: 'petugas-1',
    firstName: 'Sahabat Warga',
  );

  final List<ChatMessage> _pesan = [
    ChatMessage(
      user: petugas,
      createdAt: DateTime.now(),
      text: 'Halo! Ada yang bisa kami bantu?',
    ),
  ];

  List<ChatMessage> get pesan => List.unmodifiable(_pesan);
  int get jumlahPesan => _pesan.length;
  String get pesanTerbaru => _pesan.last.text;

  void kirimPesan(String teks) {
    final isi = teks.trim();
    if (isi.isEmpty) return;

    _pesan.add(
      ChatMessage(user: pengguna, createdAt: DateTime.now(), text: isi),
    );
    _pesan.add(
      ChatMessage(
        user: petugas,
        createdAt: DateTime.now(),
        text: 'Pesanmu sudah kami terima. Tim kami akan segera membantu.',
      ),
    );
    notifyListeners();
  }
}
