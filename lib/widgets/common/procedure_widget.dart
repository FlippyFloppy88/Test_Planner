import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'numbered_drag_handle.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../models/models.dart';

const _uuid = Uuid();

/// An ordered, drag-and-drop list of [ProcedureItem]s.
///
/// When [storageFolderPath] is set (non-empty) images are physically copied
/// to `<storageFolderPath>/<imageRelativePath>/<imageName>` and the
/// [Attachment.filePath] stores the relative path from the storage root.
///
/// When no folder is configured the image button is still shown but a warning
/// snackbar is displayed asking the user to select a folder first.
class ProcedureWidget extends StatefulWidget {
  final List<ProcedureItem> items;
  final ValueChanged<List<ProcedureItem>> onChanged;

  /// Absolute path to the root storage folder (from StorageService).
  /// Empty when no folder has been chosen yet.
  final String storageFolderPath;

  /// Path relative to [storageFolderPath] where images for THIS widget live.
  /// E.g. "My Test Case/preconditions" or "My Test Case/step_1_sub_3".
  final String imageRelativePath;

  /// Optional label shown above the list.
  final String? label;

  /// Placeholder shown in each item's text field.
  final String itemHint;

  const ProcedureWidget({
    super.key,
    required this.items,
    required this.onChanged,
    this.storageFolderPath = '',
    this.imageRelativePath = '',
    this.label,
    this.itemHint = 'Enter step text...',
  });

  @override
  State<ProcedureWidget> createState() => _ProcedureWidgetState();
}

