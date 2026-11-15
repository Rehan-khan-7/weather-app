import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_api_service.dart';
import '../services/location_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApiService _weatherApiService = WeatherApiService();
  final LocationService _locationService = LocationService();
  WeatherResponse? _weatherData;
  String? _locationName;

  bool _isLoading = false;

  String? _error;

  WeatherResponse? get weatherData => _weatherData;

  bool get isLoading => _isLoading;

  String? get error => _error;
  String? get locationName => _locationName;

  Future<void> fetchWeather() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      // Step 1: Get GPS coordinates.
      final position = await _locationService.getCurrentLocation();

      // Step 2: Fetch weather using coordinates.
      _weatherData = await _weatherApiService.fetchWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // Step 3: Convert coordinates into a readable location.
      try {
        _locationName = await _locationService.getLocationName(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      } catch (e) {
        debugPrint('Reverse geocoding error: $e');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
