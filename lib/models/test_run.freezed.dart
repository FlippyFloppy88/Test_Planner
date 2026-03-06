// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StepResult _$StepResultFromJson(Map<String, dynamic> json) {
  return _StepResult.fromJson(json);
}

/// @nodoc
mixin _$StepResult {
  String get stepId => throw _privateConstructorUsedError;
  String get stepName => throw _privateConstructorUsedError;
  String get testCaseId => throw _privateConstructorUsedError;
  String get testCaseName => throw _privateConstructorUsedError;
  StepResultStatus get status => throw _privateConstructorUsedError;

  /// Procedure items to display during execution
  List<ProcedureItem> get procedure => throw _privateConstructorUsedError;

  /// Actual value entered by the user (for value-type answers)
  String? get actualValue => throw _privateConstructorUsedError;

  /// Actual pass/fail answer
  bool? get actualPassFail => throw _privateConstructorUsedError;
  String get failureDescription => throw _privateConstructorUsedError;
  String get jiraBugLink => throw _privateConstructorUsedError;
  bool get bugRecordedInJira => throw _privateConstructorUsedError;
  String? get storyLink => throw _privateConstructorUsedError;
  ExpectedResult get expectedResult => throw _privateConstructorUsedError;

  /// Serializes this StepResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StepResultCopyWith<StepResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepResultCopyWith<$Res> {
  factory $StepResultCopyWith(
          StepResult value, $Res Function(StepResult) then) =
      _$StepResultCopyWithImpl<$Res, StepResult>;
  @useResult
  $Res call(
      {String stepId,
      String stepName,
      String testCaseId,
      String testCaseName,
      StepResultStatus status,
      List<ProcedureItem> procedure,
      String? actualValue,
      bool? actualPassFail,
      String failureDescription,
      String jiraBugLink,
      bool bugRecordedInJira,
      String? storyLink,
      ExpectedResult expectedResult});

  $ExpectedResultCopyWith<$Res> get expectedResult;
}

/// @nodoc
class _$StepResultCopyWithImpl<$Res, $Val extends StepResult>
    implements $StepResultCopyWith<$Res> {
  _$StepResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepId = null,
    Object? stepName = null,
    Object? testCaseId = null,
    Object? testCaseName = null,
    Object? status = null,
    Object? procedure = null,
    Object? actualValue = freezed,
    Object? actualPassFail = freezed,
    Object? failureDescription = null,
    Object? jiraBugLink = null,
    Object? bugRecordedInJira = null,
    Object? storyLink = freezed,
    Object? expectedResult = null,
  }) {
    return _then(_value.copyWith(
      stepId: null == stepId
          ? _value.stepId
          : stepId // ignore: cast_nullable_to_non_nullable
              as String,
      stepName: null == stepName
          ? _value.stepName
          : stepName // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseId: null == testCaseId
          ? _value.testCaseId
          : testCaseId // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseName: null == testCaseName
          ? _value.testCaseName
          : testCaseName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StepResultStatus,
      procedure: null == procedure
          ? _value.procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      actualValue: freezed == actualValue
          ? _value.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as String?,
      actualPassFail: freezed == actualPassFail
          ? _value.actualPassFail
          : actualPassFail // ignore: cast_nullable_to_non_nullable
              as bool?,
      failureDescription: null == failureDescription
          ? _value.failureDescription
          : failureDescription // ignore: cast_nullable_to_non_nullable
              as String,
      jiraBugLink: null == jiraBugLink
          ? _value.jiraBugLink
          : jiraBugLink // ignore: cast_nullable_to_non_nullable
              as String,
      bugRecordedInJira: null == bugRecordedInJira
          ? _value.bugRecordedInJira
          : bugRecordedInJira // ignore: cast_nullable_to_non_nullable
              as bool,
      storyLink: freezed == storyLink
          ? _value.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedResult: null == expectedResult
          ? _value.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
    ) as $Val);
  }

  /// Create a copy of StepResult
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
abstract class _$$StepResultImplCopyWith<$Res>
    implements $StepResultCopyWith<$Res> {
  factory _$$StepResultImplCopyWith(
          _$StepResultImpl value, $Res Function(_$StepResultImpl) then) =
      __$$StepResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stepId,
      String stepName,
      String testCaseId,
      String testCaseName,
      StepResultStatus status,
      List<ProcedureItem> procedure,
      String? actualValue,
      bool? actualPassFail,
      String failureDescription,
      String jiraBugLink,
      bool bugRecordedInJira,
      String? storyLink,
      ExpectedResult expectedResult});

  @override
  $ExpectedResultCopyWith<$Res> get expectedResult;
}

