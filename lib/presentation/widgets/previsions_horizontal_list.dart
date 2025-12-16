// ========================================
// forecast_horizontal_list.dart
// Liste horizontale déroulante de prévisions
// ========================================

import 'package:flutter/material.dart';
import 'package:hai912i_tp2_meteo/presentation/widgets/previsions_card_horizontal.dart';
import '../../data/models/weather_model.dart';

class ForecastHorizontalList extends StatelessWidget {
  final PrevisionsModel forecast;

  const ForecastHorizontalList({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyForecasts = forecast.getDailyForecasts();
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4;
    final listHeight = cardWidth * 1.6; // Même hauteur que les cartes

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Prévisions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Liste horizontale responsive
        SizedBox(
          height: listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: dailyForecasts.length,
            itemBuilder: (context, index) {
              return ForecastCardHorizontal(
                forecast: dailyForecasts[index],
              );
            },
          ),
        ),
      ],
    );
  }
}