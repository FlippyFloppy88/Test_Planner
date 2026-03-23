// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProcedureItem {
  String get id;
  int get order;
  String get text;
  List<Attachment> get attachments;

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProcedureItemCopyWith<ProcedureItem> get copyWith =>
      _$ProcedureItemCopyWithImpl<ProcedureItem>(
          this as ProcedureItem, _$identity);

  /// Serializes this ProcedureItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProcedureItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality()
                .equals(other.attachments, attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, order, text,
      const DeepCollectionEquality().hash(attachments));

  @override
  String toString() {
    return 'ProcedureItem(id: $id, order: $order, text: $text, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class $ProcedureItemCopyWith<$Res> {
  factory $ProcedureItemCopyWith(
          ProcedureItem value, $Res Function(ProcedureItem) _then) =
      _$ProcedureItemCopyWithImpl;
  @useResult
  $Res call({String id, int order, String text, List<Attachment> attachments});
}

/// @nodoc
class _$ProcedureItemCopyWithImpl<$Res>
    implements $ProcedureItemCopyWith<$Res> {
  _$ProcedureItemCopyWithImpl(this._self, this._then);

  final ProcedureItem _self;
  final $Res Function(ProcedureItem) _then;

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? text = null,
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
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ProcedureItem implements ProcedureItem {
  const _ProcedureItem(
      {required this.id,
      this.order = 0,
      this.text = '',
      final List<Attachment> attachments = const []})
      : _attachments = attachments;
  factory _ProcedureItem.fromJson(Map<String, dynamic> json) =>
      _$ProcedureItemFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final int order;
  @override
  @JsonKey()
  final String text;
  final List<Attachment> _attachments;
  @override
  @JsonKey()
  List<Attachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProcedureItemCopyWith<_ProcedureItem> get copyWith =>
      __$ProcedureItemCopyWithImpl<_ProcedureItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProcedureItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProcedureItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, order, text,
      const DeepCollectionEquality().hash(_attachments));

  @override
  String toString() {
    return 'ProcedureItem(id: $id, order: $order, text: $text, attachments: $attachments)';
  }
}

/// @nodoc
abstract mixin class _$ProcedureItemCopyWith<$Res>
    implements $ProcedureItemCopyWith<$Res> {
  factory _$ProcedureItemCopyWith(
          _ProcedureItem value, $Res Function(_ProcedureItem) _then) =
      __$ProcedureItemCopyWithImpl;
  @override
  @useResult
  $Res call({String id, int order, String text, List<Attachment> attachments});
}

/// @nodoc
class __$ProcedureItemCopyWithImpl<$Res>
    implements _$ProcedureItemCopyWith<$Res> {
  __$ProcedureItemCopyWithImpl(this._self, this._then);

  final _ProcedureItem _self;
  final $Res Function(_ProcedureItem) _then;

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? text = null,
    Object? attachments = null,
  }) {
    return _then(_ProcedureItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

// dart format on
