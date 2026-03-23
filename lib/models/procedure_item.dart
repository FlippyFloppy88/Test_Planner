import 'package:freezed_annotation/freezed_annotation.dart';
import 'attachment.dart';

part 'procedure_item.freezed.dart';
part 'procedure_item.g.dart';

/// A single item in an ordered procedure list.
/// Contains plain text plus optional image attachments.
/// Attachments are stored as base64 and referenced by id in the text
/// using the placeholder syntax [📎 filename](attachment:id).
@freezed
abstract class ProcedureItem with _$ProcedureItem {
  const factory ProcedureItem({
    required String id,
    @Default(0) int order,
    @Default('') String text,
    @Default([]) List<Attachment> attachments,
  }) = _ProcedureItem;

  factory ProcedureItem.fromJson(Map<String, dynamic> json) =>
      _$ProcedureItemFromJson(json);
}
