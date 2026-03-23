import 'package:flutter/material.dart';
import '../../models/models.dart';

/// Renders procedure/observation text, supporting nested inline markup:
///   • Attachment placeholders: [📎 label](attachment:id)
///   • Bold:        **text**
///   • Italic:      *text*
///   • Underline:   __text__
///   • Color:       [color=#RRGGBB]text[/color]
///
/// Styles can be nested arbitrarily, e.g.:
///   [color=#E53935]**bold red**[/color]
///   *__italic underline__*
///   **[color=#1976D2]*bold italic blue*[/color]**
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

  // ── Patterns – ordered most-specific first so bold (**) wins over italic (*).
  // The inner capture group intentionally uses [^] (any char incl. newline)
  // with a non-greedy `+?` so nested markers aren't swallowed whole.
  static final _patterns = [
    RegExp(r'\[📎\s*([^\]]+)\]\(attachment:([^\)]+)\)'), // 0 attachment
    RegExp(r'\*\*(.+?)\*\*', dotAll: true),               // 1 bold
    RegExp(r'__(.+?)__', dotAll: true),                   // 2 underline
    RegExp(r'\*(.+?)\*', dotAll: true),                   // 3 italic
    RegExp(r'\[color=([^\]]+)\](.+?)\[\/color\]', dotAll: true), // 4 color
  ];

  /// Recursively build [InlineSpan]s for [text] with [base] as the inherited
  /// style.  Inner content of each matched span is recursed so that nested
  /// markers (e.g. bold inside color) are all applied.
  List<InlineSpan> _buildSpans(
    String text,
    TextStyle base,
    TextStyle linkStyle,
  ) {
    if (text.isEmpty) return [];
    final spans = <InlineSpan>[];
    int pos = 0;

    while (pos < text.length) {
      RegExpMatch? earliest;
      int earliestPattern = -1;
      int earliestStart = text.length;

      for (int pi = 0; pi < _patterns.length; pi++) {
        final m = _patterns[pi].firstMatch(text.substring(pos));
        if (m != null) {
          final absStart = pos + m.start;
          if (absStart < earliestStart) {
            earliestStart = absStart;
            earliest = m;
            earliestPattern = pi;
          }
        }
      }

      if (earliest == null) {
        spans.add(TextSpan(text: text.substring(pos), style: base));
        break;
      }

      // Plain text before this match.
      if (earliestStart > pos) {
        spans.add(TextSpan(text: text.substring(pos, earliestStart), style: base));
      }

      switch (earliestPattern) {
        case 0: // attachment placeholder – not recursed
          final label = earliest.group(1) ?? '';
          final id = earliest.group(2) ?? '';
          final att = attachments.firstWhere(
            (a) => a.id == id,
            orElse: () =>
                Attachment(id: '', fileName: label, mimeType: '', filePath: ''),
          );
          spans.add(WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: InkWell(
              onTap: att.id.isNotEmpty ? () => onAttachmentTap(att) : null,
              child: Text(label, style: linkStyle),
            ),
          ));

        case 1: // bold – recurse inner with bold style
          final inner = earliest.group(1) ?? '';
          final innerStyle = base.copyWith(fontWeight: FontWeight.bold);
          spans.add(TextSpan(
            children: _buildSpans(inner, innerStyle, linkStyle),
            style: innerStyle,
          ));

        case 2: // underline – recurse
          final inner = earliest.group(1) ?? '';
          final innerStyle = base.copyWith(
            decoration: TextDecoration.combine([
              if (base.decoration != null) base.decoration!,
              TextDecoration.underline,
            ]),
            decorationColor: base.color,
          );
          spans.add(TextSpan(
            children: _buildSpans(inner, innerStyle, linkStyle),
            style: innerStyle,
          ));

        case 3: // italic – recurse
          final inner = earliest.group(1) ?? '';
          final innerStyle = base.copyWith(fontStyle: FontStyle.italic);
          spans.add(TextSpan(
            children: _buildSpans(inner, innerStyle, linkStyle),
            style: innerStyle,
          ));

        case 4: // color – recurse
          final hex = earliest.group(1) ?? '';
          final inner = earliest.group(2) ?? '';
          final color = _parseColor(hex);
          final innerStyle = base.copyWith(
            color: color ?? base.color,
            decorationColor: color ?? base.color,
          );
          spans.add(TextSpan(
            children: _buildSpans(inner, innerStyle, linkStyle),
            style: innerStyle,
          ));
      }

      pos = earliestStart + earliest[0]!.length;
    }

    return spans;
  }

  static Color? _parseColor(String hex) {
    final clean = hex.replaceFirst('#', '').trim();
    if (clean.length == 6) {
      final value = int.tryParse('FF$clean', radix: 16);
      return value != null ? Color(value) : null;
    }
    if (clean.length == 8) {
      final value = int.tryParse(clean, radix: 16);
      return value != null ? Color(value) : null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    final linkStyle = defaultStyle.copyWith(
      color: Theme.of(context).colorScheme.primary,
      decoration: TextDecoration.underline,
    );

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: _buildSpans(text, defaultStyle, linkStyle)),
    );
  }
}
