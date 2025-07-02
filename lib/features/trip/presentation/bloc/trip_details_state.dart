import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TripDetailsState extends Equatable {
  final int numberOfAdults;
  final int numberOfChildren;
  final DateTimeRange? dateRange;
  final String? originAirport;

  const TripDetailsState({
    this.numberOfAdults = 1,
    this.numberOfChildren = 0,
    this.dateRange,
    this.originAirport,
  });

  TripDetailsState copyWith({
    int? numberOfAdults,
    int? numberOfChildren,
    DateTimeRange? dateRange,
    String? originAirport,
  }) {
    return TripDetailsState(
      numberOfAdults: numberOfAdults ?? this.numberOfAdults,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      dateRange: dateRange ?? this.dateRange,
      originAirport: originAirport ?? this.originAirport,
    );
  }

  @override
  List<Object?> get props => [
        numberOfAdults,
        numberOfChildren,
        dateRange,
        originAirport,
      ];
}
