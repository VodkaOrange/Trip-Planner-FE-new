import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interest_model.g.dart';

@CopyWith()
@JsonSerializable()
class InterestModel {
  final String name;

  InterestModel({
    required this.name,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) =>
      _$InterestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterestModelToJson(this);
}
