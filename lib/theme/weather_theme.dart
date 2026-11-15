import 'package:flutter/material.dart';

enum WeatherCondition {
  sunny,
  rainy,
  cloudy,
  thunderstorm,
  snowy,
  night,
}

class WeatherThemeData {
  final List<Color> backgroundGradient;
  final Color accentColor;

  const WeatherThemeData({
    required this.backgroundGradient,
    required this.accentColor,
  });
}

class WeatherThemes {
  // API weather code ko WeatherCondition mein convert karta hai.
  static WeatherCondition getCondition(int weatherCode, bool isDay) {
    // Night
    if (!isDay && weatherCode <= 3) {
      return WeatherCondition.night;
    }

    // Sunny
    if (weatherCode == 0) {
      return WeatherCondition.sunny;
    }

    // Cloudy and fog
    if ([1, 2, 3, 45, 48].contains(weatherCode)) {
      return WeatherCondition.cloudy;
    }

    // Rain
    if ((weatherCode >= 51 && weatherCode <= 67) ||
        (weatherCode >= 80 && weatherCode <= 82)) {
      return WeatherCondition.rainy;
    }

    // Snow
    if ((weatherCode >= 71 && weatherCode <= 77) ||
        (weatherCode >= 85 && weatherCode <= 86)) {
      return WeatherCondition.snowy;
    }

    // Thunderstorm
    if (weatherCode >= 95 && weatherCode <= 99) {
      return WeatherCondition.thunderstorm;
    }

    return WeatherCondition.cloudy;
  }

  // WeatherCondition ke according theme return karta hai.
  static WeatherThemeData getTheme(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return const WeatherThemeData(
          backgroundGradient: [
            Color(0xFF14213D),
            Color(0xFF243B55),
          ],
          accentColor: Color(0xFFFFB347),
        );

      case WeatherCondition.rainy:
        return const WeatherThemeData(
          backgroundGradient: [
            Color(0xFF101820),
            Color(0xFF243B55),
          ],
          accentColor: Color(0xFF64B5F6),
        );

      case WeatherCondition.cloudy:
        return const WeatherThemeData(
          backgroundGradient: [
            Color(0xFF232526),
            Color(0xFF414345),
          ],
          accentColor: Color(0xFF90A4AE),
        );

      case WeatherCondition.thunderstorm:
        return const WeatherThemeData(
          backgroundGradient: [
            Color(0xFF141E30),
            Color(0xFF35204A),
          ],
          accentColor: Color(0xFFCE93D8),
        );

      case WeatherCondition.snowy:
        return const WeatherThemeData(
          backgroundGradient: [
            Color(0xFF16222A),
            Color(0xFF3A6073),
          ],
          accentColor: Color(0xFF80DEEA),
        );

      case WeatherCondition.night:
        return const WeatherThemeData(
          backgroundGradient: [
            Color(0xFF0F0C29),
            Color(0xFF302B63),
          ],
          accentColor: Color(0xFFB39DDB),
        );
    }
  }
}