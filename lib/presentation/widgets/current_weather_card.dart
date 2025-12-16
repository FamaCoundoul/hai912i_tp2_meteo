// ========================================
// current_weather_card.dart
// Carte affichant la météo actuelle
// ========================================

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/weather_model.dart';
import '../constants/app_colors.dart';
import '../utils/date_utils.dart' as date_utils;
import '../utils/weather_icons.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherCard({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateString = date_utils.DateUtils.formatCurrentDate(now);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.getWeatherGradient(weather.weatherMain),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.getWeatherColor(weather.weatherMain).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ville et date
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  weather.cityName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            dateString,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),

          const SizedBox(height: 32),

          // Température et icône
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Température
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.temperatureCelsius,
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weather.weatherDescription.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),

              // Icône météo depuis l'API
              CachedNetworkImage(
                imageUrl: weather.iconUrl,
                width: 120,
                height: 120,
                placeholder: (context, url) => const SizedBox(
                  width: 120,
                  height: 120,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  WeatherIcons.getIcon(weather.weatherMain),
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Min/Max
          Row(
            children: [
              Icon(
                Icons.arrow_upward,
                color: Colors.white.withOpacity(1),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                weather.tempMaxCelsius,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_downward,
                color: Colors.white.withOpacity(1),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                weather.tempMinCelsius,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}