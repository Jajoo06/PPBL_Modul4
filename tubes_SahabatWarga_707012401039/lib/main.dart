import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/app_routes.dart';
import 'model/chat_model.dart';
import 'model/favorit_model.dart';
import 'model/form_laporan_model.dart';

void main() {
  runApp(const AplikasiSahabatWarga());
}

class AplikasiSahabatWarga extends StatelessWidget {
  const AplikasiSahabatWarga({super.key});

  @override
  Widget build(BuildContext context) {
    const warnaTeal = Color(0xFF087E78);
    const warnaAmber = Color(0xFFFFB547);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritModel()),
        ChangeNotifierProvider(create: (_) => FormLaporanModel()),
        ChangeNotifierProvider(create: (_) => ChatModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sahabat Warga',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: warnaTeal,
            primary: warnaTeal,
            secondary: warnaAmber,
            surface: const Color(0xFFF7FAF8),
          ),
          scaffoldBackgroundColor: const Color(0xFFF7FAF8),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF7FAF8),
            foregroundColor: Color(0xFF173B38),
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFE5EEEA)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFDCE8E3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFDCE8E3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: warnaTeal, width: 1.5),
            ),
          ),
        ),
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    );
  }
}
