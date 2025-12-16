// ========================================
// app_colors.dart
// Couleurs et styles de l'application météo
// ========================================

import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales
  static const Color primary = Color(0xFF5C6BC0);
  static const Color secondary = Color(0xFF7E57C2);
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;

  // Couleurs météo
  static const Color sunny = Color(0xFFFFB74D);
  static const Color cloudy = Color(0xFF90A4AE);
  static const Color rainy = Color(0xFF5C6BC0);
  static const Color snowy = Color(0xFFB0BEC5);

  // Couleurs d'état
  static const Color success = Color(0xFF66BB6A);
  static const Color error = Color(0xFFEF5350);
  static const Color warning = Color(0xFFFF9800);

  // Texte
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;

  // Obtenir la couleur selon la météo
  static Color getWeatherColor(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return sunny;
      case 'clouds':
        return cloudy;
      case 'rain':
      case 'drizzle':
      case 'thunderstorm':
        return rainy;
      case 'snow':
        return snowy;
      default:
        return primary;
    }
  }

  // Gradient selon la météo
  static LinearGradient getWeatherGradient(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD54F), Color(0xFFFFB74D)],
        );
      case 'clouds':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF90A4AE), Color(0xFF78909C)],
        );
      case 'rain':
      case 'drizzle':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5C6BC0), Color(0xFF3F51B5)],
        );
      case 'snow':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
        );
      case 'thunderstorm':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF455A64), Color(0xFF37474F)],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5C6BC0), Color(0xFF7E57C2)],
        );
    }
  }
}

// Styles de texte
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle temperature = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );

  static const TextStyle temperatureSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}