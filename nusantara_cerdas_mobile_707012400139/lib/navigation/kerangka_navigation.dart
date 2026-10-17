import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_lokasi_kantor.dart';
import '../pages/halaman_statistik_layanan.dart';
import '../pages/halaman_tanya_petugas.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  final int initialIndex;

  const KerangkaNavigasi({super.key, this.initialIndex = 0});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  late int _indeksTerpilih;

  final List<String> _judul = const [
    'Nusantara Cerdas',
    'Layanan Warga',
    'Tanya Petugas',
    'Lokasi Kantor',
    'Statistik Layanan',
  ];

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanWarga(),
    HalamanTanyaPetugas(),
    HalamanLokasiKantor(),
    HalamanStatistikLayanan(),
  ];

  @override
  void initState() {
    super.initState();
    _indeksTerpilih = widget.initialIndex.clamp(0, 4);
  }

  void _pilihHalaman(int indeks) {
    setState(() => _indeksTerpilih = indeks);
  }

  void _bukaLayanan() {
    Navigator.pushNamed(context, AppRoutes.rincianLayanan);
  }

  void _bukaMenu(int indeks) {
    Navigator.pop(context);
    if (indeks == 5) {
      Navigator.pushNamed(context, AppRoutes.rincianLayanan);
    } else {
      _pilihHalaman(indeks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
        actions: [
          IconButton(
            tooltip: 'Buat pengajuan',
            onPressed: _bukaLayanan,
            icon: const Icon(Icons.add_task),
          ),
        ],
      ),
      drawer: NavigationDrawer(
        selectedIndex: _indeksTerpilih,
        onDestinationSelected: _bukaMenu,
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 24, 16, 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFE4ECFF),
                  child: Icon(Icons.location_city, color: Color(0xFF2457C5)),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Nusantara Cerdas',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Beranda'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: Text('Warga'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: Text('Tanya Petugas'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: Text('Lokasi Kantor'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: Text('Statistik Layanan'),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(28, 12, 16, 8),
            child: Text('Lainnya'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: Text('Buat Pengajuan'),
          ),
        ],
      ),
      body: IndexedStack(index: _indeksTerpilih, children: _halaman),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeksTerpilih,
        onDestinationSelected: _pilihHalaman,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Warga',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Peta',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
        ],
      ),
    );
  }
}
