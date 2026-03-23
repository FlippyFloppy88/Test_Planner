// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestStep {
  String get id;
  int get order;
  String get name;

  /// Optional ordered procedure steps with text and image attachments
  List<ProcedureItem> get procedure;
  ExpectedResult get expectedResult;

  /// Optional link to a Jira story or bug
  String get storyLink;

  /// Recursively nested sub-steps
  List<TestStep> get subSteps;

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestStepCopyWith<TestStep> get copyWith =>
      _$TestStepCopyWithImpl<TestStep>(this as TestStep, _$identity);

  /// Serializes this TestStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestStep &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.procedure, procedure) &&
            (identical(other.expectedResult, expectedResult) ||
                other.expectedResult == expectedResult) &&
            (identical(other.storyLink, storyLink) ||
                other.storyLink == storyLink) &&
            const DeepCollectionEquality().equals(other.subSteps, subSteps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      order,
      name,
      const DeepCollectionEquality().hash(procedure),
      expectedResult,
      storyLink,
      const DeepCollectionEquality().hash(subSteps));

  @override
  String toString() {
    return 'TestStep(id: $id, order: $order, name: $name, procedure: $procedure, expectedResult: $expectedResult, storyLink: $storyLink, subSteps: $subSteps)';
  }
}

/// @nodoc
abstract mixin class $TestStepCopyWith<$Res> {
  factory $TestStepCopyWith(TestStep value, $Res Function(TestStep) _then) =
      _$TestStepCopyWithImpl;
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
class _$TestStepCopyWithImpl<$Res> implements $TestStepCopyWith<$Res> {
  _$TestStepCopyWithImpl(this._self, this._then);

  final TestStep _self;
  final $Res Function(TestStep) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      procedure: null == procedure
          ? _self.procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      expectedResult: null == expectedResult
          ? _self.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
      storyLink: null == storyLink
          ? _self.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String,
      subSteps: null == subSteps
          ? _self.subSteps
          : subSteps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
    ));
  }

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpectedResultCopyWith<$Res> get expectedResult {
    return $ExpectedResultCopyWith<$Res>(_self.expectedResult, (value) {
      return _then(_self.copyWith(expectedResult: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TestStep implements TestStep {
  const _TestStep(
      {required this.id,
      this.order = 1,
      this.name = '',
      final List<ProcedureItem> procedure = const [],
      required this.expectedResult,
      this.storyLink = '',
      final List<TestStep> subSteps = const []})
      : _procedure = procedure,
        _subSteps = subSteps;
  factory _TestStep.fromJson(Map<String, dynamic> json) =>
      _$TestStepFromJson(json);

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

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TestStepCopyWith<_TestStep> get copyWith =>
      __$TestStepCopyWithImpl<_TestStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TestStepToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestStep &&
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

  @override
  String toString() {
    return 'TestStep(id: $id, order: $order, name: $name, procedure: $procedure, expectedResult: $expectedResult, storyLink: $storyLink, subSteps: $subSteps)';
  }
}

/// @nodoc
abstract mixin class _$TestStepCopyWith<$Res>
    implements $TestStepCopyWith<$Res> {
  factory _$TestStepCopyWith(_TestStep value, $Res Function(_TestStep) _then) =
      __$TestStepCopyWithImpl;
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
class __$TestStepCopyWithImpl<$Res> implements _$TestStepCopyWith<$Res> {
  __$TestStepCopyWithImpl(this._self, this._then);

  final _TestStep _self;
  final $Res Function(_TestStep) _then;

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? name = null,
    Object? procedure = null,
    Object? expectedResult = null,
    Object? storyLink = null,
    Object? subSteps = null,
  }) {
    return _then(_TestStep(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      procedure: null == procedure
          ? _self._procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      expectedResult: null == expectedResult
          ? _self.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
      storyLink: null == storyLink
          ? _self.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String,
      subSteps: null == subSteps
          ? _self._subSteps
          : subSteps // ignore: cast_nullable_to_non_nullable
              as List<TestStep>,
    ));
  }

  /// Create a copy of TestStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpectedResultCopyWith<$Res> get expectedResult {
    return $ExpectedResultCopyWith<$Res>(_self.expectedResult, (value) {
      return _then(_self.copyWith(expectedResult: value));
    });
  }
}

// dart format on
