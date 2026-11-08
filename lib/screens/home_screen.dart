import 'package:flutter/material.dart';

import '../widgets/weather_header.dart';
import '../theme/weather_theme.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/weather_stat_card.dart';
import '../animations/sunny_animation.dart';
import '../animations/cloud_animation.dart';

class HomeScreen extends StatelessWidget {
  final WeatherThemeData weather;

  const HomeScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: weather.backgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              //Background sun
              Positioned(
                top: -75,
                right: -80,

                child: IgnorePointer(child: SunnyAnimation()),
              ),
              //clouds
              Positioned(
                top: 80,
                left: -20,
                child: IgnorePointer(child: CloudAnimation()),
              ),
              
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeatherHeader(location: 'Ghaziabad, India'),

                    const SizedBox(height: 35),

                    // Current Temperature
                    CurrentWeatherCard(accentColor: weather.accentColor),

                    const SizedBox(height: 35),

                    // Hourly Forecast Heading
                    const HourlyForecast(),

                    const SizedBox(height: 35),

                    const Text(
                      'Weather Details',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                      children: [
                        WeatherStatCard(
                          title: 'Humidity',
                          value: '65%',
                          icon: Icons.water_drop_outlined,
                          accentColor: weather.accentColor,
                        ),
                        WeatherStatCard(
                          title: 'Wind Speed',
                          value: '12 km/h',
                          icon: Icons.air,
                          accentColor: weather.accentColor,
                        ),
                        WeatherStatCard(
                          title: 'UV Index',
                          value: '5',
                          icon: Icons.wb_sunny_outlined,
                          accentColor: weather.accentColor,
                        ),
                        WeatherStatCard(
                          title: 'Visibility',
                          value: '10 km',
                          icon: Icons.visibility_outlined,
                          accentColor: weather.accentColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
