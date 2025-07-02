import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ai_trip_planner/features/trip/data/models/activity_model.dart';

part 'day_plan_model.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class DayPlanModel {
  final int id;
  final int dayNumber;
  final List<ActivityModel> activities;
  final bool canFitAnotherActivityInTheSameDay;

  DayPlanModel({
    required this.id,
    required this.dayNumber,
    required this.activities,
    required this.canFitAnotherActivityInTheSameDay,
  });

  factory DayPlanModel.fromJson(Map<String, dynamic> json) =>
      _$DayPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayPlanModelToJson(this);
}
