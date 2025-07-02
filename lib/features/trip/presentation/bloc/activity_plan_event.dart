import 'package:equatable/equatable.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';

abstract class ActivityPlanEvent extends Equatable {
  const ActivityPlanEvent();

  @override
  List<Object> get props => [];
}

class GetInitialActivityPlan extends ActivityPlanEvent {
  final String destination;
  final String? departureCity;
  final int numberOfChildren;
  final int numberOfAdults;
  final String fromDate;
  final String toDate;
  final List<String> interests;

  const GetInitialActivityPlan({
    required this.destination,
    this.departureCity,
    required this.numberOfChildren,
    required this.numberOfAdults,
    required this.fromDate,
    required this.toDate,
    required this.interests,
  });

  @override
  List<Object> get props => [
        destination,
        numberOfChildren,
        numberOfAdults,
        fromDate,
        toDate,
        interests,
      ];
}

class GetSuggestedActivitiesForDay extends ActivityPlanEvent {
  final int tripId;
  final int dayNumber;

  const GetSuggestedActivitiesForDay(this.tripId, this.dayNumber);

  @override
  List<Object> get props => [tripId, dayNumber];
}

class SelectActivityForDay extends ActivityPlanEvent {
  final int tripId;
  final int dayNumber;
  final ActivityModel activity;

  const SelectActivityForDay(this.tripId, this.dayNumber, this.activity);

  @override
  List<Object> get props => [tripId, dayNumber, activity];
}

class ClearSuggestedActivities extends ActivityPlanEvent {}
