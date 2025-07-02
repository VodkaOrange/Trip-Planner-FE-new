import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ai_trip_planner/features/trip/data/models/day_plan_model.dart';
import 'package:ai_trip_planner/features/trip/data/models/interest_model.dart';

part 'itinerary_response_model.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class ItineraryResponseModel {
  final int id;
  final String destination;
  final int? numberOfDays; // Made nullable
  final String? shareableLink; // Made nullable
  final DateTime createdAt;
  final int? userId;
  final bool finalized;
  final List<DayPlanModel> dayPlans;
  final List<InterestModel> interests;

  ItineraryResponseModel({
    required this.id,
    required this.destination,
    this.numberOfDays,
    this.shareableLink,
    required this.createdAt,
    this.userId,
    required this.finalized,
    required this.dayPlans,
    required this.interests,
  });

  factory ItineraryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ItineraryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryResponseModelToJson(this);
}
