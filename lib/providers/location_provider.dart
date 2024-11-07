import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  String _currentCity = "";
  String get currentCity => _currentCity;

  void setCity(String city) {
    _currentCity = city;
    notifyListeners();
  }
}
