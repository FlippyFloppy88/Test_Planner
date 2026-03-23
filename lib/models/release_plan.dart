import 'package:freezed_annotation/freezed_annotation.dart';
import 'test_case.dart';

part 'release_plan.freezed.dart';
part 'release_plan.g.dart';

/// A release plan item is either a reference to a full test plan
/// (by id) or a one-off test case.
@freezed
abstract class ReleasePlanItem with _$ReleasePlanItem {
  /// Reference to an existing TestPlan (all its cases included)
  const factory ReleasePlanItem.testPlanRef({
    required String id,
    required String testPlanId,
    required String testPlanName,
    @Default(0) int order,
  }) = ReleasePlanItemTestPlanRef;

  /// A standalone one-off test case embedded directly
  const factory ReleasePlanItem.oneOff({
    required String id,
    required TestCase testCase,
    @Default(0) int order,
  }) = ReleasePlanItemOneOff;

  factory ReleasePlanItem.fromJson(Map<String, dynamic> json) =>
      _$ReleasePlanItemFromJson(json);
}

@freezed
abstract class ReleasePlan with _$ReleasePlan {
  const factory ReleasePlan({
    required String id,
    @Default('') String productName,
    @Default('') String description,
    @Default([]) List<ReleasePlanItem> items,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReleasePlan;

  factory ReleasePlan.fromJson(Map<String, dynamic> json) =>
      _$ReleasePlanFromJson(json);
}
