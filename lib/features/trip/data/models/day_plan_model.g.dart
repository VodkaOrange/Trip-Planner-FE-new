// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_plan_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DayPlanModelCWProxy {
  DayPlanModel id(int id);

  DayPlanModel dayNumber(int dayNumber);

  DayPlanModel activities(List<ActivityModel> activities);

  DayPlanModel canFitAnotherActivityInTheSameDay(
    bool canFitAnotherActivityInTheSameDay,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DayPlanModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DayPlanModel(...).copyWith(id: 12, name: "My name")
  /// ````
  DayPlanModel call({
    int id,
    int dayNumber,
    List<ActivityModel> activities,
    bool canFitAnotherActivityInTheSameDay,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDayPlanModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDayPlanModel.copyWith.fieldName(...)`
class _$DayPlanModelCWProxyImpl implements _$DayPlanModelCWProxy {
  const _$DayPlanModelCWProxyImpl(this._value);

  final DayPlanModel _value;

  @override
  DayPlanModel id(int id) => this(id: id);

  @override
  DayPlanModel dayNumber(int dayNumber) => this(dayNumber: dayNumber);

  @override
  DayPlanModel activities(List<ActivityModel> activities) =>
      this(activities: activities);

  @override
  DayPlanModel canFitAnotherActivityInTheSameDay(
    bool canFitAnotherActivityInTheSameDay,
  ) => this(
    canFitAnotherActivityInTheSameDay: canFitAnotherActivityInTheSameDay,
  );

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DayPlanModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DayPlanModel(...).copyWith(id: 12, name: "My name")
  /// ````
  DayPlanModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? dayNumber = const $CopyWithPlaceholder(),
    Object? activities = const $CopyWithPlaceholder(),
    Object? canFitAnotherActivityInTheSameDay = const $CopyWithPlaceholder(),
  }) {
    return DayPlanModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      dayNumber: dayNumber == const $CopyWithPlaceholder()
          ? _value.dayNumber
          // ignore: cast_nullable_to_non_nullable
          : dayNumber as int,
      activities: activities == const $CopyWithPlaceholder()
          ? _value.activities
          // ignore: cast_nullable_to_non_nullable
          : activities as List<ActivityModel>,
      canFitAnotherActivityInTheSameDay:
          canFitAnotherActivityInTheSameDay == const $CopyWithPlaceholder()
          ? _value.canFitAnotherActivityInTheSameDay
          // ignore: cast_nullable_to_non_nullable
          : canFitAnotherActivityInTheSameDay as bool,
    );
  }
}

extension $DayPlanModelCopyWith on DayPlanModel {
  /// Returns a callable class that can be used as follows: `instanceOfDayPlanModel.copyWith(...)` or like so:`instanceOfDayPlanModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DayPlanModelCWProxy get copyWith => _$DayPlanModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayPlanModel _$DayPlanModelFromJson(Map<String, dynamic> json) => DayPlanModel(
  id: (json['id'] as num).toInt(),
  dayNumber: (json['dayNumber'] as num).toInt(),
  activities: (json['activities'] as List<dynamic>)
      .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  canFitAnotherActivityInTheSameDay:
      json['canFitAnotherActivityInTheSameDay'] as bool,
);

Map<String, dynamic> _$DayPlanModelToJson(DayPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayNumber': instance.dayNumber,
      'activities': instance.activities.map((e) => e.toJson()).toList(),
      'canFitAnotherActivityInTheSameDay':
          instance.canFitAnotherActivityInTheSameDay,
    };