class _ProcedureWidgetState extends State<ProcedureWidget> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _syncControllers(widget.items);
  }

  @override
  void didUpdateWidget(ProcedureWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncControllers(widget.items);
  }

  void _syncControllers(List<ProcedureItem> items) {
    final ids = items.map((i) => i.id).toSet();
    _controllers.keys
        .where((k) => !ids.contains(k))
        .toList()
        .forEach((k) => _controllers.remove(k)?.dispose());
    for (final item in items) {
      if (!_controllers.containsKey(item.id)) {
        _controllers[item.id] = TextEditingController(text: item.text);
      } else if (_controllers[item.id]!.text != item.text) {
        final ctrl = _controllers[item.id]!;
        final sel = ctrl.selection;
        ctrl.text = item.text;
        try {
          ctrl.selection = sel;
        } catch (_) {}
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _emit(List<ProcedureItem> items) => widget.onChanged(items);

  void _addItem() {
    final newItem = ProcedureItem(
      id: _uuid.v4(),
      order: widget.items.length,
      text: '',
    );
    _emit([...widget.items, newItem]);
  }

  void _deleteItem(int index) {
    final updated = List<ProcedureItem>.from(widget.items)..removeAt(index);
    _emit(_reorder(updated));
  }

  void _onTextChanged(int index, String text) {
    final updated = List<ProcedureItem>.from(widget.items);
    updated[index] = updated[index].copyWith(text: text);
    _emit(updated);
  }

  List<ProcedureItem> _reorder(List<ProcedureItem> items) {
    return List.generate(items.length, (i) => items[i].copyWith(order: i));
  }

  Future<void> _pickImage(BuildContext context, int index) async {
    // Must have a folder selected before we can save images.
    if (widget.storageFolderPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please select a data folder first (Home screen) before adding images.'),
        ),
      );
      return;
    }

    // 1. Pick the source image file.
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: false, // we use path on macOS
    );
    if (result == null || result.files.single.path == null) return;

    final sourcePath = result.files.single.path!;
    final originalName = p.basename(sourcePath);
    final ext = p.extension(originalName); // e.g. ".png"

    // 2. Ask the user for a label / name.
    if (!context.mounted) return;
    final imageName = await _showImageNameDialog(context, originalName);
    if (imageName == null) return; // cancelled

    // Ensure the name has the correct extension.
    final safeLabel =
        imageName.trim().isEmpty ? originalName : imageName.trim();
    final fileName = safeLabel.endsWith(ext) ? safeLabel : '$safeLabel$ext';

    // 3. Copy the image into the storage folder.
    final destDir =
        Directory(p.join(widget.storageFolderPath, widget.imageRelativePath));
    if (!await destDir.exists()) {
      await destDir.create(recursive: true);
    }
    final destPath = p.join(destDir.path, fileName);
    await File(sourcePath).copy(destPath);

    // 4. Build the Attachment (filePath relative to storage root).
    final relativeFilePath = p.join(widget.imageRelativePath, fileName);
    final mimeType = _mimeFromExtension(fileName);
    final id = _uuid.v4();

    final attachment = Attachment(
      id: id,
      fileName: fileName,
      mimeType: mimeType,
      filePath: relativeFilePath,
    );

    // 5. Append a hyperlink placeholder to the text: [📎 label](attachment:id)
    final updated = List<ProcedureItem>.from(widget.items);
    final item = updated[index];
    final linkLabel = safeLabel.endsWith(ext)
        ? safeLabel.substring(0, safeLabel.length - ext.length)
        : safeLabel;
    final newText = '${item.text}[📎 $linkLabel](attachment:$id)';
    updated[index] = item.copyWith(
      text: newText,
      attachments: [...item.attachments, attachment],
    );
    _emit(updated);
  }

  /// Shows a dialog prompting the user to name the image.
  /// Returns the entered name, or null if cancelled.
  Future<String?> _showImageNameDialog(
      BuildContext context, String defaultName) {
    final ext = p.extension(defaultName);
    final stem = p.basenameWithoutExtension(defaultName);
    final ctrl = TextEditingController(text: stem);

    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Name this image'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Image label',
            hintText: 'e.g. Login screenshot',
            suffixText: ext,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim().isEmpty ? null : v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final val = ctrl.text.trim();
              Navigator.pop(ctx, val.isEmpty ? null : val);
            },
            child: const Text('Add Image'),
          ),
        ],
      ),
    );
  }

  String _mimeFromExtension(String name) {
    final ext = p.extension(name).toLowerCase().replaceFirst('.', '');
    const map = {
      'png': 'image/png',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'gif': 'image/gif',
      'webp': 'image/webp',
      'heic': 'image/heic',
      'heif': 'image/heif',
    };
    return map[ext] ?? 'application/octet-stream';
  }

  void _showImagePreview(BuildContext context, Attachment att) {
    // Resolve the absolute path from the storage root + relative filePath.
    final absPath =
        att.filePath.isNotEmpty && widget.storageFolderPath.isNotEmpty
            ? p.join(widget.storageFolderPath, att.filePath)
            : null;

    Widget imageWidget;
    if (absPath != null && File(absPath).existsSync()) {
      imageWidget = InteractiveViewer(child: Image.file(File(absPath)));
    } else if (att.base64Content.isNotEmpty) {
      // Legacy base64 fallback.
      try {
        final bytes = base64Decode(att.base64Content);
        imageWidget = InteractiveViewer(child: Image.memory(bytes));
      } catch (_) {
        imageWidget = const Text('Could not load image');
      }
    } else {
      imageWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.broken_image, size: 64),
          const SizedBox(height: 8),
          Text(
            absPath != null ? 'File not found:\n$absPath' : 'No image data',
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(att.fileName),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            Flexible(child: imageWidget),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.label != null) ...[
              Text(widget.label!, style: textTheme.labelLarge),
              const Spacer(),
            ] else
              const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Item'),
              onPressed: _addItem,
            ),
          ],
        ),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No items yet. Click "Add Item" to start.',
              style:
                  textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
            ),
          )
        else
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            onReorder: (oldIndex, newIndex) {
              final updated = List<ProcedureItem>.from(widget.items);
              final item = updated.removeAt(oldIndex);
              if (newIndex > oldIndex) newIndex--;
              updated.insert(newIndex, item);
              _emit(_reorder(updated));
            },
            itemBuilder: (ctx, i) {
              final item = widget.items[i];
              return _ProcedureItemRow(
                key: ValueKey(item.id),
                index: i,
                item: item,
                controller: _controllers[item.id]!,
                hint: widget.itemHint,
                onTextChanged: (text) => _onTextChanged(i, text),
                onPickImage: () => _pickImage(ctx, i),
                onDelete: () => _deleteItem(i),
                onShowImage: (att) => _showImagePreview(ctx, att),
              );
            },
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ProcedureItemRow extends StatelessWidget {
  final int index;
  final ProcedureItem item;
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onTextChanged;
  final VoidCallback onPickImage;
  final VoidCallback onDelete;
  final ValueChanged<Attachment> onShowImage;

  const _ProcedureItemRow({
    super.key,
    required this.index,
    required this.item,
    required this.controller,
    required this.hint,
    required this.onTextChanged,
    required this.onPickImage,
    required this.onDelete,
    required this.onShowImage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: NumberedDragHandle(index: index),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    isDense: true,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.image_outlined, size: 18),
                      tooltip: 'Insert image',
                      onPressed: onPickImage,
                    ),
                  ),
                  maxLines: null,
                  onChanged: onTextChanged,
                ),

                // Attachment chips
                if (item.attachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: item.attachments.map((att) {
                        return ActionChip(
                          avatar: const Icon(Icons.photo, size: 14),
                          label: Text(
                            att.filePath.isNotEmpty
                                ? p.basenameWithoutExtension(att.fileName)
                                : att.fileName,
                            style: const TextStyle(fontSize: 12),
                          ),
                          onPressed: () => onShowImage(att),
                          tooltip: 'Tap to view: ${att.fileName}',
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: IconButton(
              icon: const Icon(Icons.remove_circle_outline, size: 20),
              color: colors.error,
              onPressed: onDelete,
              tooltip: 'Remove item',
            ),
          ),
        ],
      ),
    );
  }
}
