// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestPlan {
  String get id;
  String get name;
  String get description;
  List<TestCase> get testCases;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestPlanCopyWith<TestPlan> get copyWith =>
      _$TestPlanCopyWithImpl<TestPlan>(this as TestPlan, _$identity);

  /// Serializes this TestPlan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestPlan &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.testCases, testCases) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(testCases), createdAt, updatedAt);

  @override
  String toString() {
    return 'TestPlan(id: $id, name: $name, description: $description, testCases: $testCases, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $TestPlanCopyWith<$Res> {
  factory $TestPlanCopyWith(TestPlan value, $Res Function(TestPlan) _then) =
      _$TestPlanCopyWithImpl;
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
class _$TestPlanCopyWithImpl<$Res> implements $TestPlanCopyWith<$Res> {
  _$TestPlanCopyWithImpl(this._self, this._then);

  final TestPlan _self;
  final $Res Function(TestPlan) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      testCases: null == testCases
          ? _self.testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<TestCase>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TestPlan implements TestPlan {
  const _TestPlan(
      {required this.id,
      this.name = '',
      this.description = '',
      final List<TestCase> testCases = const [],
      required this.createdAt,
      required this.updatedAt})
      : _testCases = testCases;
  factory _TestPlan.fromJson(Map<String, dynamic> json) =>
      _$TestPlanFromJson(json);

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

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TestPlanCopyWith<_TestPlan> get copyWith =>
      __$TestPlanCopyWithImpl<_TestPlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TestPlanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestPlan &&
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

  @override
  String toString() {
    return 'TestPlan(id: $id, name: $name, description: $description, testCases: $testCases, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$TestPlanCopyWith<$Res>
    implements $TestPlanCopyWith<$Res> {
  factory _$TestPlanCopyWith(_TestPlan value, $Res Function(_TestPlan) _then) =
      __$TestPlanCopyWithImpl;
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
class __$TestPlanCopyWithImpl<$Res> implements _$TestPlanCopyWith<$Res> {
  __$TestPlanCopyWithImpl(this._self, this._then);

  final _TestPlan _self;
  final $Res Function(_TestPlan) _then;

  /// Create a copy of TestPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? testCases = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_TestPlan(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      testCases: null == testCases
          ? _self._testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<TestCase>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
