class Weather {
  final double temperature;
  final String description;

  Weather({
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['current']['temp_c'],
      description: json['current']['condition']['text'],
    );
  }
}
