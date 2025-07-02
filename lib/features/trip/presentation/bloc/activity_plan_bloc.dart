import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';
import 'package:ai_trip_planner/features/trip/domain/repositories/trip_repository.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_state.dart';
import 'package:collection/collection.dart';

class ActivityPlanBloc extends Bloc<ActivityPlanEvent, ActivityPlanState> {
  final TripRepository tripRepository;

  ActivityPlanBloc({required this.tripRepository})
      : super(ActivityPlanInitial()) {
    on<GetInitialActivityPlan>(_onGetInitialActivityPlan);
    on<GetSuggestedActivitiesForDay>(_onGetSuggestedActivitiesForDay);
    on<SelectActivityForDay>(_onSelectActivityForDay);
    on<ClearSuggestedActivities>(_onClearSuggestedActivities);
  }

  void _onGetInitialActivityPlan(
      GetInitialActivityPlan event, Emitter<ActivityPlanState> emit) async {
    emit(ActivityPlanLoading());
    try {
      final itinerary = await tripRepository.startTrip(
        event.destination,
        event.departureCity,
        event.numberOfChildren,
        event.numberOfAdults,
        event.fromDate,
        event.toDate,
        event.interests,
      );
      emit(ActivityPlanLoaded(itinerary: itinerary));
    } catch (e) {
      emit(ActivityPlanError(e.toString()));
    }
  }

  void _onGetSuggestedActivitiesForDay(GetSuggestedActivitiesForDay event,
      Emitter<ActivityPlanState> emit) async {
    if (state is! ActivityPlanLoaded) return;
    final currentState = state as ActivityPlanLoaded;

    emit(currentState.copyWith(dayNumberForSuggestions: event.dayNumber));
    try {
      final activities = await tripRepository.getSuggestedActivities(
          event.tripId, event.dayNumber);
      emit(currentState.copyWith(
        suggestedActivities: activities,
        dayNumberForSuggestions: event.dayNumber,
      ));
    } catch (e) {
      emit(ActivityPlanError(e.toString()));
    }
  }

  void _onSelectActivityForDay(
      SelectActivityForDay event, Emitter<ActivityPlanState> emit) async {
    if (state is! ActivityPlanLoaded) return;
    final currentState = state as ActivityPlanLoaded;
    try {
      final responseItinerary = await tripRepository.selectActivity(
          event.tripId, event.dayNumber, event.activity);

      final Map<String, ActivityModel> knownActivityDetails = {};
      for (var dayPlan in currentState.itinerary.dayPlans) {
        for (var activity in dayPlan.activities) {
          knownActivityDetails[activity.name] = activity;
        }
      }
      knownActivityDetails[event.activity.name] = event.activity;

      final correctedDayPlans = responseItinerary.dayPlans.map((serverDayPlan) {
        final correctedActivities = serverDayPlan.activities.map((serverActivity) {
          final clientDetails = knownActivityDetails[serverActivity.name];
          // Manually construct the new ActivityModel to ensure correctness
          return ActivityModel(
            id: serverActivity.id,
            name: serverActivity.name,
            city: serverActivity.city,
            description: serverActivity.description,
            expectedDurationHours: serverActivity.expectedDurationHours,
            estimatedCostEUR: serverActivity.estimatedCostEUR,
            image: clientDetails?.image,
            address: clientDetails?.address,
          );
        }).toList();

        return serverDayPlan.copyWith(activities: correctedActivities);
      }).toList();

      final finalItinerary = responseItinerary.copyWith(dayPlans: correctedDayPlans);

      emit(currentState.copyWith(
        itinerary: finalItinerary,
        clearSuggestions: true,
      ));
    } catch (e) {
      emit(ActivityPlanError(e.toString()));
    }
  }

  void _onClearSuggestedActivities(
      ClearSuggestedActivities event, Emitter<ActivityPlanState> emit) {
    if (state is ActivityPlanLoaded) {
      final currentState = state as ActivityPlanLoaded;
      emit(currentState.copyWith(clearSuggestions: true));
    }
  }
}
