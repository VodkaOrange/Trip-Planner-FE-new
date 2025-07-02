import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/domain/repositories/trip_repository.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/suggested_cities_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/suggested_cities_state.dart';

class SuggestedCitiesBloc
    extends Bloc<SuggestedCitiesEvent, SuggestedCitiesState> {
  final TripRepository tripRepository;

  SuggestedCitiesBloc({required this.tripRepository})
      : super(SuggestedCitiesInitial()) {
    on<GetSuggestedCities>(_onGetSuggestedCities);
  }

  void _onGetSuggestedCities(
      GetSuggestedCities event, Emitter<SuggestedCitiesState> emit) async {
    emit(SuggestedCitiesLoading());
    try {
      final cities = await tripRepository.getSuggestedCities(event.preferences);
      emit(SuggestedCitiesLoaded(cities));
    } catch (e) {
      emit(SuggestedCitiesError(e.toString()));
    }
  }
}
