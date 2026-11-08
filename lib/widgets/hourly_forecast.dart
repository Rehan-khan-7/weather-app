// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  final List<Map<String, dynamic>> forecast = const [
    {'time': 'Now', 'icon': Icons.wb_sunny, 'temp': '28°'},
    {'time': '3 PM', 'icon': Icons.wb_sunny, 'temp': '29°'},
    {'time': '4 PM', 'icon': Icons.cloud, 'temp': '27°'},
    {'time': '5 PM', 'icon': Icons.cloudy_snowing, 'temp': '25°'},
    {'time': '6 PM', 'icon': Icons.nightlight, 'temp': '23°'},
    {'time': '7 PM', 'icon': Icons.nightlight, 'temp': '22°'},
  ];

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item['time'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    Icon(
                      item['icon'],
                      color: Colors.orangeAccent,
                      size: 27,
                    ),

                    Text(
                      item['temp'],
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