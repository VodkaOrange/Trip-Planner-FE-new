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
  final int? dayNumberForSuggestions;

  const ActivityPlanLoaded({
    required this.itinerary,
    this.suggestedActivities,
    this.dayNumberForSuggestions,
  });

  ActivityPlanLoaded copyWith({
    ItineraryResponseModel? itinerary,
    List<ActivityModel>? suggestedActivities,
    int? dayNumberForSuggestions,
    bool clearSuggestions = false,
  }) {
    return ActivityPlanLoaded(
      itinerary: itinerary ?? this.itinerary,
      suggestedActivities: clearSuggestions ? null : suggestedActivities ?? this.suggestedActivities,
      dayNumberForSuggestions: clearSuggestions ? null : dayNumberForSuggestions ?? this.dayNumberForSuggestions,
    );
  }

  @override
  List<Object?> get props =>
      [itinerary, suggestedActivities, dayNumberForSuggestions];
}

class ActivityPlanError extends ActivityPlanState {
  final String message;

  const ActivityPlanError(this.message);

  @override
  List<Object> get props => [message];
}
