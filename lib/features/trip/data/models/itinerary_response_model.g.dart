// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_response_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItineraryResponseModelCWProxy {
  ItineraryResponseModel id(int id);

  ItineraryResponseModel destination(String destination);

  ItineraryResponseModel numberOfDays(int? numberOfDays);

  ItineraryResponseModel shareableLink(String? shareableLink);

  ItineraryResponseModel createdAt(DateTime createdAt);

  ItineraryResponseModel userId(int? userId);

  ItineraryResponseModel finalized(bool finalized);

  ItineraryResponseModel dayPlans(List<DayPlanModel> dayPlans);

  ItineraryResponseModel interests(List<InterestModel> interests);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItineraryResponseModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItineraryResponseModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ItineraryResponseModel call({
    int id,
    String destination,
    int? numberOfDays,
    String? shareableLink,
    DateTime createdAt,
    int? userId,
    bool finalized,
    List<DayPlanModel> dayPlans,
    List<InterestModel> interests,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItineraryResponseModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItineraryResponseModel.copyWith.fieldName(...)`
class _$ItineraryResponseModelCWProxyImpl
    implements _$ItineraryResponseModelCWProxy {
  const _$ItineraryResponseModelCWProxyImpl(this._value);

  final ItineraryResponseModel _value;

  @override
  ItineraryResponseModel id(int id) => this(id: id);

  @override
  ItineraryResponseModel destination(String destination) =>
      this(destination: destination);

  @override
  ItineraryResponseModel numberOfDays(int? numberOfDays) =>
      this(numberOfDays: numberOfDays);

  @override
  ItineraryResponseModel shareableLink(String? shareableLink) =>
      this(shareableLink: shareableLink);

  @override
  ItineraryResponseModel createdAt(DateTime createdAt) =>
      this(createdAt: createdAt);

  @override
  ItineraryResponseModel userId(int? userId) => this(userId: userId);

  @override
  ItineraryResponseModel finalized(bool finalized) =>
      this(finalized: finalized);

  @override
  ItineraryResponseModel dayPlans(List<DayPlanModel> dayPlans) =>
      this(dayPlans: dayPlans);

  @override
  ItineraryResponseModel interests(List<InterestModel> interests) =>
      this(interests: interests);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ItineraryResponseModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ItineraryResponseModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ItineraryResponseModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? destination = const $CopyWithPlaceholder(),
    Object? numberOfDays = const $CopyWithPlaceholder(),
    Object? shareableLink = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? finalized = const $CopyWithPlaceholder(),
    Object? dayPlans = const $CopyWithPlaceholder(),
    Object? interests = const $CopyWithPlaceholder(),
  }) {
    return ItineraryResponseModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      destination: destination == const $CopyWithPlaceholder()
          ? _value.destination
          // ignore: cast_nullable_to_non_nullable
          : destination as String,
      numberOfDays: numberOfDays == const $CopyWithPlaceholder()
          ? _value.numberOfDays
          // ignore: cast_nullable_to_non_nullable
          : numberOfDays as int?,
      shareableLink: shareableLink == const $CopyWithPlaceholder()
          ? _value.shareableLink
          // ignore: cast_nullable_to_non_nullable
          : shareableLink as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as int?,
      finalized: finalized == const $CopyWithPlaceholder()
          ? _value.finalized
          // ignore: cast_nullable_to_non_nullable
          : finalized as bool,
      dayPlans: dayPlans == const $CopyWithPlaceholder()
          ? _value.dayPlans
          // ignore: cast_nullable_to_non_nullable
          : dayPlans as List<DayPlanModel>,
      interests: interests == const $CopyWithPlaceholder()
          ? _value.interests
          // ignore: cast_nullable_to_non_nullable
          : interests as List<InterestModel>,
    );
  }
}

extension $ItineraryResponseModelCopyWith on ItineraryResponseModel {
  /// Returns a callable class that can be used as follows: `instanceOfItineraryResponseModel.copyWith(...)` or like so:`instanceOfItineraryResponseModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItineraryResponseModelCWProxy get copyWith =>
      _$ItineraryResponseModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryResponseModel _$ItineraryResponseModelFromJson(
        Map<String, dynamic> json) =>
    ItineraryResponseModel(
      id: (json['id'] as num).toInt(),
      destination: json['destination'] as String,
      numberOfDays: (json['numberOfDays'] as num?)?.toInt(),
      shareableLink: json['shareableLink'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: (json['userId'] as num?)?.toInt(),
      finalized: json['finalized'] as bool,
      dayPlans: (json['dayPlans'] as List<dynamic>)
          .map((e) => DayPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      interests: (json['interests'] as List<dynamic>)
          .map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItineraryResponseModelToJson(
        ItineraryResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'destination': instance.destination,
      'numberOfDays': instance.numberOfDays,
      'shareableLink': instance.shareableLink,
      'createdAt': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
      'finalized': instance.finalized,
      'dayPlans': instance.dayPlans.map((e) => e.toJson()).toList(),
      'interests': instance.interests.map((e) => e.toJson()).toList(),
    };
