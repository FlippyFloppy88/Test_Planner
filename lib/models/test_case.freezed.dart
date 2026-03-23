// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestCase {
  String get id;
  String get name;
  String get description;

  /// Ordered precondition procedure items (shown at test-case level)
  List<ProcedureItem> get preconditions;

  /// Jira story / bug links associated with this test case.
  /// Auto-populated from step storyLinks but can also be added manually.
  List<String> get jiraLinks;
  List<TestStep> get steps;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestCaseCopyWith<TestCase> get copyWith =>
      _$TestCaseCopyWithImpl<TestCase>(this as TestCase, _$identity);

  /// Serializes this TestCase to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestCase &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.preconditions, preconditions) &&
            const DeepCollectionEquality().equals(other.jiraLinks, jiraLinks) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(preconditions),
      const DeepCollectionEquality().hash(jiraLinks),
      const DeepCollectionEquality().hash(steps),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'TestCase(id: $id, name: $name, description: $description, preconditions: $preconditions, jiraLinks: $jiraLinks, steps: $steps, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $TestCaseCopyWith<$Res> {
  factory $TestCaseCopyWith(TestCase value, $Res Function(TestCase) _then) =
      _$TestCaseCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<ProcedureItem> preconditions,
      List<String> jiraLinks,
      List<TestStep> steps,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$TestCaseCopyWithImpl<$Res> implements $TestCaseCopyWith<$Res> {
  _$TestCaseCopyWithImpl(this._self, this._then);

  final TestCase _self;
  final $Res Function(TestCase) _then;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? preconditions = null,
    Object? jiraLinks = null,
    Object? steps = null,
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
      preconditions: null == preconditions
          ? _self.preconditions
          : preconditions // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      jiraLinks: null == jiraLinks
          ? _self.jiraLinks
          : jiraLinks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
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
class _TestCase implements TestCase {
  const _TestCase(
      {required this.id,
      this.name = '',
      this.description = '',
      final List<ProcedureItem> preconditions = const [],
      final List<String> jiraLinks = const [],
      final List<TestStep> steps = const [],
      required this.createdAt,
      required this.updatedAt})
      : _preconditions = preconditions,
        _jiraLinks = jiraLinks,
        _steps = steps;
  factory _TestCase.fromJson(Map<String, dynamic> json) =>
      _$TestCaseFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;

  /// Ordered precondition procedure items (shown at test-case level)
  final List<ProcedureItem> _preconditions;

  /// Ordered precondition procedure items (shown at test-case level)
  @override
  @JsonKey()
  List<ProcedureItem> get preconditions {
    if (_preconditions is EqualUnmodifiableListView) return _preconditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preconditions);
  }

  /// Jira story / bug links associated with this test case.
  /// Auto-populated from step storyLinks but can also be added manually.
  final List<String> _jiraLinks;

  /// Jira story / bug links associated with this test case.
  /// Auto-populated from step storyLinks but can also be added manually.
  @override
  @JsonKey()
  List<String> get jiraLinks {
    if (_jiraLinks is EqualUnmodifiableListView) return _jiraLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_jiraLinks);
  }

  final List<TestStep> _steps;
  @override
  @JsonKey()
  List<TestStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TestCaseCopyWith<_TestCase> get copyWith =>
      __$TestCaseCopyWithImpl<_TestCase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TestCaseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestCase &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._preconditions, _preconditions) &&
            const DeepCollectionEquality()
                .equals(other._jiraLinks, _jiraLinks) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_preconditions),
      const DeepCollectionEquality().hash(_jiraLinks),
      const DeepCollectionEquality().hash(_steps),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'TestCase(id: $id, name: $name, description: $description, preconditions: $preconditions, jiraLinks: $jiraLinks, steps: $steps, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$TestCaseCopyWith<$Res>
    implements $TestCaseCopyWith<$Res> {
  factory _$TestCaseCopyWith(_TestCase value, $Res Function(_TestCase) _then) =
      __$TestCaseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<ProcedureItem> preconditions,
      List<String> jiraLinks,
      List<TestStep> steps,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$TestCaseCopyWithImpl<$Res> implements _$TestCaseCopyWith<$Res> {
  __$TestCaseCopyWithImpl(this._self, this._then);

  final _TestCase _self;
  final $Res Function(_TestCase) _then;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? preconditions = null,
    Object? jiraLinks = null,
    Object? steps = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_TestCase(
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
      preconditions: null == preconditions
          ? _self._preconditions
          : preconditions // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      jiraLinks: null == jiraLinks
          ? _self._jiraLinks
          : jiraLinks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
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
