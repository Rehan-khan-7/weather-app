import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/weather_theme.dart';

class CurrentWeatherCard extends StatelessWidget {
  final Color accentColor;
  final WeatherCondition condition;

  const CurrentWeatherCard({
    super.key,
    required this.accentColor,
    required this.condition,
  });

  IconData get weatherIcon {
    switch (condition) {
      case WeatherCondition.sunny:
        return Icons.wb_sunny_rounded;

      case WeatherCondition.rainy:
        return Icons.water_drop_rounded;

      case WeatherCondition.cloudy:
        return Icons.cloud_rounded;

      case WeatherCondition.thunderstorm:
        return Icons.thunderstorm_rounded;

      case WeatherCondition.snowy:
        return Icons.ac_unit_rounded;

      case WeatherCondition.night:
        return Icons.nightlight_round;
    }
  }

  String get weatherDescription {
    switch (condition) {
      case WeatherCondition.sunny:
        return 'Mostly Sunny';

      case WeatherCondition.rainy:
        return 'Rainy';

      case WeatherCondition.cloudy:
        return 'Overcast';

      case WeatherCondition.thunderstorm:
        return 'Thunderstorm';

      case WeatherCondition.snowy:
        return 'Snowfall';

      case WeatherCondition.night:
        return 'Clear Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 35,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                weatherIcon,
                size: 90,
                color: accentColor,
              ),

              const SizedBox(height: 15),

              const Text(
                '28°C',
                style: TextStyle(
                  fontSize: 75,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),

              Text(
                weatherDescription,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'H: 30°',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(width: 25),

                  Text(
                    'L: 19°',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}