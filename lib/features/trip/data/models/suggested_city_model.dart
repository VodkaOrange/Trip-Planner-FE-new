import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suggested_city_model.g.dart';

@CopyWith()
@JsonSerializable()
class SuggestedCityModel {
  final String country;
  final String city;
  final String overview;
  final String imageUrl;

  SuggestedCityModel({
    required this.country,
    required this.city,
    required this.overview,
    required this.imageUrl,
  });

  factory SuggestedCityModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestedCityModelFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedCityModelToJson(this);
}
