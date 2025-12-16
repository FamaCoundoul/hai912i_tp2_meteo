// ========================================
// weather_icons.dart
// Icônes météo avec Font Awesome
// ========================================

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherIcons {
  // Obtenir l'icône selon la description météo
  static IconData getIcon(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return FontAwesomeIcons.sun;
      case 'clouds':
        return FontAwesomeIcons.cloud;
      case 'rain':
        return FontAwesomeIcons.cloudRain;
      case 'drizzle':
        return FontAwesomeIcons.cloudRain;
      case 'thunderstorm':
        return FontAwesomeIcons.cloudBolt;
      case 'snow':
        return FontAwesomeIcons.snowflake;
      case 'mist':
      case 'fog':
      case 'haze':
        return FontAwesomeIcons.smog;
      default:
        return FontAwesomeIcons.cloud;
    }
  }

  // Icônes pour les informations météo
  static const IconData temperature = FontAwesomeIcons.temperatureHalf;
  static const IconData humidity = FontAwesomeIcons.droplet;
  static const IconData wind = FontAwesomeIcons.wind;
  static const IconData pressure = FontAwesomeIcons.gaugeHigh;
  static const IconData location = FontAwesomeIcons.locationDot;
  static const IconData calendar = FontAwesomeIcons.calendar;
  static const IconData clock = FontAwesomeIcons.clock;
}