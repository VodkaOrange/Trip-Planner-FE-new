import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();

  @override
  List<Object> get props => [];
}

class IncrementAdults extends TripDetailsEvent {}

class DecrementAdults extends TripDetailsEvent {}

class IncrementChildren extends TripDetailsEvent {}

class DecrementChildren extends TripDetailsEvent {}

class SelectDateRange extends TripDetailsEvent {
  final DateTimeRange dateRange;

  const SelectDateRange(this.dateRange);

  @override
  List<Object> get props => [dateRange];
}

class SetOriginAirport extends TripDetailsEvent {
  final String originAirport;

  const SetOriginAirport(this.originAirport);

  @override
  List<Object> get props => [originAirport];
}
