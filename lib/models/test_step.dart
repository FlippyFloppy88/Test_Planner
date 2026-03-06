import 'package:freezed_annotation/freezed_annotation.dart';
import 'expected_result.dart';
import 'procedure_item.dart';

part 'test_step.freezed.dart';
part 'test_step.g.dart';

/// A single test step. Steps can be nested recursively via [subSteps].
@freezed
class TestStep with _$TestStep {
  const factory TestStep({
    required String id,
    @Default(1) int order,
    @Default('') String name,

    /// Optional ordered procedure steps with text and image attachments
    @Default([]) List<ProcedureItem> procedure,
    required ExpectedResult expectedResult,

    /// Optional link to a Jira story or bug
    @Default('') String storyLink,

    /// Recursively nested sub-steps
    @Default([]) List<TestStep> subSteps,
  }) = _TestStep;

  factory TestStep.fromJson(Map<String, dynamic> json) =>
      _$TestStepFromJson(json);
}
