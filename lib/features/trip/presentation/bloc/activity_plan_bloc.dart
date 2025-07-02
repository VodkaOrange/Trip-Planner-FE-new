import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/domain/repositories/trip_repository.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/activity_plan_state.dart';

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

    emit(currentState.copyWith(loadingDayNumber: event.dayNumber));
    try {
      final activities = await tripRepository.getSuggestedActivities(
          event.tripId, event.dayNumber);
      emit(currentState.copyWith(
        suggestedActivities: activities,
        loadingDayNumber: null,
        forceLoadingDayToNull: true,
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
      final updatedItinerary = await tripRepository.selectActivity(
          event.tripId, event.dayNumber, event.activity);
      emit(currentState.copyWith(
        itinerary: updatedItinerary,
        forceSuggestedActivitiesToNull: true,
      ));
    } catch (e) {
      emit(ActivityPlanError(e.toString()));
    }
  }

  void _onClearSuggestedActivities(
      ClearSuggestedActivities event, Emitter<ActivityPlanState> emit) {
    if (state is ActivityPlanLoaded) {
      final currentState = state as ActivityPlanLoaded;
      emit(currentState.copyWith(forceSuggestedActivitiesToNull: true));
    }
  }
}
