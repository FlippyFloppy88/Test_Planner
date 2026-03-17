import 'package:flutter/material.dart';
import '../../models/models.dart';

/// Renders procedure text and replaces attachment placeholders like
/// [📎 label](attachment:id) with clickable hypertext that calls
/// [onAttachmentTap] with the matching Attachment.
class ProcedureText extends StatelessWidget {
  final String text;
  final List<Attachment> attachments;
  final void Function(Attachment) onAttachmentTap;
  final TextStyle? style;

  const ProcedureText({
    super.key,
    required this.text,
    required this.attachments,
    required this.onAttachmentTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    final linkStyle = defaultStyle.copyWith(
      color: Theme.of(context).colorScheme.primary,
      decoration: TextDecoration.underline,
    );
    // RegExp for placeholders like: [📎 label](attachment:id)
    final reg = RegExp(r"\[📎\s*([^\]]+)\]\(attachment:([^\)]+)\)");
    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in reg.allMatches(text)) {
      if (m.start > last) {
        spans.add(TextSpan(text: text.substring(last, m.start), style: defaultStyle));
      }
      final label = m.group(1) ?? '';
      final id = m.group(2) ?? '';
      final att = attachments.firstWhere(
        (a) => a.id == id,
        orElse: () => Attachment(id: '', fileName: label, mimeType: '', filePath: ''),
      );

      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: InkWell(
          onTap: att.id.isNotEmpty ? () => onAttachmentTap(att) : null,
          child: Text(label, style: linkStyle),
        ),
      ));

      last = m.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: defaultStyle));
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: spans),
    );
  }
}
