import 'package:freezed_annotation/freezed_annotation.dart';

part 'expected_result.freezed.dart';
part 'expected_result.g.dart';

enum AnswerType { none, passFail, value }

@freezed
class ExpectedResult with _$ExpectedResult {
  const factory ExpectedResult({
    @Default('') String description,
    @Default(AnswerType.none) AnswerType answerType,

    /// For answerType == value
    double? minValue,
    double? maxValue,
    String? unit,
  }) = _ExpectedResult;

  factory ExpectedResult.fromJson(Map<String, dynamic> json) =>
      _$ExpectedResultFromJson(json);
}
