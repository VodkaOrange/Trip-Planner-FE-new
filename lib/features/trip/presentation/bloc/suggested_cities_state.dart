import 'package:equatable/equatable.dart';
import 'package:ai_trip_planner/features/trip/data/models/suggested_city_model.dart';

abstract class SuggestedCitiesState extends Equatable {
  const SuggestedCitiesState();

  @override
  List<Object> get props => [];
}

class SuggestedCitiesInitial extends SuggestedCitiesState {}

class SuggestedCitiesLoading extends SuggestedCitiesState {}

class SuggestedCitiesLoaded extends SuggestedCitiesState {
  final List<SuggestedCityModel> cities;

  const SuggestedCitiesLoaded(this.cities);

  @override
  List<Object> get props => [cities];
}

class SuggestedCitiesError extends SuggestedCitiesState {
  final String message;

  const SuggestedCitiesError(this.message);

  @override
  List<Object> get props => [message];
}
