import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  List<String> _favoriteCities = [];

  List<String> get favoriteCities => _favoriteCities;

  void addFavoriteCity(String city) {
    if (!_favoriteCities.contains(city)) {
      _favoriteCities.add(city);
      notifyListeners();
    }
  }

  void removeFavoriteCity(String city) {
    if (_favoriteCities.contains(city)) {
      _favoriteCities.remove(city);
      notifyListeners();
    }
  }
}
