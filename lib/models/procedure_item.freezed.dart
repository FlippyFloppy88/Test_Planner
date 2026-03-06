// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProcedureItem _$ProcedureItemFromJson(Map<String, dynamic> json) {
  return _ProcedureItem.fromJson(json);
}

/// @nodoc
mixin _$ProcedureItem {
  String get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<Attachment> get attachments => throw _privateConstructorUsedError;

  /// Serializes this ProcedureItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcedureItemCopyWith<ProcedureItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureItemCopyWith<$Res> {
  factory $ProcedureItemCopyWith(
          ProcedureItem value, $Res Function(ProcedureItem) then) =
      _$ProcedureItemCopyWithImpl<$Res, ProcedureItem>;
  @useResult
  $Res call({String id, int order, String text, List<Attachment> attachments});
}

/// @nodoc
class _$ProcedureItemCopyWithImpl<$Res, $Val extends ProcedureItem>
    implements $ProcedureItemCopyWith<$Res> {
  _$ProcedureItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcedureItemImplCopyWith<$Res>
    implements $ProcedureItemCopyWith<$Res> {
  factory _$$ProcedureItemImplCopyWith(
          _$ProcedureItemImpl value, $Res Function(_$ProcedureItemImpl) then) =
      __$$ProcedureItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int order, String text, List<Attachment> attachments});
}

/// @nodoc
class __$$ProcedureItemImplCopyWithImpl<$Res>
    extends _$ProcedureItemCopyWithImpl<$Res, _$ProcedureItemImpl>
    implements _$$ProcedureItemImplCopyWith<$Res> {
  __$$ProcedureItemImplCopyWithImpl(
      _$ProcedureItemImpl _value, $Res Function(_$ProcedureItemImpl) _then)
      : super(_value, _then);

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
    return _then(_$ProcedureItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcedureItemImpl implements _ProcedureItem {
  const _$ProcedureItemImpl(
      {required this.id,
      this.order = 0,
      this.text = '',
      final List<Attachment> attachments = const []})
      : _attachments = attachments;

  factory _$ProcedureItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcedureItemImplFromJson(json);

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

  @override
  String toString() {
    return 'ProcedureItem(id: $id, order: $order, text: $text, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcedureItemImpl &&
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

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcedureItemImplCopyWith<_$ProcedureItemImpl> get copyWith =>
      __$$ProcedureItemImplCopyWithImpl<_$ProcedureItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcedureItemImplToJson(
      this,
    );
  }
}

abstract class _ProcedureItem implements ProcedureItem {
  const factory _ProcedureItem(
      {required final String id,
      final int order,
      final String text,
      final List<Attachment> attachments}) = _$ProcedureItemImpl;

  factory _ProcedureItem.fromJson(Map<String, dynamic> json) =
      _$ProcedureItemImpl.fromJson;

  @override
  String get id;
  @override
  int get order;
  @override
  String get text;
  @override
  List<Attachment> get attachments;

  /// Create a copy of ProcedureItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcedureItemImplCopyWith<_$ProcedureItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
