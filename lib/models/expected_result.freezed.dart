// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expected_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpectedResult _$ExpectedResultFromJson(Map<String, dynamic> json) {
  return _ExpectedResult.fromJson(json);
}

/// @nodoc
mixin _$ExpectedResult {
  String get description => throw _privateConstructorUsedError;
  AnswerType get answerType => throw _privateConstructorUsedError;

  /// For answerType == value
  double? get minValue => throw _privateConstructorUsedError;
  double? get maxValue => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;

  /// Serializes this ExpectedResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpectedResultCopyWith<ExpectedResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpectedResultCopyWith<$Res> {
  factory $ExpectedResultCopyWith(
          ExpectedResult value, $Res Function(ExpectedResult) then) =
      _$ExpectedResultCopyWithImpl<$Res, ExpectedResult>;
  @useResult
  $Res call(
      {String description,
      AnswerType answerType,
      double? minValue,
      double? maxValue,
      String? unit});
}

/// @nodoc
class _$ExpectedResultCopyWithImpl<$Res, $Val extends ExpectedResult>
    implements $ExpectedResultCopyWith<$Res> {
  _$ExpectedResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? answerType = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answerType: null == answerType
          ? _value.answerType
          : answerType // ignore: cast_nullable_to_non_nullable
              as AnswerType,
      minValue: freezed == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxValue: freezed == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpectedResultImplCopyWith<$Res>
    implements $ExpectedResultCopyWith<$Res> {
  factory _$$ExpectedResultImplCopyWith(_$ExpectedResultImpl value,
          $Res Function(_$ExpectedResultImpl) then) =
      __$$ExpectedResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      AnswerType answerType,
      double? minValue,
      double? maxValue,
      String? unit});
}

/// @nodoc
class __$$ExpectedResultImplCopyWithImpl<$Res>
    extends _$ExpectedResultCopyWithImpl<$Res, _$ExpectedResultImpl>
    implements _$$ExpectedResultImplCopyWith<$Res> {
  __$$ExpectedResultImplCopyWithImpl(
      _$ExpectedResultImpl _value, $Res Function(_$ExpectedResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? answerType = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
  }) {
    return _then(_$ExpectedResultImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answerType: null == answerType
          ? _value.answerType
          : answerType // ignore: cast_nullable_to_non_nullable
              as AnswerType,
      minValue: freezed == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxValue: freezed == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpectedResultImpl implements _ExpectedResult {
  const _$ExpectedResultImpl(
      {this.description = '',
      this.answerType = AnswerType.none,
      this.minValue,
      this.maxValue,
      this.unit});

  factory _$ExpectedResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpectedResultImplFromJson(json);

  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final AnswerType answerType;

  /// For answerType == value
  @override
  final double? minValue;
  @override
  final double? maxValue;
  @override
  final String? unit;

  @override
  String toString() {
    return 'ExpectedResult(description: $description, answerType: $answerType, minValue: $minValue, maxValue: $maxValue, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpectedResultImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.answerType, answerType) ||
                other.answerType == answerType) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, answerType, minValue, maxValue, unit);

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpectedResultImplCopyWith<_$ExpectedResultImpl> get copyWith =>
      __$$ExpectedResultImplCopyWithImpl<_$ExpectedResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpectedResultImplToJson(
      this,
    );
  }
}

abstract class _ExpectedResult implements ExpectedResult {
  const factory _ExpectedResult(
      {final String description,
      final AnswerType answerType,
      final double? minValue,
      final double? maxValue,
      final String? unit}) = _$ExpectedResultImpl;

  factory _ExpectedResult.fromJson(Map<String, dynamic> json) =
      _$ExpectedResultImpl.fromJson;

  @override
  String get description;
  @override
  AnswerType get answerType;

  /// For answerType == value
  @override
  double? get minValue;
  @override
  double? get maxValue;
  @override
  String? get unit;

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpectedResultImplCopyWith<_$ExpectedResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
