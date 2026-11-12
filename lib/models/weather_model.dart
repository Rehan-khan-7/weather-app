class Weather {
  final String city;
  final double temperature;
  final int humidity;

  Weather({
    required this.city,
    required this.temperature,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['city'],
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
    );
  }
}