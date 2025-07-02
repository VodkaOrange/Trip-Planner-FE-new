import 'package:equatable/equatable.dart';
import 'package:ai_trip_planner/features/trip/data/models/itinerary_response_model.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';

abstract class ActivityPlanState extends Equatable {
  const ActivityPlanState();

  @override
  List<Object?> get props => [];
}

class ActivityPlanInitial extends ActivityPlanState {}

class ActivityPlanLoading extends ActivityPlanState {}

class ActivityPlanLoaded extends ActivityPlanState {
  final ItineraryResponseModel itinerary;
  final List<ActivityModel>? suggestedActivities;
  final int? loadingDayNumber; // To track which day is loading

  const ActivityPlanLoaded({
    required this.itinerary,
    this.suggestedActivities,
    this.loadingDayNumber,
  });

  ActivityPlanLoaded copyWith({
    ItineraryResponseModel? itinerary,
    List<ActivityModel>? suggestedActivities,
    int? loadingDayNumber,
    bool forceSuggestedActivitiesToNull = false,
    bool forceLoadingDayToNull = false,
  }) {
    return ActivityPlanLoaded(
      itinerary: itinerary ?? this.itinerary,
      suggestedActivities: forceSuggestedActivitiesToNull
          ? null
          : suggestedActivities ?? this.suggestedActivities,
      loadingDayNumber: forceLoadingDayToNull
          ? null
          : loadingDayNumber ?? this.loadingDayNumber,
    );
  }

  @override
  List<Object?> get props =>
      [itinerary, suggestedActivities, loadingDayNumber];
}

class ActivityPlanError extends ActivityPlanState {
  final String message;

  const ActivityPlanError(this.message);

  @override
  List<Object> get props => [message];
}
