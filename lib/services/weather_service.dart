import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  final String baseUrl= 'http://api.weatherapi.com/v1';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/current.json?key=${dotenv.env['WEATHER_API_KEY']}&q=$city&aqi=no'));
  
  if (response.statusCode==200){
    return Weather.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to load weather');
  }
  }
}