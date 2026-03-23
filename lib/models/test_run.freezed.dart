// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepResult {
  String get stepId;
  String get stepName;
  String get testCaseId;
  String get testCaseName;
  StepResultStatus get status;

  /// Procedure items to display during execution
  List<ProcedureItem> get procedure;

  /// Actual value entered by the user (for value-type answers)
  String? get actualValue;

  /// Actual pass/fail answer
  bool? get actualPassFail;
  String get failureDescription;
  String get jiraBugLink;
  bool get bugRecordedInJira;
  String? get storyLink;
  ExpectedResult get expectedResult;

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StepResultCopyWith<StepResult> get copyWith =>
      _$StepResultCopyWithImpl<StepResult>(this as StepResult, _$identity);

  /// Serializes this StepResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StepResult &&
            (identical(other.stepId, stepId) || other.stepId == stepId) &&
            (identical(other.stepName, stepName) ||
                other.stepName == stepName) &&
            (identical(other.testCaseId, testCaseId) ||
                other.testCaseId == testCaseId) &&
            (identical(other.testCaseName, testCaseName) ||
                other.testCaseName == testCaseName) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.procedure, procedure) &&
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
      const DeepCollectionEquality().hash(procedure),
      actualValue,
      actualPassFail,
      failureDescription,
      jiraBugLink,
      bugRecordedInJira,
      storyLink,
      expectedResult);

  @override
  String toString() {
    return 'StepResult(stepId: $stepId, stepName: $stepName, testCaseId: $testCaseId, testCaseName: $testCaseName, status: $status, procedure: $procedure, actualValue: $actualValue, actualPassFail: $actualPassFail, failureDescription: $failureDescription, jiraBugLink: $jiraBugLink, bugRecordedInJira: $bugRecordedInJira, storyLink: $storyLink, expectedResult: $expectedResult)';
  }
}

/// @nodoc
abstract mixin class $StepResultCopyWith<$Res> {
  factory $StepResultCopyWith(
          StepResult value, $Res Function(StepResult) _then) =
      _$StepResultCopyWithImpl;
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
class _$StepResultCopyWithImpl<$Res> implements $StepResultCopyWith<$Res> {
  _$StepResultCopyWithImpl(this._self, this._then);

  final StepResult _self;
  final $Res Function(StepResult) _then;

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
    return _then(_self.copyWith(
      stepId: null == stepId
          ? _self.stepId
          : stepId // ignore: cast_nullable_to_non_nullable
              as String,
      stepName: null == stepName
          ? _self.stepName
          : stepName // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseId: null == testCaseId
          ? _self.testCaseId
          : testCaseId // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseName: null == testCaseName
          ? _self.testCaseName
          : testCaseName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as StepResultStatus,
      procedure: null == procedure
          ? _self.procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      actualValue: freezed == actualValue
          ? _self.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as String?,
      actualPassFail: freezed == actualPassFail
          ? _self.actualPassFail
          : actualPassFail // ignore: cast_nullable_to_non_nullable
              as bool?,
      failureDescription: null == failureDescription
          ? _self.failureDescription
          : failureDescription // ignore: cast_nullable_to_non_nullable
              as String,
      jiraBugLink: null == jiraBugLink
          ? _self.jiraBugLink
          : jiraBugLink // ignore: cast_nullable_to_non_nullable
              as String,
      bugRecordedInJira: null == bugRecordedInJira
          ? _self.bugRecordedInJira
          : bugRecordedInJira // ignore: cast_nullable_to_non_nullable
              as bool,
      storyLink: freezed == storyLink
          ? _self.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedResult: null == expectedResult
          ? _self.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
    ));
  }

  /// Create a copy of StepResult
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
class _StepResult implements StepResult {
  const _StepResult(
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
  factory _StepResult.fromJson(Map<String, dynamic> json) =>
      _$StepResultFromJson(json);

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

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StepResultCopyWith<_StepResult> get copyWith =>
      __$StepResultCopyWithImpl<_StepResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StepResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StepResult &&
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

  @override
  String toString() {
    return 'StepResult(stepId: $stepId, stepName: $stepName, testCaseId: $testCaseId, testCaseName: $testCaseName, status: $status, procedure: $procedure, actualValue: $actualValue, actualPassFail: $actualPassFail, failureDescription: $failureDescription, jiraBugLink: $jiraBugLink, bugRecordedInJira: $bugRecordedInJira, storyLink: $storyLink, expectedResult: $expectedResult)';
  }
}

/// @nodoc
abstract mixin class _$StepResultCopyWith<$Res>
    implements $StepResultCopyWith<$Res> {
  factory _$StepResultCopyWith(
          _StepResult value, $Res Function(_StepResult) _then) =
      __$StepResultCopyWithImpl;
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
class __$StepResultCopyWithImpl<$Res> implements _$StepResultCopyWith<$Res> {
  __$StepResultCopyWithImpl(this._self, this._then);

  final _StepResult _self;
  final $Res Function(_StepResult) _then;

  /// Create a copy of StepResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_StepResult(
      stepId: null == stepId
          ? _self.stepId
          : stepId // ignore: cast_nullable_to_non_nullable
              as String,
      stepName: null == stepName
          ? _self.stepName
          : stepName // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseId: null == testCaseId
          ? _self.testCaseId
          : testCaseId // ignore: cast_nullable_to_non_nullable
              as String,
      testCaseName: null == testCaseName
          ? _self.testCaseName
          : testCaseName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as StepResultStatus,
      procedure: null == procedure
          ? _self._procedure
          : procedure // ignore: cast_nullable_to_non_nullable
              as List<ProcedureItem>,
      actualValue: freezed == actualValue
          ? _self.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as String?,
      actualPassFail: freezed == actualPassFail
          ? _self.actualPassFail
          : actualPassFail // ignore: cast_nullable_to_non_nullable
              as bool?,
      failureDescription: null == failureDescription
          ? _self.failureDescription
          : failureDescription // ignore: cast_nullable_to_non_nullable
              as String,
      jiraBugLink: null == jiraBugLink
          ? _self.jiraBugLink
          : jiraBugLink // ignore: cast_nullable_to_non_nullable
              as String,
      bugRecordedInJira: null == bugRecordedInJira
          ? _self.bugRecordedInJira
          : bugRecordedInJira // ignore: cast_nullable_to_non_nullable
              as bool,
      storyLink: freezed == storyLink
          ? _self.storyLink
          : storyLink // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedResult: null == expectedResult
          ? _self.expectedResult
          : expectedResult // ignore: cast_nullable_to_non_nullable
              as ExpectedResult,
    ));
  }

  /// Create a copy of StepResult
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
mixin _$TestRun {
  String get id;
  String get name;

  /// 'test_plan' | 'release_plan'
  String get sourceType;
  String get sourceName;
  String? get releaseVersion;
  DateTime get executedAt;
  List<StepResult> get stepResults;
  bool get isComplete;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestRunCopyWith<TestRun> get copyWith =>
      _$TestRunCopyWithImpl<TestRun>(this as TestRun, _$identity);

  /// Serializes this TestRun to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestRun &&
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
                .equals(other.stepResults, stepResults) &&
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
      const DeepCollectionEquality().hash(stepResults),
      isComplete);

  @override
  String toString() {
    return 'TestRun(id: $id, name: $name, sourceType: $sourceType, sourceName: $sourceName, releaseVersion: $releaseVersion, executedAt: $executedAt, stepResults: $stepResults, isComplete: $isComplete)';
  }
}

