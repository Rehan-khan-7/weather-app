import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherApiService {
  Future<WeatherResponse> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,weather_code,wind_speed_10m'
      '&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,is_day'
      '&daily=weather_code,temperature_2m_max,temperature_2m_min'
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
