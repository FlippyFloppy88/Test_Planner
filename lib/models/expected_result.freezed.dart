// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expected_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpectedResult {
  /// Legacy single-item fields kept for backward-compatible JSON loading.
  String get description;
  AnswerType get answerType;
  double? get minValue;
  double? get maxValue;
  String? get unit;

  /// New list-based expected result items.
  List<ExpectedResultItem> get items;

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpectedResultCopyWith<ExpectedResult> get copyWith =>
      _$ExpectedResultCopyWithImpl<ExpectedResult>(
          this as ExpectedResult, _$identity);

  /// Serializes this ExpectedResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpectedResult &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.answerType, answerType) ||
                other.answerType == answerType) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, answerType,
      minValue, maxValue, unit, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'ExpectedResult(description: $description, answerType: $answerType, minValue: $minValue, maxValue: $maxValue, unit: $unit, items: $items)';
  }
}

/// @nodoc
abstract mixin class $ExpectedResultCopyWith<$Res> {
  factory $ExpectedResultCopyWith(
          ExpectedResult value, $Res Function(ExpectedResult) _then) =
      _$ExpectedResultCopyWithImpl;
  @useResult
  $Res call(
      {String description,
      AnswerType answerType,
      double? minValue,
      double? maxValue,
      String? unit,
      List<ExpectedResultItem> items});
}

/// @nodoc
class _$ExpectedResultCopyWithImpl<$Res>
    implements $ExpectedResultCopyWith<$Res> {
  _$ExpectedResultCopyWithImpl(this._self, this._then);

  final ExpectedResult _self;
  final $Res Function(ExpectedResult) _then;

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
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answerType: null == answerType
          ? _self.answerType
          : answerType // ignore: cast_nullable_to_non_nullable
              as AnswerType,
      minValue: freezed == minValue
          ? _self.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxValue: freezed == maxValue
          ? _self.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExpectedResultItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ExpectedResult implements ExpectedResult {
  const _ExpectedResult(
      {this.description = '',
      this.answerType = AnswerType.none,
      this.minValue,
      this.maxValue,
      this.unit,
      final List<ExpectedResultItem> items = const []})
      : _items = items;
  factory _ExpectedResult.fromJson(Map<String, dynamic> json) =>
      _$ExpectedResultFromJson(json);

  /// Legacy single-item fields kept for backward-compatible JSON loading.
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final AnswerType answerType;
  @override
  final double? minValue;
  @override
  final double? maxValue;
  @override
  final String? unit;

  /// New list-based expected result items.
  final List<ExpectedResultItem> _items;

  /// New list-based expected result items.
  @override
  @JsonKey()
  List<ExpectedResultItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExpectedResultCopyWith<_ExpectedResult> get copyWith =>
      __$ExpectedResultCopyWithImpl<_ExpectedResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExpectedResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpectedResult &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.answerType, answerType) ||
                other.answerType == answerType) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, answerType,
      minValue, maxValue, unit, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'ExpectedResult(description: $description, answerType: $answerType, minValue: $minValue, maxValue: $maxValue, unit: $unit, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$ExpectedResultCopyWith<$Res>
    implements $ExpectedResultCopyWith<$Res> {
  factory _$ExpectedResultCopyWith(
          _ExpectedResult value, $Res Function(_ExpectedResult) _then) =
      __$ExpectedResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String description,
      AnswerType answerType,
      double? minValue,
      double? maxValue,
      String? unit,
      List<ExpectedResultItem> items});
}

/// @nodoc
class __$ExpectedResultCopyWithImpl<$Res>
    implements _$ExpectedResultCopyWith<$Res> {
  __$ExpectedResultCopyWithImpl(this._self, this._then);

  final _ExpectedResult _self;
  final $Res Function(_ExpectedResult) _then;

  /// Create a copy of ExpectedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
    Object? answerType = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
    Object? items = null,
  }) {
    return _then(_ExpectedResult(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answerType: null == answerType
          ? _self.answerType
          : answerType // ignore: cast_nullable_to_non_nullable
              as AnswerType,
      minValue: freezed == minValue
          ? _self.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double?,
      maxValue: freezed == maxValue
          ? _self.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExpectedResultItem>,
    ));
  }
}

// dart format on
