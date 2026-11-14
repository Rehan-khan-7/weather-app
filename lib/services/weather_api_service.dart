import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherApiService {
  Future<WeatherResponse> fetchWeather() async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=28.67'
      '&longitude=77.45'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,wind_speed_10m'
      '&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code'
      '&timezone=auto',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherResponse.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
