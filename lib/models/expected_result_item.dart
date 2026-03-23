import 'package:freezed_annotation/freezed_annotation.dart';
import 'attachment.dart';

part 'expected_result_item.freezed.dart';
part 'expected_result_item.g.dart';

/// The type of answer expected for an expected result item.
enum AnswerType { none, passFail, value }

/// A single item in an expected-results list.
/// Stores an observation/question as plain text (supports the same inline
/// formatting markup as [ProcedureItem.text]) plus optional image attachments
/// and an answer type.
@freezed
abstract class ExpectedResultItem with _$ExpectedResultItem {
  const factory ExpectedResultItem({
    required String id,
    @Default(0) int order,

    /// The observation or question text. Supports inline markup:
    ///   **bold**, *italic*, __underline__, [color=#RRGGBB]text[/color]
    /// and attachment placeholders: [📎 label](attachment:id)
    @Default('') String observation,

    @Default(AnswerType.none) AnswerType answerType,

    /// For answerType == value
    double? minValue,
    double? maxValue,
    String? unit,

    @Default([]) List<Attachment> attachments,
  }) = _ExpectedResultItem;

  factory ExpectedResultItem.fromJson(Map<String, dynamic> json) =>
      _$ExpectedResultItemFromJson(json);
}
