// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestStep _$TestStepFromJson(Map<String, dynamic> json) {
  return _TestStep.fromJson(json);
}

/// @nodoc
mixin _$TestStep {
  String get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Optional ordered procedure steps with text and image attachments
  List<ProcedureItem> get procedure => throw _privateConstructorUsedError;
  ExpectedResult get expectedResult => throw _privateConstructorUsedError;

  /// Optional link to a Jira story or bug
  String get storyLink => throw _privateConstructorUsedError;

  /// Recursively nested sub-steps
  List<TestStep> get subSteps => throw _privateConstructorUsedError;

  /// Serializes this TestStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestStepCopyWith<TestStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestStepCopyWith<$Res> {
  factory $TestStepCopyWith(TestStep value, $Res Function(TestStep) then) =
      _$TestStepCopyWithImpl<$Res, TestStep>;
  @useResult
  $Res call(
      {String id,
      int order,
      String name,
      List<ProcedureItem> procedure,
      ExpectedResult expectedResult,
      String storyLink,
      List<TestStep> subSteps});

  $ExpectedResultCopyWith<$Res> get expectedResult;
}

/// @nodoc
class _$TestStepCopyWithImpl<$Res, $Val extends TestStep>
    implements $TestStepCopyWith<$Res> {
  _$TestStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? name = null,
    Object? procedure = null,
    Object? expectedResult = null,
    Object? storyLink = null,
    Object? subSteps = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      procedure: null == procedure
          ? _value.procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      expectedResult: null == expectedResult
          ? _value.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
      storyLink: null == storyLink
          ? _value.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String,
      subSteps: null == subSteps
          ? _value.subSteps
          : subSteps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
    ) as $Val);
  }

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpectedResultCopyWith<$Res> get expectedResult {
    return $ExpectedResultCopyWith<$Res>(_value.expectedResult, (value) {
      return _then(_value.copyWith(expectedResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestStepImplCopyWith<$Res>
    implements $TestStepCopyWith<$Res> {
  factory _$$TestStepImplCopyWith(
          _$TestStepImpl value, $Res Function(_$TestStepImpl) then) =
      __$$TestStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int order,
      String name,
      List<ProcedureItem> procedure,
      ExpectedResult expectedResult,
      String storyLink,
      List<TestStep> subSteps});

  @override
  $ExpectedResultCopyWith<$Res> get expectedResult;
}

/// @nodoc
class __$$TestStepImplCopyWithImpl<$Res>
    extends _$TestStepCopyWithImpl<$Res, _$TestStepImpl>
    implements _$$TestStepImplCopyWith<$Res> {
  __$$TestStepImplCopyWithImpl(
      _$TestStepImpl _value, $Res Function(_$TestStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? name = null,
    Object? procedure = null,
    Object? expectedResult = null,
    Object? storyLink = null,
    Object? subSteps = null,
  }) {
    return _then(_$TestStepImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      procedure: null == procedure
          ? _value._procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      expectedResult: null == expectedResult
          ? _value.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
      storyLink: null == storyLink
          ? _value.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String,
      subSteps: null == subSteps
          ? _value._subSteps
          : subSteps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestStepImpl implements _TestStep {
  const _$TestStepImpl(
      {required this.id,
      this.order = 1,
      this.name = '',
      final List<ProcedureItem> procedure = const [],
      required this.expectedResult,
      this.storyLink = '',
      final List<TestStep> subSteps = const []})
      : _procedure = procedure,
        _subSteps = subSteps;

  factory _$TestStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestStepImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final int order;
  @override
  @JsonKey()
  final String name;

  /// Optional ordered procedure steps with text and image attachments
  final List<ProcedureItem> _procedure;

  /// Optional ordered procedure steps with text and image attachments
  @override
  @JsonKey()
  List<ProcedureItem> get procedure {
    if (_procedure is EqualUnmodifiableListView) return _procedure;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_procedure);
  }

  @override
  final ExpectedResult expectedResult;

  /// Optional link to a Jira story or bug
  @override
  @JsonKey()
  final String storyLink;

  /// Recursively nested sub-steps
  final List<TestStep> _subSteps;

  /// Recursively nested sub-steps
  @override
  @JsonKey()
  List<TestStep> get subSteps {
    if (_subSteps is EqualUnmodifiableListView) return _subSteps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subSteps);
  }

  @override
  String toString() {
    return 'TestStep(id: $id, order: $order, name: $name, procedure: $procedure, expectedResult: $expectedResult, storyLink: $storyLink, subSteps: $subSteps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._procedure, _procedure) &&
            (identical(other.expectedResult, expectedResult) ||
                other.expectedResult == expectedResult) &&
            (identical(other.storyLink, storyLink) ||
                other.storyLink == storyLink) &&
            const DeepCollectionEquality().equals(other._subSteps, _subSteps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      order,
      name,
      const DeepCollectionEquality().hash(_procedure),
      expectedResult,
      storyLink,
      const DeepCollectionEquality().hash(_subSteps));

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestStepImplCopyWith<_$TestStepImpl> get copyWith =>
      __$$TestStepImplCopyWithImpl<_$TestStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestStepImplToJson(
      this,
    );
  }
}

abstract class _TestStep implements TestStep {
  const factory _TestStep(
      {required final String id,
      final int order,
      final String name,
      final List<ProcedureItem> procedure,
      required final ExpectedResult expectedResult,
      final String storyLink,
      final List<TestStep> subSteps}) = _$TestStepImpl;

  factory _TestStep.fromJson(Map<String, dynamic> json) =
      _$TestStepImpl.fromJson;

  @override
  String get id;
  @override
  int get order;
  @override
  String get name;

  /// Optional ordered procedure steps with text and image attachments
  @override
  List<ProcedureItem> get procedure;
  @override
  ExpectedResult get expectedResult;

  /// Optional link to a Jira story or bug
  @override
  String get storyLink;

  /// Recursively nested sub-steps
  @override
  List<TestStep> get subSteps;

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestStepImplCopyWith<_$TestStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
