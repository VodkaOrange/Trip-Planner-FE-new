import 'package:equatable/equatable.dart';

abstract class SuggestedCitiesEvent extends Equatable {
  const SuggestedCitiesEvent();

  @override
  List<Object> get props => [];
}

class GetSuggestedCities extends SuggestedCitiesEvent {
  final List<String> preferences;

  const GetSuggestedCities(this.preferences);

  @override
  List<Object> get props => [preferences];
}
