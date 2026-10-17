import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/chat_model.dart';
import 'model/pengajuan_model.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigation.dart';
import 'pages/halaman_rincian_layanan.dart';
import 'pages/halaman_rincian_pengajuan.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ChangeNotifierProvider(create: (_) => ChatModel()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  Route<dynamic> _buatRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.beranda:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const KerangkaNavigasi(initialIndex: 0),
        );
      case AppRoutes.warga:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const KerangkaNavigasi(initialIndex: 1),
        );
      case AppRoutes.tanyaPetugas:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const KerangkaNavigasi(initialIndex: 2),
        );
      case AppRoutes.lokasiKantor:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const KerangkaNavigasi(initialIndex: 3),
        );
      case AppRoutes.statistikLayanan:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const KerangkaNavigasi(initialIndex: 4),
        );
      case AppRoutes.rincianLayanan:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HalamanRincianLayanan(),
        );
      case AppRoutes.rincianPengajuan:
        final argumen = settings.arguments;
        if (argumen is Pengajuan) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => HalamanRincianPengajuan(pengajuan: argumen),
          );
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const _HalamanTidakDitemukan(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const _HalamanTidakDitemukan(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2457C5)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2457C5),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD9E0EE)),
          ),
        ),
      ),
      initialRoute: AppRoutes.beranda,
      onGenerateRoute: _buatRoute,
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const _HalamanTidakDitemukan()),
    );
  }
}

class _HalamanTidakDitemukan extends StatelessWidget {
  const _HalamanTidakDitemukan();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
      body: const Center(child: Text('Route yang diminta tidak tersedia.')),
    );
  }
}
