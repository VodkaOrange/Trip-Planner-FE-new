import 'package:equatable/equatable.dart';

abstract class PlanYourAdventureEvent extends Equatable {
  const PlanYourAdventureEvent();

  @override
  List<Object?> get props => [];
}

class SelectActivity extends PlanYourAdventureEvent {
  final String activity;

  const SelectActivity(this.activity);

  @override
  List<Object> get props => [activity];
}

class DeselectActivity extends PlanYourAdventureEvent {
  final String activity;

  const DeselectActivity(this.activity);

  @override
  List<Object> get props => [activity];
}

class SelectDestination extends PlanYourAdventureEvent {
  final String? destination;

  const SelectDestination(this.destination);

  @override
  List<Object?> get props => [destination];
}

class ToggleAiChoice extends PlanYourAdventureEvent {
  final bool isAiChoice;

  const ToggleAiChoice(this.isAiChoice);

  @override
  List<Object> get props => [isAiChoice];
}
