// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_city_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SuggestedCityModelCWProxy {
  SuggestedCityModel country(String country);

  SuggestedCityModel city(String city);

  SuggestedCityModel overview(String overview);

  SuggestedCityModel imageUrl(String imageUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SuggestedCityModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SuggestedCityModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SuggestedCityModel call({
    String country,
    String city,
    String overview,
    String imageUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSuggestedCityModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSuggestedCityModel.copyWith.fieldName(...)`
class _$SuggestedCityModelCWProxyImpl implements _$SuggestedCityModelCWProxy {
  const _$SuggestedCityModelCWProxyImpl(this._value);

  final SuggestedCityModel _value;

  @override
  SuggestedCityModel country(String country) => this(country: country);

  @override
  SuggestedCityModel city(String city) => this(city: city);

  @override
  SuggestedCityModel overview(String overview) => this(overview: overview);

  @override
  SuggestedCityModel imageUrl(String imageUrl) => this(imageUrl: imageUrl);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SuggestedCityModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SuggestedCityModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SuggestedCityModel call({
    Object? country = const $CopyWithPlaceholder(),
    Object? city = const $CopyWithPlaceholder(),
    Object? overview = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
  }) {
    return SuggestedCityModel(
      country: country == const $CopyWithPlaceholder()
          ? _value.country
          // ignore: cast_nullable_to_non_nullable
          : country as String,
      city: city == const $CopyWithPlaceholder()
          ? _value.city
          // ignore: cast_nullable_to_non_nullable
          : city as String,
      overview: overview == const $CopyWithPlaceholder()
          ? _value.overview
          // ignore: cast_nullable_to_non_nullable
          : overview as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String,
    );
  }
}

extension $SuggestedCityModelCopyWith on SuggestedCityModel {
  /// Returns a callable class that can be used as follows: `instanceOfSuggestedCityModel.copyWith(...)` or like so:`instanceOfSuggestedCityModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SuggestedCityModelCWProxy get copyWith =>
      _$SuggestedCityModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestedCityModel _$SuggestedCityModelFromJson(Map<String, dynamic> json) =>
    SuggestedCityModel(
      country: json['country'] as String,
      city: json['city'] as String,
      overview: json['overview'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$SuggestedCityModelToJson(SuggestedCityModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'overview': instance.overview,
      'imageUrl': instance.imageUrl,
    };
