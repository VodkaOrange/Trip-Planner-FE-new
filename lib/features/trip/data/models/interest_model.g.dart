// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InterestModelCWProxy {
  InterestModel name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InterestModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InterestModel(...).copyWith(id: 12, name: "My name")
  /// ````
  InterestModel call({
    String name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInterestModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInterestModel.copyWith.fieldName(...)`
class _$InterestModelCWProxyImpl implements _$InterestModelCWProxy {
  const _$InterestModelCWProxyImpl(this._value);

  final InterestModel _value;

  @override
  InterestModel name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InterestModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InterestModel(...).copyWith(id: 12, name: "My name")
  /// ````
  InterestModel call({
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return InterestModel(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $InterestModelCopyWith on InterestModel {
  /// Returns a callable class that can be used as follows: `instanceOfInterestModel.copyWith(...)` or like so:`instanceOfInterestModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InterestModelCWProxy get copyWith => _$InterestModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterestModel _$InterestModelFromJson(Map<String, dynamic> json) =>
    InterestModel(
      name: json['name'] as String,
    );

Map<String, dynamic> _$InterestModelToJson(InterestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
