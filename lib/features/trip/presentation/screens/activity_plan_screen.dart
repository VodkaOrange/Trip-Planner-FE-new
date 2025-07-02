import 'package:ai_trip_planner/core/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_state.dart';
import 'package:ai_trip_planner/features/trip/presentation/widgets/activity_selection_modal.dart';
import 'package:ai_trip_planner/features/trip/presentation/widgets/animated_list_item.dart';
import 'package:ai_trip_planner/features/trip/presentation/widgets/login_modal.dart';
import 'package:ai_trip_planner/features/trip/presentation/screens/save_share_book_screen.dart';
import 'package:ai_trip_planner/injection_container.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ActivityPlanScreen extends StatelessWidget {
  final String destination;
  final String? departureCity;
  final int numberOfChildren;
  final int numberOfAdults;
  final String fromDate;
  final String toDate;
  final List<String> interests;

  const ActivityPlanScreen({
    super.key,
    required this.destination,
    this.departureCity,
    required this.numberOfChildren,
    required this.numberOfAdults,
    required this.fromDate,
    required this.toDate,
    required this.interests,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ActivityPlanBloc>()
        ..add(GetInitialActivityPlan(
          destination: destination,
          departureCity: departureCity,
          numberOfChildren: numberOfChildren,
          numberOfAdults: numberOfAdults,
          fromDate: fromDate,
          toDate: toDate,
          interests: interests,
        )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activity Plan'),
        ),
        body: BlocConsumer<ActivityPlanBloc, ActivityPlanState>(
          listener: (context, state) {
            if (state is ActivityPlanLoaded &&
                state.suggestedActivities != null) {
              showDialog(
                context: context,
                builder: (_) => ActivitySelectionModal(
                  activities: state.suggestedActivities!,
                  onActivitySelected: (activity) {
                    final tripId = state.itinerary.id;
                    final dayId = state.itinerary.dayPlans
                        .firstWhere((dp) => dp.canFitAnotherActivityInTheSameDay)
                        .id;
                    context
                        .read<ActivityPlanBloc>()
                        .add(SelectActivityForDay(tripId, dayId, activity));
                    Navigator.of(context).pop();
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ActivityPlanLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActivityPlanLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: _buildDayBubbles(context, state),
                  ),
                  if (state.itinerary.finalized)
                    _buildSaveTripButton(context),
                ],
              );
            } else if (state is ActivityPlanError) {
              return ErrorStateWidget(
                message: 'Failed to load activity plan. ${state.message}',
                onTryAgain: () {
                  context.read<ActivityPlanBloc>().add(
                        GetInitialActivityPlan(
                          destination: destination,
                          departureCity: departureCity,
                          numberOfChildren: numberOfChildren,
                          numberOfAdults: numberOfAdults,
                          fromDate: fromDate,
                          toDate: toDate,
                          interests: interests,
                        ),
                      );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildDayBubbles(BuildContext context, ActivityPlanLoaded state) {
    return ListView.builder(
      itemCount: state.itinerary.dayPlans.length,
      itemBuilder: (context, index) {
        final dayPlan = state.itinerary.dayPlans[index];
        return AnimatedListItem(
          index: index,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text('Day ${dayPlan.dayNumber}'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActivityBubbles(context, state, dayPlan.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActivityBubbles(
      BuildContext context, ActivityPlanLoaded state, int dayId) {
    final dayPlan =
        state.itinerary.dayPlans.firstWhere((dp) => dp.id == dayId);
    final activities = dayPlan.activities;

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...activities.asMap().entries.map((entry) {
          final index = entry.key;
          final activity = entry.value;
          return AnimatedListItem(
            index: index,
            child: Hero(
              tag: activity.image,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(activity.image),
              ),
            ),
          );
        }),
        if (dayPlan.canFitAnotherActivityInTheSameDay)
          AnimatedListItem(
            index: activities.length,
            child: GestureDetector(
              onTap: () {
                context.read<ActivityPlanBloc>().add(
                    GetSuggestedActivitiesForDay(state.itinerary.id, dayId));
              },
              child: const CircleAvatar(
                radius: 25,
                child: Icon(Icons.add),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSaveTripButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            final secureStorage = sl<FlutterSecureStorage>();
            final token = await secureStorage.read(key: 'token');
            if (token == null) {
              showDialog(
                context: context,
                builder: (_) => const LoginModal(),
              ).then((_) {
                // After the login modal is dismissed, check if the user is logged in
                // and navigate to the save screen if they are.
                secureStorage.read(key: 'token').then((value) {
                  if (value != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SaveShareBookScreen(),
                      ),
                    );
                  }
                });
              });
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SaveShareBookScreen(),
                ),
              );
            }
          },
          child: const Text('Want to save your trip plan and get an offer?'),
        ),
      ),
    );
  }
}
