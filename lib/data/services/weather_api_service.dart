// ========================================
// weather_api_service.dart
// Service pour les appels API OpenWeatherMap
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherApiService {
  // ⚠️ IMPORTANT : Remplacez par votre propre clé API
  // Obtenir une clé sur : https://openweathermap.org/api
  static const String _apiKey = '1aa5880b9707dbe0be140948e30ea7a1';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  // Obtenir la météo actuelle pour une ville
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric&lang=fr',
      );

      print('Fetching weather for: $cityName');
      print('URL: $url');

      final response = await http.get(url);

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Response: $jsonData');
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Ville non trouvée. Vérifiez l\'orthographe.');
      } else if (response.statusCode == 401) {
        throw Exception('Clé API invalide. Vérifiez votre clé API.');
      } else {
        throw Exception('Erreur lors de la récupération des données: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getCurrentWeather: $e');
      throw Exception('Erreur: $e');
    }
  }

  // Obtenir les prévisions pour 5 jours
  Future<PrevisionsModel> getForecast(String cityName) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric&lang=fr',
      );

      print('Fetching forecast for: $cityName');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return PrevisionsModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Ville non trouvée. Vérifiez l\'orthographe.');
      } else if (response.statusCode == 401) {
        throw Exception('Clé API invalide. Vérifiez votre clé API.');
      } else {
        throw Exception('Erreur lors de la récupération des prévisions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getForecast: $e');
      throw Exception('Erreur: $e');
    }
  }

  // Obtenir la météo ET les prévisions en une seule fois
  Future<Map<String, dynamic>> getWeatherAndForecast(String cityName) async {
    try {
      final weather = await getCurrentWeather(cityName);
      final forecast = await getForecast(cityName);

      return {
        'weather': weather,
        'forecast': forecast,
      };
    } catch (e) {
      throw Exception('Erreur lors de la récupération des données: $e');
    }
  }
}