/// @nodoc
abstract mixin class $TestRunCopyWith<$Res> {
  factory $TestRunCopyWith(TestRun value, $Res Function(TestRun) _then) =
      _$TestRunCopyWithImpl;
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
class _$TestRunCopyWithImpl<$Res> implements $TestRunCopyWith<$Res> {
  _$TestRunCopyWithImpl(this._self, this._then);

  final TestRun _self;
  final $Res Function(TestRun) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceName: null == sourceName
          ? _self.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      releaseVersion: freezed == releaseVersion
          ? _self.releaseVersion
          : releaseVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      executedAt: null == executedAt
          ? _self.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stepResults: null == stepResults
          ? _self.stepResults
          : stepResults // ignore: cast_nullable_to_non_nullable
              as List<StepResult>,
      isComplete: null == isComplete
          ? _self.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TestRun extends TestRun {
  const _TestRun(
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
  factory _TestRun.fromJson(Map<String, dynamic> json) =>
      _$TestRunFromJson(json);

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

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TestRunCopyWith<_TestRun> get copyWith =>
      __$TestRunCopyWithImpl<_TestRun>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TestRunToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestRun &&
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

  @override
  String toString() {
    return 'TestRun(id: $id, name: $name, sourceType: $sourceType, sourceName: $sourceName, releaseVersion: $releaseVersion, executedAt: $executedAt, stepResults: $stepResults, isComplete: $isComplete)';
  }
}

/// @nodoc
abstract mixin class _$TestRunCopyWith<$Res> implements $TestRunCopyWith<$Res> {
  factory _$TestRunCopyWith(_TestRun value, $Res Function(_TestRun) _then) =
      __$TestRunCopyWithImpl;
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
class __$TestRunCopyWithImpl<$Res> implements _$TestRunCopyWith<$Res> {
  __$TestRunCopyWithImpl(this._self, this._then);

  final _TestRun _self;
  final $Res Function(_TestRun) _then;

  /// Create a copy of TestRun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_TestRun(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceName: null == sourceName
          ? _self.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      releaseVersion: freezed == releaseVersion
          ? _self.releaseVersion
          : releaseVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      executedAt: null == executedAt
          ? _self.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stepResults: null == stepResults
          ? _self._stepResults
          : stepResults // ignore: cast_nullable_to_non_nullable
              as List<StepResult>,
      isComplete: null == isComplete
          ? _self.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
