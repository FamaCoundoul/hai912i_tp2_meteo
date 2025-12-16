// ========================================
// weather_model.dart
// Modèle de données pour la météo
// ========================================

class WeatherModel {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final String weatherDescription;
  final String weatherMain;
  final String icon;
  final int timestamp;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.weatherDescription,
    required this.weatherMain,
    required this.icon,
    required this.timestamp,
  });

  // Factory pour créer depuis JSON (API actuelle)
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      pressure: json['main']['pressure'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      weatherDescription: json['weather'][0]['description'] ?? '',
      weatherMain: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      timestamp: json['dt'] ?? 0,
    );
  }

  // Température en Celsius (l'API retourne en Kelvin par défaut avec units=metric)
  String get temperatureCelsius => '${temperature.toStringAsFixed(0)}°C';

  String get tempMinCelsius => '${tempMin.toStringAsFixed(0)}°';

  String get tempMaxCelsius => '${tempMax.toStringAsFixed(0)}°';

  // URL de l'icône météo
  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}

// Modèle pour les prévisions
class PrevisionsModel {
  final List<WeatherForecast> forecasts;

  PrevisionsModel({required this.forecasts});

  factory PrevisionsModel.fromJson(Map<String, dynamic> json) {
    List<WeatherForecast> forecastList = [];

    if (json['list'] != null) {
      for (var item in json['list']) {
        forecastList.add(WeatherForecast.fromJson(item));
      }
    }

    return PrevisionsModel(forecasts: forecastList);
  }

  // Obtenir les prévisions par jour (une prévision par jour)
  List<WeatherForecast> getDailyForecasts() {
    Map<String, WeatherForecast> dailyMap = {};

    for (var forecast in forecasts) {
      String date = forecast.dateString;
      if (!dailyMap.containsKey(date)) {
        dailyMap[date] = forecast;
      }
    }

    return dailyMap.values.take(5).toList();
  }
}

class WeatherForecast {
  final double temperature;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final String weatherDescription;
  final String weatherMain;
  final String icon;
  final int timestamp;

  WeatherForecast({
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.weatherDescription,
    required this.weatherMain,
    required this.icon,
    required this.timestamp,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      temperature: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      weatherDescription: json['weather'][0]['description'] ?? '',
      weatherMain: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      timestamp: json['dt'] ?? 0,
    );
  }

  String get temperatureCelsius => '${temperature.toStringAsFixed(0)}°C';

  String get tempMinCelsius => '${tempMin.toStringAsFixed(0)}°';

  String get tempMaxCelsius => '${tempMax.toStringAsFixed(0)}°';

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  // Date formatée (jour de la semaine)
  String get dateString {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}