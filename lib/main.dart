import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'theme/weather_theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {

    final weather = WeatherThemes.getTheme(
      WeatherCondition.sunny,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',

      theme: AppTheme.buildTheme(weather),

      home: HomeScreen(
        weather: weather,
      ),
    );
  }
}