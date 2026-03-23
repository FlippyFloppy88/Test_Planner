import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

/// Represents an image attachment linked to a procedure item.
///
/// On macOS the image is saved to disk under the selected data folder.
/// [filePath] is the path relative to the data folder root, e.g.:
///   "My Test Case/preconditions/screenshot.png"
///   "My Test Case/step_1_sub_3/photo.jpg"
///
/// [base64Content] is kept for backward-compatibility with any existing
/// data that was stored as base64 (web era). Prefer [filePath] going forward.
@freezed
abstract class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required String fileName,
    required String mimeType,

    /// Path relative to the storage folder root.
    @Default('') String filePath,

    /// Legacy base64 content (kept for back-compat; empty for new attachments).
    @Default('') String base64Content,
    @Default('') String description,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
