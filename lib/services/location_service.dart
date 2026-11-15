import 'package:geolocator/geolocator.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Check whether location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permission.
    LocationPermission permission = await Geolocator.checkPermission();

    // Request permission if denied.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Handle denied permission.
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }

    // Handle permanently denied permission.
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied. Enable it in settings.',
      );
    }

    // Get current position.
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getLocationName({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.https('nominatim.openstreetmap.org', '/reverse', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'format': 'jsonv2',
      'addressdetails': '1',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final address = data['address'];

      final city =
          address['city'] ??
          address['town'] ??
          address['village'] ??
          address['municipality'] ??
          address['county'];

      final state = address['state'];
      final country = address['country'];

      return [city, state, country]
          .where((value) => value != null && value.toString().isNotEmpty)
          .join(', ');
    } else {
      throw Exception('Failed to fetch location name');
    }
  }
}
