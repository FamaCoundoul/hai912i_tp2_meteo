// ========================================
// weather_details_card.dart
// Carte avec détails météo (humidité, vent, pression)
// ========================================

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/weather_model.dart';
import '../constants/app_colors.dart';

class WeatherDetailsCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailsCard({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Humidité
          _buildDetailItem(
            icon: FontAwesomeIcons.droplet,
            label: 'Humidité',
            value: '${weather.humidity}%',
            color: AppColors.rainy,
          ),

          // Divider
          Container(
            height: 50,
            width: 1,
            color: Colors.grey.shade300,
          ),

          // Vent
          _buildDetailItem(
            icon: FontAwesomeIcons.wind,
            label: 'Vent',
            value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
            color: AppColors.cloudy,
          ),

          // Divider
          Container(
            height: 50,
            width: 1,
            color: Colors.grey.shade300,
          ),

          // Pression
          _buildDetailItem(
            icon: FontAwesomeIcons.gaugeHigh,
            label: 'Pression',
            value: '${weather.pressure} hPa',
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(
            icon,
            size: 24,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}