import 'package:freezed_annotation/freezed_annotation.dart';
import 'test_case.dart';

part 'test_plan.freezed.dart';
part 'test_plan.g.dart';

@freezed
class TestPlan with _$TestPlan {
  const factory TestPlan({
    required String id,
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<TestCase> testCases,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TestPlan;

  factory TestPlan.fromJson(Map<String, dynamic> json) =>
      _$TestPlanFromJson(json);
}
