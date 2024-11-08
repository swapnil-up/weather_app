import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/favorites_provider.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:weather_app/providers/search_history_provider.dart';
import 'package:weather_app/screens/favorites_screen.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: "Enter city name"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    favoritesProvider.addFavoriteCity(_cityController.text),
                  },
                  child: Text('Add to Favorites'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(),
                      ),
                    ).then((selectedCity) {
                      _cityController.text = selectedCity;
                      locationProvider.setCity(_cityController.text);
                      weatherProvider.getWeather(_cityController.text);
                    });
                  },
                  child: Text("See Favorites"),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text('Recent Searches:'),
                ElevatedButton(
                  onPressed: () {
                    searchHistoryProvider.removeFavoriteCity();
                  },
                  child: const Text('Clear recents'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: searchHistoryProvider.searchHistory.map((city) {
                  return ListTile(
                    title: Text(city),
                    onTap: () {
                      weatherProvider.getWeather(city);
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                locationProvider.setCity(_cityController.text);
                searchHistoryProvider.addSearchCity(_cityController.text);
                weatherProvider.getWeather(_cityController.text);
              },
              child: const Text("Get Weather"),
            ),
            weatherProvider.isLoading
                ? const CircularProgressIndicator()
                : weatherProvider.weather != null
                    ? Column(
                        children: [
                          Text(
                            "Temperature: ${weatherProvider.weather!.temperature}°C",
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            "Description: ${weatherProvider.weather!.description}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    : const Text("Enter a city to get weather data."),
          ],
        ),
      ),
    );
  }
}
