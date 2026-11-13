import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  test('JSON should convert into Weather object', () {
    Map<String, dynamic> json = {
      'city': 'Ghaziabad',
      'temperature': 28,
      'humidity': 65,
    };

    Weather weather = Weather.fromJson(json);

    expect(weather.city, 'Ghaziabad');
    expect(weather.temperature, 28.0);
    expect(weather.humidity, 65);
  });

  test('Complete API JSON should convert into WeatherResponse', () {
    final json = {
      'current': {
        'time': '2026-11-13T21:00',
        'temperature_2m': 24.5,
        'relative_humidity_2m': 65,
        'apparent_temperature': 23.8,
        'is_day': 0,
        'precipitation': 0,
        'weather_code': 2,
        'wind_speed_10m': 12.5,
      },
      'hourly': {
        'time': ['2026-11-13T21:00', '2026-11-13T22:00'],
        'temperature_2m': [24.5, 23.8],
        'relative_humidity_2m': [65, 68],
        'precipitation_probability': [10, 15],
        'weather_code': [2, 3],
      },
    };

    final weather = WeatherResponse.fromJson(json);

    // Current weather checks
    expect(weather.current.temperature, 24.5);
    expect(weather.current.humidity, 65);
    expect(weather.current.isDay, false);

    // Hourly weather checks
    expect(weather.hourly.length, 2);
    expect(weather.hourly[0].temperature, 24.5);
    expect(weather.hourly[1].temperature, 23.8);
    expect(weather.hourly[1].humidity, 68);
  });

  test('Invalid hourly data should throw FormatException', () {
    final json = {
      'current': {
        'time': '2026-11-13T21:00',
        'temperature_2m': 24.5,
        'relative_humidity_2m': 65,
        'apparent_temperature': 23.8,
        'is_day': 0,
        'precipitation': 0,
        'weather_code': 2,
        'wind_speed_10m': 12.5,
      },
      'hourly': {
        'time': ['2026-11-13T21:00', '2026-11-13T22:00'],
        'temperature_2m': [24.5],
        'relative_humidity_2m': [65, 68],
        'precipitation_probability': [10, 15],
        'weather_code': [2, 3],
      },
    };

    expect(() => WeatherResponse.fromJson(json), throwsFormatException);
  });
}
