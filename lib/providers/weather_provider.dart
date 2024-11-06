import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  final WeatherService _weatherService = WeatherService();

  Future<void> getWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
    } catch (e) {
      print("Error fetching weather: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
