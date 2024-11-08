import 'package:flutter/material.dart';

class SearchHistoryProvider with ChangeNotifier {
  List<String> _searchHistory = [];

  List<String> get searchHistory => _searchHistory;

  void addSearchCity(String city) {
    if (!_searchHistory.contains(city)) {
      _searchHistory.add(city);
      notifyListeners();
    }
  }

  void removeFavoriteCity() {
    _searchHistory=[];
    notifyListeners();
  }
}
