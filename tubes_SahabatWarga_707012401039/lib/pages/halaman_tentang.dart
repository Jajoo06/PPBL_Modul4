import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.groups, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Sahabat Warga',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Sahabat Warga merupakan aplikasi yang membantu masyarakat menyampaikan laporan mengenai masalah dan keamanan di lingkungan sekitar.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text('Versi 1.0.0', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
