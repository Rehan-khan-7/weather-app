import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApiService _weatherApiService = WeatherApiService();

  WeatherResponse? _weatherData;

  bool _isLoading = false;

  String? _error;

  WeatherResponse? get weatherData => _weatherData;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchWeather() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      _weatherData = await _weatherApiService.fetchWeather();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }
}