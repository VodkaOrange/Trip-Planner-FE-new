import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/data/models/suggested_city_model.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/suggested_cities_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/suggested_cities_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/suggested_cities_state.dart';
import 'package:ai_trip_planner/features/trip/presentation/widgets/hearthstone_card.dart';
import 'package:ai_trip_planner/injection_container.dart';
import 'dart:math' as math;

class SuggestedCitiesScreen extends StatelessWidget {
  final List<String> preferences;

  const SuggestedCitiesScreen({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<SuggestedCitiesBloc>()..add(GetSuggestedCities(preferences)),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important for the blur effect
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: BlocBuilder<SuggestedCitiesBloc, SuggestedCitiesState>(
              builder: (context, state) {
                if (state is SuggestedCitiesLoading) {
                  return const CircularProgressIndicator(color: Colors.white);
                } else if (state is SuggestedCitiesLoaded) {
                  if (state.cities.isEmpty) {
                    return _buildErrorOrEmptyState(
                      context: context,
                      icon: Icons.location_city_outlined,
                      message: 'No city suggestions found.',
                    );
                  }
                  return _buildCityCards(context, state.cities);
                } else if (state is SuggestedCitiesError) {
                   return _buildErrorOrEmptyState(
                    context: context,
                    icon: Icons.error_outline,
                    message: 'Oops! Something went wrong. ${state.message}',
                  );
                }
                return Container(); // Should not be reached
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorOrEmptyState({
    required BuildContext context,
    required IconData icon,
    required String message,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 64),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            onPressed: () {
              context
                  .read<SuggestedCitiesBloc>()
                  .add(GetSuggestedCities(preferences));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCityCards(
      BuildContext context, List<SuggestedCityModel> cities) {
    return SizedBox(
      height: 450, // Increased height to better fit cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Transform.rotate(
              angle: (index == 0
                  ? 0
                  : (index % 2 == 0 ? -1 : 1) * (math.pi / 20)),
              child: HearthstoneCard(
                imageUrl: city.imageUrl,
                title: city.city,
                description: city.overview,
                onTap: () {
                  Navigator.of(context).pop(city.city);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
