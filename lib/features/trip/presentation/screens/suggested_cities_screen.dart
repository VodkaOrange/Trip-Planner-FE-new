import 'dart:ui';
import 'package:ai_trip_planner/core/widgets/error_state_widget.dart';
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
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Finding the best cities for you...',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  );
                } else if (state is SuggestedCitiesLoaded) {
                  if (state.cities.isEmpty) {
                    return ErrorStateWidget(
                      message: 'No city suggestions found.',
                      onTryAgain: () {
                        context
                            .read<SuggestedCitiesBloc>()
                            .add(GetSuggestedCities(preferences));
                      },
                       icon: Icons.location_city_outlined,
                       iconColor: Colors.white,
                       textColor: Colors.white,
                       buttonBackgroundColor: Colors.white,
                       buttonTextColor: Colors.black,
                    );
                  }
                  return _buildCityCards(context, state.cities);
                } else if (state is SuggestedCitiesError) {
                  return ErrorStateWidget(
                    message:
                        'Oops! Something went wrong.',
                    onTryAgain: () {
                      context
                          .read<SuggestedCitiesBloc>()
                          .add(GetSuggestedCities(preferences));
                    },
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    buttonBackgroundColor: Colors.white,
                    buttonTextColor: Colors.black,
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

  Widget _buildCityCards(
      BuildContext context, List<SuggestedCityModel> cities) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
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
      ),
    );
  }
}
