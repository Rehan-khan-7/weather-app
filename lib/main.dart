import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'theme/weather_theme.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  // Currently selected weather condition
  WeatherCondition _condition = WeatherCondition.sunny;

  void changeWeather(WeatherCondition condition) {
    setState(() {
      _condition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme according to selected condition
    final weather = WeatherThemes.getTheme(_condition);

    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather',
      
        theme: AppTheme.buildTheme(weather),
      
        home: HomeScreen(
          weather: weather,
          condition: _condition,
          onConditionChanged: changeWeather,
        ),
      ),
    );
  }
}
