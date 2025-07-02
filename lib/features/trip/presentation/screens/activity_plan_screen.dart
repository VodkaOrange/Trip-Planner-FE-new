import 'dart:ui';
import 'package:ai_trip_planner/core/widgets/custom_app_bar.dart';
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
import 'package:dotted_border/dotted_border.dart';

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
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(title: 'Activity Plan'),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://source.unsplash.com/random/?trip,travel'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child:
                BlocConsumer<ActivityPlanBloc, ActivityPlanState>(
              listener: (context, state) {
                if (state is ActivityPlanLoaded &&
                    state.suggestedActivities != null) {
                  showDialog(
                    context: context,
                    builder: (_) => ActivitySelectionModal(
                      activities: state.suggestedActivities!,
                      onActivitySelected: (activity) {
                        final tripId = state.itinerary.id;
                        final dayNumber = state.itinerary.dayPlans
                            .firstWhere(
                                (dp) => dp.canFitAnotherActivityInTheSameDay)
                            .dayNumber;
                        context.read<ActivityPlanBloc>().add(
                            SelectActivityForDay(tripId, dayNumber, activity));
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
                    message: 'Oops! Something went wrong.',
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
        ),
      ),
    );
  }

  Widget _buildDayBubbles(BuildContext context, ActivityPlanLoaded state) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 120),
      itemCount: state.itinerary.dayPlans.length,
      itemBuilder: (context, index) {
        final dayPlan = state.itinerary.dayPlans[index];
        return AnimatedListItem(
          index: index,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day ${dayPlan.dayNumber}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildActivityBubbles(context, state, dayPlan.dayNumber),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActivityBubbles(
      BuildContext context, ActivityPlanLoaded state, int dayNumber) {
    final dayPlan =
        state.itinerary.dayPlans.firstWhere((dp) => dp.dayNumber == dayNumber);
    final activities = dayPlan.activities;

    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        ...activities.asMap().entries.map((entry) {
          final index = entry.key;
          final activity = entry.value;
          return AnimatedListItem(
            index: index,
            child: Hero(
              tag: activity.image,
              child: CircleAvatar(
                radius: 30,
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
                    GetSuggestedActivitiesForDay(
                        state.itinerary.id, dayNumber));
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(30),
                color: Colors.grey,
                strokeWidth: 2,
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.add, color: Colors.grey, size: 30),
                ),
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
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          ),
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
