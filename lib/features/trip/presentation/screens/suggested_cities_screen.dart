import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(
          child:
              BlocBuilder<SuggestedCitiesBloc, SuggestedCitiesState>(
            builder: (context, state) {
              if (state is SuggestedCitiesLoading) {
                return const CircularProgressIndicator();
              } else if (state is SuggestedCitiesLoaded) {
                return _buildCityCards(context, state.cities);
              } else if (state is SuggestedCitiesError) {
                return Text(state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCityCards(
      BuildContext context, List<dynamic> cities) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return Transform.rotate(
            angle: (index % 2 == 0 ? -1 : 1) * (math.pi / 20),
            child: HearthstoneCard(
              imageUrl: city.imageUrl,
              title: city.city,
              description: city.overview,
              onTap: () {
                Navigator.of(context).pop(city.city);
              },
            ),
          );
        },
      ),
    );
  }
}
