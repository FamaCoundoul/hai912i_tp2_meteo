// ========================================
// weather_page.dart
// Page principale de l'application météo
// ========================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../business_logic/providers/weather_provider.dart';
import '../constants/app_colors.dart';
import '../widgets/previsions_horizontal_list.dart';
import '../widgets/weather_search_field.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/weather_details_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialiser Intl pour le français
    Intl.defaultLocale = 'fr_FR';

    // Animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _searchWeather() {
    final cityName = _searchController.text.trim();
    if (cityName.isNotEmpty) {
      context.read<WeatherProvider>().fetchWeather(cityName);
      _animationController.forward(from: 0.0);
      // Masquer le clavier
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            return CustomScrollView(
              slivers: [
                // AppBar
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: AppColors.primary,
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      'Météo',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.secondary,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Contenu
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Champ de recherche
                        WeatherSearchField(
                          controller: _searchController,
                          onSearch: _searchWeather,
                        ),

                        const SizedBox(height: 24),

                        // État de chargement
                        if (weatherProvider.isLoading)
                          const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Chargement...'),
                              ],
                            ),
                          ),

                        // État d'erreur
                        if (weatherProvider.hasError)
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              margin: const EdgeInsets.only(top: 50),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.error,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: AppColors.error,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      weatherProvider.errorMessage,
                                      style: const TextStyle(
                                        color: AppColors.error,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Données météo
                        if (weatherProvider.hasData)
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              children: [
                                // Carte météo actuelle
                                CurrentWeatherCard(
                                  weather: weatherProvider.currentWeather!,
                                ),

                                const SizedBox(height: 16),

                                // Détails météo
                                WeatherDetailsCard(
                                  weather: weatherProvider.currentWeather!,
                                ),

                                const SizedBox(height: 24),

                                // Liste des prévisions horizontale
                                if (weatherProvider.forecast != null)
                                  ForecastHorizontalList(
                                    forecast: weatherProvider.forecast!,
                                  ),
                              ],
                            ),
                          ),

                        // État initial
                        if (!weatherProvider.isLoading &&
                            !weatherProvider.hasData &&
                            !weatherProvider.hasError)
                          Container(
                            margin: const EdgeInsets.only(top: 80),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 100,
                                  color: Colors.pinkAccent,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Recherchez une ville pour\nvoir la météo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}