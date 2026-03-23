import 'package:freezed_annotation/freezed_annotation.dart';
import 'expected_result.dart';
import 'procedure_item.dart';

part 'test_run.freezed.dart';
part 'test_run.g.dart';

enum StepResultStatus { notRun, passed, failed, skipped }

@freezed
abstract class StepResult with _$StepResult {
  const factory StepResult({
    required String stepId,
    required String stepName,
    required String testCaseId,
    required String testCaseName,
    @Default(StepResultStatus.notRun) StepResultStatus status,

    /// Procedure items to display during execution
    @Default([]) List<ProcedureItem> procedure,

    /// Actual value entered by the user (for value-type answers)
    String? actualValue,

    /// Actual pass/fail answer
    bool? actualPassFail,
    @Default('') String failureDescription,
    @Default('') String jiraBugLink,
    @Default(false) bool bugRecordedInJira,
    String? storyLink,
    required ExpectedResult expectedResult,
  }) = _StepResult;

  factory StepResult.fromJson(Map<String, dynamic> json) =>
      _$StepResultFromJson(json);
}

@freezed
abstract class TestRun with _$TestRun {
  const factory TestRun({
    required String id,
    required String name,

    /// 'test_plan' | 'release_plan'
    @Default('test_plan') String sourceType,
    required String sourceName,
    String? releaseVersion,
    required DateTime executedAt,
    @Default([]) List<StepResult> stepResults,
    @Default(false) bool isComplete,
  }) = _TestRun;

  factory TestRun.fromJson(Map<String, dynamic> json) =>
      _$TestRunFromJson(json);

  const TestRun._();

  int get totalSteps => stepResults.length;
  int get passedSteps =>
      stepResults.where((r) => r.status == StepResultStatus.passed).length;
  int get failedSteps =>
      stepResults.where((r) => r.status == StepResultStatus.failed).length;
  int get skippedSteps =>
      stepResults.where((r) => r.status == StepResultStatus.skipped).length;
  int get runSteps =>
      stepResults.where((r) => r.status != StepResultStatus.notRun).length;

  List<StepResult> get failures =>
      stepResults.where((r) => r.status == StepResultStatus.failed).toList();

  List<String> get uniqueJiraBugs => stepResults
      .where((r) => r.jiraBugLink.isNotEmpty)
      .map((r) => r.jiraBugLink)
      .toSet()
      .toList();
}
