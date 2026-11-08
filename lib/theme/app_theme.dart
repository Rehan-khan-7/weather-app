import 'package:flutter/material.dart';
import 'weather_theme.dart';

class AppTheme {
  static ThemeData buildTheme(WeatherThemeData weather) {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      scaffoldBackgroundColor:
          weather.backgroundGradient.first,

      colorScheme: ColorScheme.fromSeed(
        seedColor: weather.accentColor,
        brightness: Brightness.dark,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}