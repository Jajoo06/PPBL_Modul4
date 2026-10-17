import 'package:flutter/foundation.dart';

class FavoritModel extends ChangeNotifier {
  final Set<String> _daftarFavorit = {};

  Set<String> get daftarFavorit => Set.unmodifiable(_daftarFavorit);

  bool isFavorit(String judul) => _daftarFavorit.contains(judul);

  void toggleFavorit(String judul) {
    if (!_daftarFavorit.add(judul)) {
      _daftarFavorit.remove(judul);
    }
    notifyListeners();
  }
}
