import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat_model.dart';

class HalamanTanyaPetugas extends StatefulWidget {
  const HalamanTanyaPetugas({super.key});

  @override
  State<HalamanTanyaPetugas> createState() => _HalamanTanyaPetugasState();
}

class _HalamanTanyaPetugasState extends State<HalamanTanyaPetugas> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _kirim() {
    final teks = _controller.text.trim();
    if (teks.isEmpty) return;
    context.read<ChatModel>().kirimPesan(teks);
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final daftarPesan = context.watch<ChatModel>().pesan;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFFE4ECFF),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF2457C5),
                  child: Icon(Icons.support_agent, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Petugas Layanan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Simulasi percakapan petugas',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(14),
              itemCount: daftarPesan.length,
              itemBuilder: (context, index) {
                final pesan = daftarPesan[index];
                return Align(
                  alignment: pesan.dariWarga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: pesan.dariWarga
                          ? const Color(0xFF2457C5)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(pesan.dariWarga ? 16 : 4),
                        bottomRight: Radius.circular(pesan.dariWarga ? 4 : 16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pesan.dariWarga ? 'Anda' : 'Petugas',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: pesan.dariWarga
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pesan.teks,
                          style: TextStyle(
                            color: pesan.dariWarga
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${pesan.waktu.hour.toString().padLeft(2, '0')}:${pesan.waktu.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 10,
                            color: pesan.dariWarga
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _kirim(),
                      decoration: const InputDecoration(
                        hintText: 'Tulis pesan...',
                        prefixIcon: Icon(Icons.message_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _kirim,
                    icon: const Icon(Icons.send),
                    tooltip: 'Kirim pesan',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
