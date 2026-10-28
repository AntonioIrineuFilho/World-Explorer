import 'package:flutter/foundation.dart';
import '../../../shared/models/country.dart';

class FavoritesStore extends ChangeNotifier {
  final List<Country> _favorites = [];

  List<Country> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Country country) {
    return _favorites.any((item) => item.code == country.code);
  }

  void toggleFavorite(Country country) {
    if (isFavorite(country)) {
      _favorites.removeWhere((item) => item.code == country.code);
    } else {
      _favorites.add(country);
    }
    notifyListeners();
  }

  void removeFavorite(Country country) {
    final previousLength = _favorites.length;
    _favorites.removeWhere((item) => item.code == country.code);
    if (_favorites.length != previousLength) notifyListeners();
  }
}
