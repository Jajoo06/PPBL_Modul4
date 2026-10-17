import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat_model.dart';
import '../navigation/kerangka_navigasi.dart';

class HalamanChat extends StatelessWidget {
  const HalamanChat({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatModel>();
    final warnaPrimer = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Chat Sahabat Warga')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: warnaPrimer,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.support_agent),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tim Sahabat Warga',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Siap mendengarkan dan membantu'),
                    ],
                  ),
                ),
                const Icon(Icons.circle, color: Color(0xFF35A77A), size: 10),
              ],
            ),
          ),
          Expanded(
            child: DashChat(
              currentUser: ChatModel.pengguna,
              messages: chat.pesan,
              onSend: (pesan) =>
                  context.read<ChatModel>().kirimPesan(pesan.text),
              messageOptions: MessageOptions(
                currentUserContainerColor: warnaPrimer,
                currentUserTextColor: Colors.white,
                containerColor: const Color(0xFFFFF1D6),
                textColor: const Color(0xFF35413D),
                showTime: true,
                borderRadius: 18,
              ),
              inputOptions: InputOptions(
                sendOnEnter: true,
                textCapitalization: TextCapitalization.sentences,
                sendButtonBuilder: (send) => IconButton(
                  key: const Key('kirim-pesan'),
                  onPressed: send,
                  icon: const Icon(Icons.send),
                ),
                inputDecoration: InputDecoration(
                  hintText: 'Tulis pesan...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                inputToolbarStyle: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFE5EEEA))),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const KerangkaNavigasi(indeksAktif: 2),
    );
  }
}
