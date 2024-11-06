import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: "Enter city name"),
            ),
            ElevatedButton(
              onPressed: () {
                weatherProvider.getWeather(_cityController.text);
              },
              child: Text("Get Weather"),
            ),
            weatherProvider.isLoading
                ? CircularProgressIndicator()
                : weatherProvider.weather != null
                    ? Column(
                        children: [
                          Text(
                            "Temperature: ${weatherProvider.weather!.temperature}°C",
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            "Description: ${weatherProvider.weather!.description}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    : Text("Enter a city to get weather data."),
          ],
        ),
      ),
    );
  }
}
