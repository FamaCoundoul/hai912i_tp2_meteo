// ========================================
// forecast_card_horizontal.dart
// Carte de prévision horizontale stylisée
// ========================================

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/weather_model.dart';
import '../utils/date_utils.dart' as date_utils;

class ForecastCardHorizontal extends StatelessWidget {
  final WeatherForecast forecast;

  const ForecastCardHorizontal({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  Color _getGradientColor(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return const Color(0xFFFFB74D);
      case 'clouds':
        return const Color(0xFF90A4AE);
      case 'rain':
      case 'drizzle':
        return const Color(0xFFB407EA);
      case 'thunderstorm':
        return const Color(0xFF455A64);
      case 'snow':
        return const Color(0xFFB0BEC5);
      default:
        return const Color(0xFF7E57C2);
    }
  }

  IconData _getWeatherIcon(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return FontAwesomeIcons.sun;
      case 'clouds':
        return FontAwesomeIcons.cloud;
      case 'rain':
      case 'drizzle':
        return FontAwesomeIcons.cloudRain;
      case 'thunderstorm':
        return FontAwesomeIcons.cloudBolt;
      case 'snow':
        return FontAwesomeIcons.snowflake;
      default:
        return FontAwesomeIcons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = date_utils.DateUtils.fromTimestamp(forecast.timestamp);
    final dayName = date_utils.DateUtils.getDayOfWeek(date);
    final baseColor = _getGradientColor(forecast.weatherMain);

    // Obtenir la largeur de l'écran pour rendre responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4; // 40% de la largeur de l'écran
    final cardHeight = cardWidth * 1.6; // Ratio hauteur/largeur

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor.withOpacity(0.7),
            baseColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Nuages décoratifs en bas (ajustés)
            Positioned(
              bottom: -10,
              left: -5,
              child: _buildSmallCloud(cardWidth * 0.25),
            ),
            Positioned(
              bottom: -8,
              right: -8,
              child: _buildSmallCloud(cardWidth * 0.3),
            ),

            // Contenu
            Padding(
              padding: EdgeInsets.all(cardWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Jour de la semaine
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: cardWidth * 0.11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: cardHeight * 0.02),

                  // Icône météo
                  Container(
                    padding: EdgeInsets.all(cardWidth * 0.1),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      _getWeatherIcon(forecast.weatherMain),
                      size: cardWidth * 0.25,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: cardHeight * 0.02),

                  // Températures
                  Column(
                    children: [
                      Text(
                        forecast.tempMaxCelsius,
                        style: TextStyle(
                          fontSize: cardWidth * 0.16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: cardHeight * 0.01),
                      Text(
                        forecast.tempMinCelsius,
                        style: TextStyle(
                          fontSize: cardWidth * 0.11,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: cardHeight * 0.02),

                  // Humidité et Vent
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSmallInfo(
                        FontAwesomeIcons.droplet,
                        '${forecast.humidity}%',
                        cardWidth,
                      ),
                      _buildSmallInfo(
                        FontAwesomeIcons.wind,
                        '2 mi/h',
                        cardWidth,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCloud(double size) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size * 0.5),
          topRight: Radius.circular(size * 0.5),
        ),
      ),
    );
  }

  Widget _buildSmallInfo(IconData icon, String value, double cardWidth) {
    return Column(
      children: [
        FaIcon(
          icon,
          size: cardWidth * 0.08,
          color: Colors.white.withOpacity(0.8),
        ),
        SizedBox(height: cardWidth * 0.02),
        Text(
          value,
          style: TextStyle(
            fontSize: cardWidth * 0.07,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}