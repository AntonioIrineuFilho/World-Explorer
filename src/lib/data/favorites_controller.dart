import 'package:flutter/foundation.dart';
import '../models/country.dart';

/// Controlador simples que mantém a lista de países favoritados em memória.
///
/// Aqui está apenas o mock visual: quando a persistência local real for
/// implementada (ex: shared_preferences ou sqlite), este controlador pode
/// ser adaptado para ler/gravar os favoritos em disco, mantendo a mesma
/// interface (ValueNotifier) usada pelas telas.
class FavoritesController {
  FavoritesController._internal();

  static final FavoritesController instance = FavoritesController._internal();

  final ValueNotifier<List<Country>> favorites = ValueNotifier<List<Country>>([]);

  bool isFavorite(Country country) {
    return favorites.value.any((c) => c.code == country.code);
  }

  void toggleFavorite(Country country) {
    final current = List<Country>.from(favorites.value);
    if (isFavorite(country)) {
      current.removeWhere((c) => c.code == country.code);
    } else {
      current.add(country);
    }
    favorites.value = current;
  }

  void removeFavorite(Country country) {
    final current = List<Country>.from(favorites.value)
      ..removeWhere((c) => c.code == country.code);
    favorites.value = current;
  }
}
