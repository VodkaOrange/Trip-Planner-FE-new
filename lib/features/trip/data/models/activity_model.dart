import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@CopyWith()
@JsonSerializable()
class ActivityModel {
  final int? id;
  final String name;
  final String city;
  final String description;
  final double expectedDurationHours;
  final double estimatedCostEUR;
  final String? image; // Made nullable
  final String? address; // Made nullable

  ActivityModel({
    this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.expectedDurationHours,
    required this.estimatedCostEUR,
    this.image,
    this.address,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
