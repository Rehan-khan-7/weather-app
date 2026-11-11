import 'package:flutter/material.dart';

import '../widgets/weather_header.dart';
import '../theme/weather_theme.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/weather_stat_card.dart';
import '../animations/sunny_animation.dart';
import '../animations/cloud_animation.dart';
import '../animations/rainy_animation.dart';
import '../animations/cloudy_animation.dart';
import '../animations/thunderstorm_cloud_animation.dart';
import '../animations/lightning_animation.dart';
import '../animations/rainy_cloud_animation.dart';
import '../animations/snow_animation.dart';

class HomeScreen extends StatelessWidget {
  final WeatherThemeData weather;
  final WeatherCondition condition;
  final ValueChanged<WeatherCondition> onConditionChanged;

  const HomeScreen({
    super.key,
    required this.weather,
    required this.condition,
    required this.onConditionChanged,
  });

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
              // Rainy and Thunderstorm
              // Rainy Weather
              if (condition == WeatherCondition.rainy) ...[
                // Existing diagonal rain
                const Positioned.fill(
                  child: IgnorePointer(child: RainyAnimation()),
                ),

                // New rainy clouds
                Positioned(
                  top: -10,
                  left: -20,
                  right: -20,
                  child: IgnorePointer(child: RainyCloudAnimation()),
                ),
              ],

              // Thunderstorm Weather
              if (condition == WeatherCondition.thunderstorm) ...[
                const Positioned.fill(
                  child: IgnorePointer(child: RainyAnimation()),
                ),

                Positioned(
                  top: -30,
                  left: -30,
                  right: -30,
                  child: IgnorePointer(child: ThunderstormCloudAnimation()),
                ),

                // Lightning layer
                const Positioned.fill(child: LightningAnimation()),
              ]
              // Sunny
              else if (condition == WeatherCondition.sunny) ...[
                Positioned(
                  top: -75,
                  right: -80,
                  child: IgnorePointer(child: SunnyAnimation()),
                ),

                Positioned(
                  top: 80,
                  left: -20,
                  child: IgnorePointer(child: CloudAnimation()),
                ),
              ]
              // Cloudy
              else if (condition == WeatherCondition.cloudy) ...[
                Positioned(
                  top: -40,
                  left: -40,
                  right: -40,
                  child: IgnorePointer(child: CloudyAnimation()),
                ),
              ],

              if (condition == WeatherCondition.snowy) ...[
                const Positioned.fill(
                  child: IgnorePointer(child: SnowAnimation()),
                ),
              ],

              SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeatherHeader(location: 'Ghaziabad, India'),

                    _buildWeatherSelector(),

                    const SizedBox(height: 35),

                    // Current Temperature
                    CurrentWeatherCard(
                      accentColor: weather.accentColor,
                      condition: condition,
                    ),

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

  Widget _buildWeatherSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<WeatherCondition>(
          value: condition,
          isExpanded: true,
          dropdownColor: const Color(0xFF243B55),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          items: WeatherCondition.values.map((weatherCondition) {
            return DropdownMenuItem(
              value: weatherCondition,
              child: Text(weatherCondition.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (newCondition) {
            if (newCondition != null) {
              onConditionChanged(newCondition);
            }
          },
        ),
      ),
    );
  }
}
