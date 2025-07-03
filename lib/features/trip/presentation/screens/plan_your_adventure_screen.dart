import 'package:ai_trip_planner/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/plan_your_adventure_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/plan_your_adventure_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/plan_your_adventure_state.dart';
import 'package:ai_trip_planner/features/trip/presentation/screens/suggested_cities_screen.dart';
import 'package:ai_trip_planner/features/trip/presentation/screens/trip_details_screen.dart';
import 'package:ai_trip_planner/injection_container.dart';

class PlanYourAdventureScreen extends StatelessWidget {
  const PlanYourAdventureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PlanYourAdventureBloc>(),
      child: Scaffold(
        // The AppBar has been removed to eliminate the double title.
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0), // Added top padding
          child: BlocBuilder<PlanYourAdventureBloc, PlanYourAdventureState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plan Your Adventure',
                             style: Theme.of(context)
                                .textTheme
                                .headlineMedium // Use a more prominent style
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Choose your dream activities and let us plan the perfect trip!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 24),
                          _buildActivityGrid(context, state),
                          const SizedBox(height: 24),
                          _buildDestinationSelection(context, state),
                        ],
                      ),
                    ),
                  ),
                  _buildNextButton(context, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActivityGrid(
      BuildContext context, PlanYourAdventureState state) {
    final activities = [
      {'icon': Icons.hiking, 'label': 'Hiking'},
      {'icon': Icons.beach_access, 'label': 'Beach'},
      {'icon': Icons.museum, 'label': 'Museums'},
      {'icon': Icons.restaurant, 'label': 'Food Tours'},
      {'icon': Icons.nightlife, 'label': 'Nightlife'},
      {'icon': Icons.snowboarding, 'label': 'Skiing'},
      {'icon': Icons.pets, 'label': 'Wildlife'},
      {'icon': Icons.account_balance, 'label': 'Historical Sites'},
    ];

    // No longer needs a fixed height or a SizedBox
    return GridView.builder(
      shrinkWrap: true, // Important for nested scrolling
      physics:
          const NeverScrollableScrollPhysics(), // Parent handles scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        final label = activity['label'] as String;
        final isSelected = state.selectedActivities.contains(label);

        return GestureDetector(
          onTap: () {
            if (isSelected) {
              context
                  .read<PlanYourAdventureBloc>()
                  .add(DeselectActivity(label));
            } else {
              context
                  .read<PlanYourAdventureBloc>()
                  .add(SelectActivity(label));
            }
          },
          child: Card(
            elevation: isSelected ? 8 : 2,
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.8)
                : AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  activity['icon'] as IconData,
                  size: 35,
                  color: isSelected ? AppColors.white : AppColors.black,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? AppColors.white : AppColors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDestinationSelection(
      BuildContext context, PlanYourAdventureState state) {
    final cities = [
      '—', // Represents the default, unselected state
      'Paris',
      'Tokyo',
      'Cape Town',
      'Rio de Janeiro',
      'Rome',
      'Bali',
      'New York City',
      'London',
      'Sydney',
      'Dubai'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: state.destination ?? '—',
          decoration: const InputDecoration(
            labelText: 'Choose your destination',
          ),
          items: cities.map((city) {
            return DropdownMenuItem(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: state.isAiChoice
              ? null
              : (value) {
                  final destination = value == '—' ? null : value;
                  context
                      .read<PlanYourAdventureBloc>()
                      .add(SelectDestination(destination));
                },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Switch(
              value: state.isAiChoice,
              onChanged: state.destination != null
                  ? null
                  : (value) {
                      context
                          .read<PlanYourAdventureBloc>()
                          .add(ToggleAiChoice(value));
                    },
            ),
            const SizedBox(width: 8),
            const Text('Let AI choose for me'),
          ],
        ),
        const Text(
          "Based on your selected activities, we'll suggest the best destination for you.",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildNextButton(
      BuildContext context, PlanYourAdventureState state) {
    final isEnabled = state.selectedActivities.isNotEmpty &&
        (state.destination != null || state.isAiChoice);

    return Center(
      child: ElevatedButton(
        onPressed: isEnabled
            ? () async {
                if (state.isAiChoice) {
                   final preferencesForApi = state.selectedActivities
                      .map((activity) => activity.toLowerCase().replaceAll(' ', '_'))
                      .toList();
                  final selectedCity = await Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, _, __) => SuggestedCitiesScreen(
                        preferences: preferencesForApi,
                      ),
                    ),
                  );

                  if (selectedCity != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TripDetailsScreen(
                          destination: selectedCity,
                          selectedActivities: state.selectedActivities,
                        ),
                      ),
                    );
                  }
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TripDetailsScreen(
                        destination: state.destination!,
                        selectedActivities: state.selectedActivities,
                      ),
                    ),
                  );
                }
              }
            : null,
        child: const Text('Next'),
      ),
    );
  }
}
