import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/weather_theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Temporary condition for testing
    final weather = WeatherThemes.getTheme(
      WeatherCondition.night,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Weather',

      theme: AppTheme.buildTheme(weather),

      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: weather.backgroundGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wb_sunny,
                  size: 80,
                  color: Colors.orange,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Weather',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Dynamic Weather Theme',
                  style: TextStyle(
                    color: weather.accentColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}