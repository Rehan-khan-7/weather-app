import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'theme/weather_theme.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          final currentWeather = weatherProvider.weatherData?.current;

          // API data available hone par actual condition use hogi.
          // API data aane tak sunny default rahega.
          final condition = currentWeather != null
              ? WeatherThemes.getCondition(
                  currentWeather.weatherCode,
                  currentWeather.isDay,
                )
              : WeatherCondition.sunny;

          final weather = WeatherThemes.getTheme(condition);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather',
            theme: AppTheme.buildTheme(weather),
            home: HomeScreen(
              weather: weather,
              condition: condition,
              onConditionChanged: (_) {},
            ),
          );
        },
      ),
    );
  }
}