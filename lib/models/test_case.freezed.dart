// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestCase _$TestCaseFromJson(Map<String, dynamic> json) {
  return _TestCase.fromJson(json);
}

/// @nodoc
mixin _$TestCase {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Ordered precondition procedure items (shown at test-case level)
  List<ProcedureItem> get preconditions => throw _privateConstructorUsedError;

  /// Jira story / bug links associated with this test case.
  /// Auto-populated from step storyLinks but can also be added manually.
  List<String> get jiraLinks => throw _privateConstructorUsedError;
  List<TestStep> get steps => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TestCase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestCaseCopyWith<TestCase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestCaseCopyWith<$Res> {
  factory $TestCaseCopyWith(TestCase value, $Res Function(TestCase) then) =
      _$TestCaseCopyWithImpl<$Res, TestCase>;
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
class _$TestCaseCopyWithImpl<$Res, $Val extends TestCase>
    implements $TestCaseCopyWith<$Res> {
  _$TestCaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
      preconditions: null == preconditions
          ? _value.preconditions
          : preconditions // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      jiraLinks: null == jiraLinks
          ? _value.jiraLinks
          : jiraLinks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
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
abstract class _$$TestCaseImplCopyWith<$Res>
    implements $TestCaseCopyWith<$Res> {
  factory _$$TestCaseImplCopyWith(
          _$TestCaseImpl value, $Res Function(_$TestCaseImpl) then) =
      __$$TestCaseImplCopyWithImpl<$Res>;
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
class __$$TestCaseImplCopyWithImpl<$Res>
    extends _$TestCaseCopyWithImpl<$Res, _$TestCaseImpl>
    implements _$$TestCaseImplCopyWith<$Res> {
  __$$TestCaseImplCopyWithImpl(
      _$TestCaseImpl _value, $Res Function(_$TestCaseImpl) _then)
      : super(_value, _then);

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
    return _then(_$TestCaseImpl(
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
      preconditions: null == preconditions
          ? _value._preconditions
          : preconditions // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      jiraLinks: null == jiraLinks
          ? _value._jiraLinks
          : jiraLinks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
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
class _$TestCaseImpl implements _TestCase {
  const _$TestCaseImpl(
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

  factory _$TestCaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestCaseImplFromJson(json);

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

  @override
  String toString() {
    return 'TestCase(id: $id, name: $name, description: $description, preconditions: $preconditions, jiraLinks: $jiraLinks, steps: $steps, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestCaseImpl &&
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

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestCaseImplCopyWith<_$TestCaseImpl> get copyWith =>
      __$$TestCaseImplCopyWithImpl<_$TestCaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestCaseImplToJson(
      this,
    );
  }
}

abstract class _TestCase implements TestCase {
  const factory _TestCase(
      {required final String id,
      final String name,
      final String description,
      final List<ProcedureItem> preconditions,
      final List<String> jiraLinks,
      final List<TestStep> steps,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$TestCaseImpl;

  factory _TestCase.fromJson(Map<String, dynamic> json) =
      _$TestCaseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;

  /// Ordered precondition procedure items (shown at test-case level)
  @override
  List<ProcedureItem> get preconditions;

  /// Jira story / bug links associated with this test case.
  /// Auto-populated from step storyLinks but can also be added manually.
  @override
  List<String> get jiraLinks;
  @override
  List<TestStep> get steps;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of TestCase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestCaseImplCopyWith<_$TestCaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
