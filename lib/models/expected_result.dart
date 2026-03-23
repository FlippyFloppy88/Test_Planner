import 'package:freezed_annotation/freezed_annotation.dart';
import 'expected_result_item.dart';

export 'expected_result_item.dart' show AnswerType, ExpectedResultItem;

part 'expected_result.freezed.dart';
part 'expected_result.g.dart';

@freezed
abstract class ExpectedResult with _$ExpectedResult {
  const factory ExpectedResult({
    /// Legacy single-item fields kept for backward-compatible JSON loading.
    @Default('') String description,
    @Default(AnswerType.none) AnswerType answerType,
    double? minValue,
    double? maxValue,
    String? unit,

    /// New list-based expected result items.
    @Default([]) List<ExpectedResultItem> items,
  }) = _ExpectedResult;

  factory ExpectedResult.fromJson(Map<String, dynamic> json) =>
      _$ExpectedResultFromJson(json);
}
