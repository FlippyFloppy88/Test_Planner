// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expected_result_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpectedResultItem {
  String get id;
  int get order;

  /// The observation or question text. Supports inline markup:
  ///   **bold**, *italic*, __underline__, [color=#RRGGBB]text[/color]
  /// and attachment placeholders: [📎 label](attachment:id)
  String get observation;
  AnswerType get answerType;

  /// For answerType == value
  double? get minValue;
  double? get maxValue;
  String? get unit;
  List<Attachment> get attachments;

  /// Create a copy of ExpectedResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpectedResultItemCopyWith<ExpectedResultItem> get copyWith =>
      _$ExpectedResultItemCopyWithImpl<ExpectedResultItem>(
          this as ExpectedResultItem, _$identity);

  /// Serializes this ExpectedResultItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpectedResultItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.observation, observation) ||
                other.observation == observation) &&
            (identical(other.answerType, answerType) ||
                other.answerType == answerType) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      order,
      observation,
      answerType,
      minValue,
      maxValue,
      unit,
      const DeepCollectionEquality().hash(attachments));

  @override
  String toString() {
    return 'ExpectedResultItem(id: $id, order: $order, observation: $observation, answerType: $answerType, minValue: $minValue, maxValue: $maxValue, unit: $unit, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class $ExpectedResultItemCopyWith<$Res> {
  factory $ExpectedResultItemCopyWith(
          ExpectedResultItem value, $Res Function(ExpectedResultItem) _then) =
      _$ExpectedResultItemCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      int order,
      String observation,
      AnswerType answerType,
      double? minValue,
      double? maxValue,
      String? unit,
      List<Attachment> attachments});
}

/// @nodoc
class _$ExpectedResultItemCopyWithImpl<$Res>
    implements $ExpectedResultItemCopyWith<$Res> {
  _$ExpectedResultItemCopyWithImpl(this._self, this._then);

  final ExpectedResultItem _self;
  final $Res Function(ExpectedResultItem) _then;

  /// Create a copy of ExpectedResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? observation = null,
    Object? answerType = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
    Object? attachments = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      observation: null == observation
          ? _self.observation
          : observation // ignore: cast_nullable_to_non_nullable
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
      attachments: null == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ExpectedResultItem implements ExpectedResultItem {
  const _ExpectedResultItem(
      {required this.id,
      this.order = 0,
      this.observation = '',
      this.answerType = AnswerType.none,
      this.minValue,
      this.maxValue,
      this.unit,
      final List<Attachment> attachments = const []})
      : _attachments = attachments;
  factory _ExpectedResultItem.fromJson(Map<String, dynamic> json) =>
      _$ExpectedResultItemFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final int order;

  /// The observation or question text. Supports inline markup:
  ///   **bold**, *italic*, __underline__, [color=#RRGGBB]text[/color]
  /// and attachment placeholders: [📎 label](attachment:id)
  @override
  @JsonKey()
  final String observation;
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
  final List<Attachment> _attachments;
  @override
  @JsonKey()
  List<Attachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  /// Create a copy of ExpectedResultItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExpectedResultItemCopyWith<_ExpectedResultItem> get copyWith =>
      __$ExpectedResultItemCopyWithImpl<_ExpectedResultItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExpectedResultItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpectedResultItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.observation, observation) ||
                other.observation == observation) &&
            (identical(other.answerType, answerType) ||
                other.answerType == answerType) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      order,
      observation,
      answerType,
      minValue,
      maxValue,
      unit,
      const DeepCollectionEquality().hash(_attachments));

  @override
  String toString() {
    return 'ExpectedResultItem(id: $id, order: $order, observation: $observation, answerType: $answerType, minValue: $minValue, maxValue: $maxValue, unit: $unit, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class _$ExpectedResultItemCopyWith<$Res>
    implements $ExpectedResultItemCopyWith<$Res> {
  factory _$ExpectedResultItemCopyWith(
          _ExpectedResultItem value, $Res Function(_ExpectedResultItem) _then) =
      __$ExpectedResultItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      int order,
      String observation,
      AnswerType answerType,
      double? minValue,
      double? maxValue,
      String? unit,
      List<Attachment> attachments});
}

/// @nodoc
class __$ExpectedResultItemCopyWithImpl<$Res>
    implements _$ExpectedResultItemCopyWith<$Res> {
  __$ExpectedResultItemCopyWithImpl(this._self, this._then);

  final _ExpectedResultItem _self;
  final $Res Function(_ExpectedResultItem) _then;

  /// Create a copy of ExpectedResultItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? observation = null,
    Object? answerType = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? unit = freezed,
    Object? attachments = null,
  }) {
    return _then(_ExpectedResultItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      observation: null == observation
          ? _self.observation
          : observation // ignore: cast_nullable_to_non_nullable
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
      attachments: null == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

// dart format on
