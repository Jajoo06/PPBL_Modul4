import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HalamanLokasiKantor extends StatefulWidget {
  const HalamanLokasiKantor({super.key});

  @override
  State<HalamanLokasiKantor> createState() => _HalamanLokasiKantorState();
}

class _HalamanLokasiKantorState extends State<HalamanLokasiKantor> {
  static const LatLng _pusatPeta = LatLng(-6.914744, 107.609810);

  final Set<Marker> _markerKantor = {
    Marker(
      markerId: MarkerId('balai_kota'),
      position: LatLng(-6.914744, 107.609810),
      infoWindow: InfoWindow(
        title: 'Balai Kota Bandung',
        snippet: 'Pusat layanan pemerintahan kota',
      ),
    ),
    Marker(
      markerId: MarkerId('disdukcapil'),
      position: LatLng(-6.921845, 107.604911),
      infoWindow: InfoWindow(
        title: 'Disdukcapil Kota Bandung',
        snippet: 'Layanan administrasi kependudukan',
      ),
    ),
    Marker(
      markerId: MarkerId('dpmptsp'),
      position: LatLng(-6.923120, 107.634210),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Perizinan',
        snippet: 'Contoh lokasi layanan perizinan',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF2457C5)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pilih penanda pada peta untuk melihat nama dan jenis layanan kantor.',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _pusatPeta,
                zoom: 12.5,
              ),
              markers: _markerKantor,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Peta contoh berpusat di Bandung. Pastikan API key Google Maps telah dikonfigurasi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
