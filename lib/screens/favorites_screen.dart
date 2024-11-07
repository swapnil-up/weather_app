import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/favorites_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Cities")),
      body: ListView(
        children: favoritesProvider.favoriteCities
            .map((city) => ListTile(
                  title: Text(city),
                  onTap: (){
                    Navigator.pop(context,city);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      favoritesProvider.removeFavoriteCity(city);
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
