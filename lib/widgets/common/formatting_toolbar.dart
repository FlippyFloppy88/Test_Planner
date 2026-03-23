import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'procedure_text.dart';

/// A formatting toolbar + live preview for text fields that use the custom
/// inline markup: **bold**  *italic*  __underline__  [color=#RRGGBB]text[/color]
///
/// Behaviours:
/// • With a selection  → wraps the selection; cursor lands just after the
///   closing marker (supports nesting: apply Bold then Color to same text).
/// • No selection, cursor between an empty marker pair (`****`, `__`, etc.)
///   → toggle-off: removes that empty pair.
/// • No selection, all other cases → inserts `open + close` and parks the
///   cursor **inside** them, ready to type styled text.
///
/// The selection is snapshotted the moment focus leaves the TextField so
/// the toolbar button can reliably restore and update it even after the
/// PopupMenuButton or InkWell steals focus.
class FormattingToolbar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  /// Attachments forwarded to the live preview renderer.
  final List<Attachment> attachments;

  const FormattingToolbar({
    super.key,
    required this.controller,
    required this.focusNode,
    this.attachments = const [],
  });

  @override
  State<FormattingToolbar> createState() => _FormattingToolbarState();
}

class _FormattingToolbarState extends State<FormattingToolbar> {
  /// Snapshot of the last known-valid selection, updated whenever the
  /// TextField has focus and the selection changes.
  TextSelection _savedSelection = const TextSelection.collapsed(offset: 0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(FormattingToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_onFocusChanged);
      widget.focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    widget.focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    // Keep snapshot in sync while the field is focused.
    if (widget.focusNode.hasFocus) {
      final sel = widget.controller.selection;
      if (sel.isValid) _savedSelection = sel;
    }
    if (mounted) setState(() {});
  }

  void _onFocusChanged() {
    // Capture selection the instant focus leaves the TextField.
    if (!widget.focusNode.hasFocus) {
      final sel = widget.controller.selection;
      if (sel.isValid) _savedSelection = sel;
    }
  }

  // ── Format insertion ───────────────────────────────────────────────────

  void _applyFormat(String open, String close) {
    final text = widget.controller.text;

    // Use the saved snapshot — guarantees a valid position even when a
    // toolbar button (PopupMenuItem, InkWell) stole focus before this fires.
    TextSelection sel = _savedSelection;
    // Clamp to current text length in case the text changed.
    final len = text.length;
    final start = sel.start.clamp(0, len);
    final end = sel.end.clamp(0, len);
    sel = TextSelection(baseOffset: start, extentOffset: end);

    final String newText;
    final int cursorPos;

    if (!sel.isCollapsed) {
      // ── Selection: wrap it; cursor after closing marker ──────────────
      final selected = text.substring(start, end);
      newText = text.replaceRange(start, end, '$open$selected$close');
      cursorPos = start + open.length + selected.length + close.length;
    } else {
      // ── No selection ────────────────────────────────────────────────
      final cursor = start;

      // Toggle-off: cursor is sitting inside an *empty* marker pair at
      // exactly this position, e.g.  "prefix ** ** suffix"  where cursor
      // is between the two open/close markers with nothing in between.
      if (_isBetweenEmptyPair(text, cursor, open, close)) {
        // Remove the empty pair.
        final pairStart = cursor - open.length;
        newText = text.replaceRange(pairStart, cursor + close.length, '');
        cursorPos = pairStart;
      } else {
        // Insert open+close and park cursor between them.
        newText = text.replaceRange(cursor, cursor, '$open$close');
        cursorPos = cursor + open.length;
      }
    }

    final targetSel = TextSelection.collapsed(offset: cursorPos);
    _savedSelection = targetSel;
    widget.controller.value = TextEditingValue(
      text: newText,
      selection: targetSel,
    );
    widget.focusNode.requestFocus();
    // On Windows (and other platforms), requestFocus() triggers a
    // platform-keyboard round-trip that can reset the IME cursor position.
    // Re-apply the selection after the frame so it always lands inside the
    // markers, ready for the user to type styled text.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.controller.selection = targetSel;
    });
  }

  /// Returns true when [cursor] is sitting in the zero-width gap between
  /// an [open] marker that ends at [cursor] and a [close] marker that
  /// starts at [cursor] — i.e. the pair is empty: `<open><cursor><close>`.
  bool _isBetweenEmptyPair(String text, int cursor, String open, String close) {
    if (cursor < open.length) return false;
    final beforeCursor = text.substring(cursor - open.length, cursor);
    final afterCursor = cursor + close.length <= text.length
        ? text.substring(cursor, cursor + close.length)
        : '';
    return beforeCursor == open && afterCursor == close;
  }

  void _applyColor(Color color) {
    final hex = (color.value & 0xFFFFFF)
        .toRadixString(16)
        .padLeft(6, '0')
        .toUpperCase();
    _applyFormat('[color=#$hex]', '[/color]');
  }

  // ── Colour palette ─────────────────────────────────────────────────────

  static const _colorOptions = <String, Color>{
    'Red': Color(0xFFE53935),
    'Orange': Color(0xFFFF6F00),
    'Green': Color(0xFF388E3C),
    'Blue': Color(0xFF1976D2),
    'Purple': Color(0xFF7B1FA2),
    'Gray': Color(0xFF616161),
  };

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasText = widget.controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Toolbar button row ───────────────────────────────────────
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _fmtBtn('B', 'Bold  (**text**)',
                const TextStyle(fontWeight: FontWeight.bold),
                colors, () => _applyFormat('**', '**')),
            _fmtBtn('I', 'Italic  (*text*)',
                const TextStyle(fontStyle: FontStyle.italic),
                colors, () => _applyFormat('*', '*')),
            _fmtBtn('U', 'Underline  (__text__)',
                const TextStyle(decoration: TextDecoration.underline),
                colors, () => _applyFormat('__', '__')),
            const SizedBox(width: 4),
            PopupMenuButton<Color>(
              tooltip: 'Text color',
              icon: Icon(Icons.format_color_text,
                  size: 18, color: colors.onSurface),
              padding: EdgeInsets.zero,
              onOpened: () {
                // Snapshot selection right before the menu opens, because
                // opening the popup menu will steal focus from the TextField.
                final sel = widget.controller.selection;
                if (sel.isValid) _savedSelection = sel;
              },
              itemBuilder: (_) => _colorOptions.entries
                  .map((e) => PopupMenuItem<Color>(
                        value: e.value,
                        child: Row(children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                color: e.value, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          Text(e.key),
                        ]),
                      ))
                  .toList(),
              onSelected: _applyColor,
            ),
          ],
        ),
        // ── Live preview ─────────────────────────────────────────────
        if (hasText) ...[
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest.withAlpha(128),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preview',
                  style: textTheme.labelSmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                ProcedureText(
                  text: widget.controller.text,
                  attachments: widget.attachments,
                  onAttachmentTap: (_) {},
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _fmtBtn(String label, String tooltip, TextStyle style,
      ColorScheme colors, VoidCallback onTap) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Text(
            label,
            style: style.copyWith(fontSize: 13, color: colors.onSurface),
          ),
        ),
      ),
    );
  }
}
