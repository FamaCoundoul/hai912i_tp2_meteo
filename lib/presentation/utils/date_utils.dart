
// ========================================
// date_utils.dart
// Utilitaires pour formater les dates
// ========================================

import 'package:intl/intl.dart';

class DateUtils {
  // Formater la date actuelle
  static String formatCurrentDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'fr_FR').format(date);
  }

  // Formater l'heure
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  // Jour de la semaine
  static String getDayOfWeek(DateTime date) {
    return DateFormat('EEEE', 'fr_FR').format(date);
  }

  // Jour de la semaine court
  static String getShortDayOfWeek(DateTime date) {
    return DateFormat('EEE', 'fr_FR').format(date);
  }

  // Date courte
  static String getShortDate(DateTime date) {
    return DateFormat('d MMM', 'fr_FR').format(date);
  }

  // Depuis timestamp
  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  // Formater depuis timestamp
  static String formatFromTimestamp(int timestamp) {
    final date = fromTimestamp(timestamp);
    return formatCurrentDate(date);
  }

  // Jour de la semaine depuis timestamp
  static String getDayFromTimestamp(int timestamp) {
    final date = fromTimestamp(timestamp);
    return getShortDayOfWeek(date);
  }
}