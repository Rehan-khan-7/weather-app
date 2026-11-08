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

  static WeatherThemeData getTheme(
      WeatherCondition condition) {

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