/// @nodoc
class __$$StepResultImplCopyWithImpl<$Res>
    extends _$StepResultCopyWithImpl<$Res, _$StepResultImpl>
    implements _$$StepResultImplCopyWith<$Res> {
  __$$StepResultImplCopyWithImpl(
      _$StepResultImpl _value, $Res Function(_$StepResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepId = null,
    Object? stepName = null,
    Object? testCaseId = null,
    Object? testCaseName = null,
    Object? status = null,
    Object? procedure = null,
    Object? actualValue = freezed,
    Object? actualPassFail = freezed,
    Object? failureDescription = null,
    Object? jiraBugLink = null,
    Object? bugRecordedInJira = null,
    Object? storyLink = freezed,
    Object? expectedResult = null,
  }) {
    return _then(_$StepResultImpl(
      stepId: null == stepId
          ? _value.stepId
          : stepId // ignore: cast_nullable_to_non_nullable
              as String,
      stepName: null == stepName
          ? _value.stepName
          : stepName // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseId: null == testCaseId
          ? _value.testCaseId
          : testCaseId // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseName: null == testCaseName
          ? _value.testCaseName
          : testCaseName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StepResultStatus,
      procedure: null == procedure
          ? _value._procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      actualValue: freezed == actualValue
          ? _value.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as String?,
      actualPassFail: freezed == actualPassFail
          ? _value.actualPassFail
          : actualPassFail // ignore: cast_nullable_to_non_nullable
              as bool?,
      failureDescription: null == failureDescription
          ? _value.failureDescription
          : failureDescription // ignore: cast_nullable_to_non_nullable
              as String,
      jiraBugLink: null == jiraBugLink
          ? _value.jiraBugLink
          : jiraBugLink // ignore: cast_nullable_to_non_nullable
              as String,
      bugRecordedInJira: null == bugRecordedInJira
          ? _value.bugRecordedInJira
          : bugRecordedInJira // ignore: cast_nullable_to_non_nullable
              as bool,
      storyLink: freezed == storyLink
          ? _value.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedResult: null == expectedResult
          ? _value.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StepResultImpl implements _StepResult {
  const _$StepResultImpl(
      {required this.stepId,
      required this.stepName,
      required this.testCaseId,
      required this.testCaseName,
      this.status = StepResultStatus.notRun,
      final List<ProcedureItem> procedure = const [],
      this.actualValue,
      this.actualPassFail,
      this.failureDescription = '',
      this.jiraBugLink = '',
      this.bugRecordedInJira = false,
      this.storyLink,
      required this.expectedResult})
      : _procedure = procedure;

  factory _$StepResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepResultImplFromJson(json);

  @override
  final String stepId;
  @override
  final String stepName;
  @override
  final String testCaseId;
  @override
  final String testCaseName;
  @override
  @JsonKey()
  final StepResultStatus status;

  /// Procedure items to display during execution
  final List<ProcedureItem> _procedure;

  /// Procedure items to display during execution
  @override
  @JsonKey()
  List<ProcedureItem> get procedure {
    if (_procedure is EqualUnmodifiableListView) return _procedure;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_procedure);
  }

  /// Actual value entered by the user (for value-type answers)
  @override
  final String? actualValue;

  /// Actual pass/fail answer
  @override
  final bool? actualPassFail;
  @override
  @JsonKey()
  final String failureDescription;
  @override
  @JsonKey()
  final String jiraBugLink;
  @override
  @JsonKey()
  final bool bugRecordedInJira;
  @override
  final String? storyLink;
  @override
  final ExpectedResult expectedResult;

  @override
  String toString() {
    return 'StepResult(stepId: $stepId, stepName: $stepName, testCaseId: $testCaseId, testCaseName: $testCaseName, status: $status, procedure: $procedure, actualValue: $actualValue, actualPassFail: $actualPassFail, failureDescription: $failureDescription, jiraBugLink: $jiraBugLink, bugRecordedInJira: $bugRecordedInJira, storyLink: $storyLink, expectedResult: $expectedResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepResultImpl &&
            (identical(other.stepId, stepId) || other.stepId == stepId) &&
            (identical(other.stepName, stepName) ||
                other.stepName == stepName) &&
            (identical(other.testCaseId, testCaseId) ||
                other.testCaseId == testCaseId) &&
            (identical(other.testCaseName, testCaseName) ||
                other.testCaseName == testCaseName) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._procedure, _procedure) &&
            (identical(other.actualValue, actualValue) ||
                other.actualValue == actualValue) &&
            (identical(other.actualPassFail, actualPassFail) ||
                other.actualPassFail == actualPassFail) &&
            (identical(other.failureDescription, failureDescription) ||
                other.failureDescription == failureDescription) &&
            (identical(other.jiraBugLink, jiraBugLink) ||
                other.jiraBugLink == jiraBugLink) &&
            (identical(other.bugRecordedInJira, bugRecordedInJira) ||
                other.bugRecordedInJira == bugRecordedInJira) &&
            (identical(other.storyLink, storyLink) ||
                other.storyLink == storyLink) &&
            (identical(other.expectedResult, expectedResult) ||
                other.expectedResult == expectedResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stepId,
      stepName,
      testCaseId,
      testCaseName,
      status,
      const DeepCollectionEquality().hash(_procedure),
      actualValue,
      actualPassFail,
      failureDescription,
      jiraBugLink,
      bugRecordedInJira,
      storyLink,
      expectedResult);

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StepResultImplCopyWith<_$StepResultImpl> get copyWith =>
      __$$StepResultImplCopyWithImpl<_$StepResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepResultImplToJson(
      this,
    );
  }
}

abstract class _StepResult implements StepResult {
  const factory _StepResult(
      {required final String stepId,
      required final String stepName,
      required final String testCaseId,
      required final String testCaseName,
      final StepResultStatus status,
      final List<ProcedureItem> procedure,
      final String? actualValue,
      final bool? actualPassFail,
      final String failureDescription,
      final String jiraBugLink,
      final bool bugRecordedInJira,
      final String? storyLink,
      required final ExpectedResult expectedResult}) = _$StepResultImpl;

  factory _StepResult.fromJson(Map<String, dynamic> json) =
      _$StepResultImpl.fromJson;

  @override
  String get stepId;
  @override
  String get stepName;
  @override
  String get testCaseId;
  @override
  String get testCaseName;
  @override
  StepResultStatus get status;

  /// Procedure items to display during execution
  @override
  List<ProcedureItem> get procedure;

  /// Actual value entered by the user (for value-type answers)
  @override
  String? get actualValue;

  /// Actual pass/fail answer
  @override
  bool? get actualPassFail;
  @override
  String get failureDescription;
  @override
  String get jiraBugLink;
  @override
  bool get bugRecordedInJira;
  @override
  String? get storyLink;
  @override
  ExpectedResult get expectedResult;

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StepResultImplCopyWith<_$StepResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TestRun _$TestRunFromJson(Map<String, dynamic> json) {
  return _TestRun.fromJson(json);
}

/// @nodoc
mixin _$TestRun {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// 'test_plan' | 'release_plan'
  String get sourceType => throw _privateConstructorUsedError;
  String get sourceName => throw _privateConstructorUsedError;
  String? get releaseVersion => throw _privateConstructorUsedError;
  DateTime get executedAt => throw _privateConstructorUsedError;
  List<StepResult> get stepResults => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  /// Serializes this TestRun to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestRunCopyWith<TestRun> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestRunCopyWith<$Res> {
  factory $TestRunCopyWith(TestRun value, $Res Function(TestRun) then) =
      _$TestRunCopyWithImpl<$Res, TestRun>;
  @useResult
  $Res call(
      {String id,
      String name,
      String sourceType,
      String sourceName,
      String? releaseVersion,
      DateTime executedAt,
      List<StepResult> stepResults,
      bool isComplete});
}

/// @nodoc
class _$TestRunCopyWithImpl<$Res, $Val extends TestRun>
    implements $TestRunCopyWith<$Res> {
  _$TestRunCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceType = null,
    Object? sourceName = null,
    Object? releaseVersion = freezed,
    Object? executedAt = null,
    Object? stepResults = null,
    Object? isComplete = null,
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
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      releaseVersion: freezed == releaseVersion
          ? _value.releaseVersion
          : releaseVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      executedAt: null == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stepResults: null == stepResults
          ? _value.stepResults
          : stepResults // ignore: cast_nullable_to_non_nullable
              as List<StepResult>,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestRunImplCopyWith<$Res> implements $TestRunCopyWith<$Res> {
  factory _$$TestRunImplCopyWith(
          _$TestRunImpl value, $Res Function(_$TestRunImpl) then) =
      __$$TestRunImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String sourceType,
      String sourceName,
      String? releaseVersion,
      DateTime executedAt,
      List<StepResult> stepResults,
      bool isComplete});
}

/// @nodoc
class __$$TestRunImplCopyWithImpl<$Res>
    extends _$TestRunCopyWithImpl<$Res, _$TestRunImpl>
    implements _$$TestRunImplCopyWith<$Res> {
  __$$TestRunImplCopyWithImpl(
      _$TestRunImpl _value, $Res Function(_$TestRunImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceType = null,
    Object? sourceName = null,
    Object? releaseVersion = freezed,
    Object? executedAt = null,
    Object? stepResults = null,
    Object? isComplete = null,
  }) {
    return _then(_$TestRunImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      releaseVersion: freezed == releaseVersion
          ? _value.releaseVersion
          : releaseVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      executedAt: null == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stepResults: null == stepResults
          ? _value._stepResults
          : stepResults // ignore: cast_nullable_to_non_nullable
              as List<StepResult>,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestRunImpl extends _TestRun {
  const _$TestRunImpl(
      {required this.id,
      required this.name,
      this.sourceType = 'test_plan',
      required this.sourceName,
      this.releaseVersion,
      required this.executedAt,
      final List<StepResult> stepResults = const [],
      this.isComplete = false})
      : _stepResults = stepResults,
        super._();

  factory _$TestRunImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestRunImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  /// 'test_plan' | 'release_plan'
  @override
  @JsonKey()
  final String sourceType;
  @override
  final String sourceName;
  @override
  final String? releaseVersion;
  @override
  final DateTime executedAt;
  final List<StepResult> _stepResults;
  @override
  @JsonKey()
  List<StepResult> get stepResults {
    if (_stepResults is EqualUnmodifiableListView) return _stepResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stepResults);
  }

  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'TestRun(id: $id, name: $name, sourceType: $sourceType, sourceName: $sourceName, releaseVersion: $releaseVersion, executedAt: $executedAt, stepResults: $stepResults, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestRunImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.releaseVersion, releaseVersion) ||
                other.releaseVersion == releaseVersion) &&
            (identical(other.executedAt, executedAt) ||
                other.executedAt == executedAt) &&
            const DeepCollectionEquality()
                .equals(other._stepResults, _stepResults) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      sourceType,
      sourceName,
      releaseVersion,
      executedAt,
      const DeepCollectionEquality().hash(_stepResults),
      isComplete);

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestRunImplCopyWith<_$TestRunImpl> get copyWith =>
      __$$TestRunImplCopyWithImpl<_$TestRunImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestRunImplToJson(
      this,
    );
  }
}

abstract class _TestRun extends TestRun {
  const factory _TestRun(
      {required final String id,
      required final String name,
      final String sourceType,
      required final String sourceName,
      final String? releaseVersion,
      required final DateTime executedAt,
      final List<StepResult> stepResults,
      final bool isComplete}) = _$TestRunImpl;
  const _TestRun._() : super._();

  factory _TestRun.fromJson(Map<String, dynamic> json) = _$TestRunImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// 'test_plan' | 'release_plan'
  @override
  String get sourceType;
  @override
  String get sourceName;
  @override
  String? get releaseVersion;
  @override
  DateTime get executedAt;
  @override
  List<StepResult> get stepResults;
  @override
  bool get isComplete;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestRunImplCopyWith<_$TestRunImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
