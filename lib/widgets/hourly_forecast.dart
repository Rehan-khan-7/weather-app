import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather_model.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeather> hourly;
  final DateTime? currentTime;

  const HourlyForecast({
    super.key,
    required this.hourly,
    required this.currentTime,
  });

  IconData getWeatherIcon(int code, bool isDay) {
    if (code == 0) {
      return isDay ? Icons.wb_sunny_rounded : Icons.nightlight_round;
    } else if (code <= 2) {
      return isDay ? Icons.wb_cloudy_rounded : Icons.nights_stay_rounded;
    } else if (code == 3 || (code >= 45 && code <= 48)) {
      return Icons.cloud_rounded;
    } else if (code >= 51 && code <= 67) {
      return Icons.grain_rounded;
    } else if (code >= 71 && code <= 77) {
      return Icons.ac_unit_rounded;
    } else if (code >= 80 && code <= 82) {
      return Icons.water_drop_rounded;
    } else if (code >= 95) {
      return Icons.thunderstorm_rounded;
    }

    return Icons.cloud_rounded;
  }

  @override
  Widget build(BuildContext context) {
    if (hourly.isEmpty || currentTime == null) {
      return const SizedBox.shrink();
    }

    // Current hour se forecast start karna
    final startIndex = hourly.indexWhere(
      (item) => !item.time.isBefore(currentTime!),
    );

    final forecast = hourly
        .skip(startIndex == -1 ? 0 : startIndex)
        .take(6)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hourly Forecast',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          height: 145,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final item = forecast[index];

              return Container(
                width: 85,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      index == 0 ? 'Now' : DateFormat('h a').format(item.time),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    Icon(
                      getWeatherIcon(item.weatherCode, item.isDay),
                      color: item.isDay ? Colors.orangeAccent : Colors.white70,
                      size: 27,
                    ),

                    Text(
                      '${item.temperature.round()}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
