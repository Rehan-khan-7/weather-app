class Weather {
  final String city;
  final double temperature;
  final int humidity;

  Weather({
    required this.city,
    required this.temperature,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['city'],
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
    );
  }
}

class CurrentWeather {
  final DateTime time;
  final double temperature;
  final int humidity;
  final double apparentTemperature;
  final bool isDay;
  final double precipitation;
  final int weatherCode;
  final double windSpeed;

  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.apparentTemperature,
    required this.isDay,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: DateTime.parse(json['time']),
      temperature: (json['temperature_2m'] as num).toDouble(),
      humidity: (json['relative_humidity_2m'] as num).toInt(),
      apparentTemperature: (json['apparent_temperature'] as num).toDouble(),
      isDay: json['is_day'] == 1,
      precipitation: (json['precipitation'] as num).toDouble(),
      weatherCode: (json['weather_code'] as num).toInt(),
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
    );
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final int humidity;
  final int precipitationProbability;
  final int weatherCode;
  final bool isDay;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.precipitationProbability,
    required this.weatherCode,
    required this.isDay,
  });
}

class WeatherResponse {
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  WeatherResponse({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    // Current weather parse karna
    final currentWeather = CurrentWeather.fromJson(
      json['current'] as Map<String, dynamic>,
    );

    // Hourly data extract karna
    final hourlyJson = json['hourly'] as Map<String, dynamic>;

    final times = hourlyJson['time'] as List<dynamic>;
    final temperatures = hourlyJson['temperature_2m'] as List<dynamic>;
    final humidities = hourlyJson['relative_humidity_2m'] as List<dynamic>;
    final rainProbabilities =
        hourlyJson['precipitation_probability'] as List<dynamic>;
    final weatherCodes = hourlyJson['weather_code'] as List<dynamic>;
    final dayStatus = hourlyJson['is_day'] as List<dynamic>;

    if (times.length != temperatures.length ||
        times.length != humidities.length ||
        times.length != rainProbabilities.length ||
        times.length != dayStatus.length ||
        times.length != weatherCodes.length) {
      throw FormatException('Invalid hourly weather data');
    }

    // Parallel arrays ko objects ki list mein convert karna
    final hourlyWeather = List.generate(times.length, (i) {
      return HourlyWeather(
        time: DateTime.parse(times[i] as String),
        temperature: (temperatures[i] as num).toDouble(),
        humidity: (humidities[i] as num).toInt(),
        precipitationProbability: (rainProbabilities[i] as num).toInt(),
        weatherCode: (weatherCodes[i] as num).toInt(),
        isDay: (dayStatus[i] as num).toInt() == 1,
      );
    });

    final dailyJson = json['daily'] as Map<String, dynamic>;

    final dates = dailyJson['time'] as List<dynamic>;
    final maxTemps = dailyJson['temperature_2m_max'] as List<dynamic>;
    final minTemps = dailyJson['temperature_2m_min'] as List<dynamic>;
    final dailyCodes = dailyJson['weather_code'] as List<dynamic>;

    if (dates.length != maxTemps.length ||
        dates.length != minTemps.length ||
        dates.length != dailyCodes.length) {
      throw FormatException('Invalid daily weather data');
    }

    final dailyWeather = List.generate(dates.length, (i) {
      return DailyWeather(
        date: DateTime.parse(dates[i] as String),
        maxTemperature: (maxTemps[i] as num).toDouble(),
        minTemperature: (minTemps[i] as num).toDouble(),
        weatherCode: (dailyCodes[i] as num).toInt(),
      );
    });

    return WeatherResponse(current: currentWeather, hourly: hourlyWeather , daily: dailyWeather,);
  }
}

class DailyWeather {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;

  DailyWeather({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherCode,
  });
}
