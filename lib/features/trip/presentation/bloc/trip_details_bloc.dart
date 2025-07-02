import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/trip_details_event.dart';
import 'package:ai_trip_planner/features/trip/presentation/bloc/trip_details_state.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  TripDetailsBloc() : super(const TripDetailsState()) {
    on<IncrementAdults>(_onIncrementAdults);
    on<DecrementAdults>(_onDecrementAdults);
    on<IncrementChildren>(_onIncrementChildren);
    on<DecrementChildren>(_onDecrementChildren);
    on<SelectDateRange>(_onSelectDateRange);
    on<SetOriginAirport>(_onSetOriginAirport);
  }

  void _onIncrementAdults(
      IncrementAdults event, Emitter<TripDetailsState> emit) {
    emit(state.copyWith(numberOfAdults: state.numberOfAdults + 1));
  }

  void _onDecrementAdults(
      DecrementAdults event, Emitter<TripDetailsState> emit) {
    if (state.numberOfAdults > 1) {
      emit(state.copyWith(numberOfAdults: state.numberOfAdults - 1));
    }
  }

  void _onIncrementChildren(
      IncrementChildren event, Emitter<TripDetailsState> emit) {
    emit(state.copyWith(numberOfChildren: state.numberOfChildren + 1));
  }

  void _onDecrementChildren(
      DecrementChildren event, Emitter<TripDetailsState> emit) {
    if (state.numberOfChildren > 0) {
      emit(state.copyWith(numberOfChildren: state.numberOfChildren - 1));
    }
  }

  void _onSelectDateRange(
      SelectDateRange event, Emitter<TripDetailsState> emit) {
    emit(state.copyWith(dateRange: event.dateRange));
  }

  void _onSetOriginAirport(
      SetOriginAirport event, Emitter<TripDetailsState> emit) {
    emit(state.copyWith(originAirport: event.originAirport));
  }
}
