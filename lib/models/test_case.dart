import 'package:freezed_annotation/freezed_annotation.dart';
import 'procedure_item.dart';
import 'test_step.dart';

part 'test_case.freezed.dart';
part 'test_case.g.dart';

@freezed
abstract class TestCase with _$TestCase {
  const factory TestCase({
    required String id,
    @Default('') String name,
    @Default('') String description,

    /// Ordered precondition procedure items (shown at test-case level)
    @Default([]) List<ProcedureItem> preconditions,

    /// Jira story / bug links associated with this test case.
    /// Auto-populated from step storyLinks but can also be added manually.
    @Default([]) List<String> jiraLinks,
    @Default([]) List<TestStep> steps,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TestCase;

  factory TestCase.fromJson(Map<String, dynamic> json) =>
      _$TestCaseFromJson(json);
}
