import 'package:equatable/equatable.dart';

class PlanYourAdventureState extends Equatable {
  final List<String> selectedActivities;
  final String? destination;
  final bool isAiChoice;

  const PlanYourAdventureState({
    this.selectedActivities = const [],
    this.destination,
    this.isAiChoice = false,
  });

  PlanYourAdventureState copyWith({
    List<String>? selectedActivities,
    String? destination,
    bool? isAiChoice,
  }) {
    return PlanYourAdventureState(
      selectedActivities: selectedActivities ?? this.selectedActivities,
      destination: destination,
      isAiChoice: isAiChoice ?? this.isAiChoice,
    );
  }

  @override
  List<Object?> get props => [selectedActivities, destination, isAiChoice];
}
