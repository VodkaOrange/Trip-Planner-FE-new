// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivityModelCWProxy {
  ActivityModel name(String name);

  ActivityModel city(String city);

  ActivityModel description(String description);

  ActivityModel expectedDurationHours(double expectedDurationHours);

  ActivityModel estimatedCostEUR(double estimatedCostEUR);

  ActivityModel image(String image);

  ActivityModel address(String address);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityModel call({
    String name,
    String city,
    String description,
    double expectedDurationHours,
    double estimatedCostEUR,
    String image,
    String address,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActivityModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActivityModel.copyWith.fieldName(...)`
class _$ActivityModelCWProxyImpl implements _$ActivityModelCWProxy {
  const _$ActivityModelCWProxyImpl(this._value);

  final ActivityModel _value;

  @override
  ActivityModel name(String name) => this(name: name);

  @override
  ActivityModel city(String city) => this(city: city);

  @override
  ActivityModel description(String description) =>
      this(description: description);

  @override
  ActivityModel expectedDurationHours(double expectedDurationHours) =>
      this(expectedDurationHours: expectedDurationHours);

  @override
  ActivityModel estimatedCostEUR(double estimatedCostEUR) =>
      this(estimatedCostEUR: estimatedCostEUR);

  @override
  ActivityModel image(String image) => this(image: image);

  @override
  ActivityModel address(String address) => this(address: address);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityModel call({
    Object? name = const $CopyWithPlaceholder(),
    Object? city = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? expectedDurationHours = const $CopyWithPlaceholder(),
    Object? estimatedCostEUR = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
  }) {
    return ActivityModel(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      city: city == const $CopyWithPlaceholder()
          ? _value.city
          // ignore: cast_nullable_to_non_nullable
          : city as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      expectedDurationHours:
          expectedDurationHours == const $CopyWithPlaceholder()
          ? _value.expectedDurationHours
          // ignore: cast_nullable_to_non_nullable
          : expectedDurationHours as double,
      estimatedCostEUR: estimatedCostEUR == const $CopyWithPlaceholder()
          ? _value.estimatedCostEUR
          // ignore: cast_nullable_to_non_nullable
          : estimatedCostEUR as double,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
    );
  }
}

extension $ActivityModelCopyWith on ActivityModel {
  /// Returns a callable class that can be used as follows: `instanceOfActivityModel.copyWith(...)` or like so:`instanceOfActivityModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActivityModelCWProxy get copyWith => _$ActivityModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      name: json['name'] as String,
      city: json['city'] as String,
      description: json['description'] as String,
      expectedDurationHours: (json['expectedDurationHours'] as num).toDouble(),
      estimatedCostEUR: (json['estimatedCostEUR'] as num).toDouble(),
      image: json['image'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'description': instance.description,
      'expectedDurationHours': instance.expectedDurationHours,
      'estimatedCostEUR': instance.estimatedCostEUR,
      'image': instance.image,
      'address': instance.address,
    };
