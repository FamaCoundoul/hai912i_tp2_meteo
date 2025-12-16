// ========================================
// weather_provider.dart
// Provider pour la gestion d'état de la météo
// ========================================

import 'package:flutter/foundation.dart';
import '../../data/models/weather_model.dart';
import '../../data/services/weather_api_service.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherProvider with ChangeNotifier {
  final WeatherApiService _apiService = WeatherApiService();

  WeatherModel? _currentWeather;
  PrevisionsModel? _forecast;
  WeatherStatus _status = WeatherStatus.initial;
  String _errorMessage = '';
  String _lastSearchedCity = '';

  // Getters
  WeatherModel? get currentWeather => _currentWeather;
  PrevisionsModel? get forecast => _forecast;
  WeatherStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get lastSearchedCity => _lastSearchedCity;

  bool get isLoading => _status == WeatherStatus.loading;
  bool get hasData => _status == WeatherStatus.loaded && _currentWeather != null;
  bool get hasError => _status == WeatherStatus.error;

  // Récupérer la météo pour une ville
  Future<void> fetchWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      _status = WeatherStatus.error;
      _errorMessage = 'Veuillez entrer un nom de ville';
      notifyListeners();
      return;
    }

    _status = WeatherStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // Récupérer la météo actuelle et les prévisions
      final data = await _apiService.getWeatherAndForecast(cityName);

      _currentWeather = data['weather'];
      _forecast = data['forecast'];
      _lastSearchedCity = cityName;
      _status = WeatherStatus.loaded;
      _errorMessage = '';

      notifyListeners();
    } catch (e) {
      _status = WeatherStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _currentWeather = null;
      _forecast = null;

      notifyListeners();
    }
  }

  // Rafraîchir la météo pour la dernière ville recherchée
  Future<void> refreshWeather() async {
    if (_lastSearchedCity.isNotEmpty) {
      await fetchWeather(_lastSearchedCity);
    }
  }

  // Réinitialiser l'état
  void reset() {
    _currentWeather = null;
    _forecast = null;
    _status = WeatherStatus.initial;
    _errorMessage = '';
    _lastSearchedCity = '';
    notifyListeners();
  }
}