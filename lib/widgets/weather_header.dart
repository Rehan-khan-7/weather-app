import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  final String location;

  const WeatherHeader({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Weather',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white70,
            ),
            const SizedBox(width: 8),
            Text(
              location,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}