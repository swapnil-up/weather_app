import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryProvider with ChangeNotifier {
  List<String> _searchHistory = [];

  List<String> get searchHistory => _searchHistory;

  Future<void> loadSearchHistory() async{
    final prefs= await SharedPreferences.getInstance();
    _searchHistory=prefs.getStringList('searchHistory')??[];
    notifyListeners();
  }

  void addSearchCity(String city) async{
    if (!_searchHistory.contains(city)) {
      _searchHistory.insert(0,city);
      final prefs=await SharedPreferences.getInstance();
      prefs.setStringList('searchHistory',_searchHistory);
      notifyListeners();
    }
  }

  void removeFavoriteCity() async {
    _searchHistory.clear();
    final prefs=await SharedPreferences.getInstance();
    prefs.remove('searchHistory');
    notifyListeners();
  }
}
