// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestPlan _$TestPlanFromJson(Map<String, dynamic> json) {
  return _TestPlan.fromJson(json);
}

/// @nodoc
mixin _$TestPlan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<TestCase> get testCases => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TestPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestPlanCopyWith<TestPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestPlanCopyWith<$Res> {
  factory $TestPlanCopyWith(TestPlan value, $Res Function(TestPlan) then) =
      _$TestPlanCopyWithImpl<$Res, TestPlan>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<TestCase> testCases,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$TestPlanCopyWithImpl<$Res, $Val extends TestPlan>
    implements $TestPlanCopyWith<$Res> {
  _$TestPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? testCases = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      testCases: null == testCases
          ? _value.testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<TestCase>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestPlanImplCopyWith<$Res>
    implements $TestPlanCopyWith<$Res> {
  factory _$$TestPlanImplCopyWith(
          _$TestPlanImpl value, $Res Function(_$TestPlanImpl) then) =
      __$$TestPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<TestCase> testCases,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$TestPlanImplCopyWithImpl<$Res>
    extends _$TestPlanCopyWithImpl<$Res, _$TestPlanImpl>
    implements _$$TestPlanImplCopyWith<$Res> {
  __$$TestPlanImplCopyWithImpl(
      _$TestPlanImpl _value, $Res Function(_$TestPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? testCases = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TestPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      testCases: null == testCases
          ? _value._testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<TestCase>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestPlanImpl implements _TestPlan {
  const _$TestPlanImpl(
      {required this.id,
      this.name = '',
      this.description = '',
      final List<TestCase> testCases = const [],
      required this.createdAt,
      required this.updatedAt})
      : _testCases = testCases;

  factory _$TestPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestPlanImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  final List<TestCase> _testCases;
  @override
  @JsonKey()
  List<TestCase> get testCases {
    if (_testCases is EqualUnmodifiableListView) return _testCases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testCases);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TestPlan(id: $id, name: $name, description: $description, testCases: $testCases, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._testCases, _testCases) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(_testCases), createdAt, updatedAt);

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestPlanImplCopyWith<_$TestPlanImpl> get copyWith =>
      __$$TestPlanImplCopyWithImpl<_$TestPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestPlanImplToJson(
      this,
    );
  }
}

abstract class _TestPlan implements TestPlan {
  const factory _TestPlan(
      {required final String id,
      final String name,
      final String description,
      final List<TestCase> testCases,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$TestPlanImpl;

  factory _TestPlan.fromJson(Map<String, dynamic> json) =
      _$TestPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<TestCase> get testCases;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestPlanImplCopyWith<_$TestPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
