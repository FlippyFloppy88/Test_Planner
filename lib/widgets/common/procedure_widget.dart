import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'numbered_drag_handle.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import 'procedure_text.dart';

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
  final Map<String, FocusNode> _focusNodes = {};
  final Map<String, bool> _editing = {};
  final Map<String, List<Attachment>> _stagedAttachments = {};

  @override
  void initState() {
    super.initState();
    _syncControllers(widget.items);
  }

  /// Lets the user pick an existing image from the plan image folder.
  /// Returns the absolute file path or null.
  Future<String?> _browsePlanImages(BuildContext context) async {
    final planDir = Directory(p.join(widget.storageFolderPath, widget.imageRelativePath));
    if (!await planDir.exists()) {
      if (!context.mounted) return null;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('No images'),
          content: const Text('No images have been stored for this test plan.'),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
        ),
      );
      return null;
    }

    // Collect image files under the plan folder (non-recursive for simplicity).
    final files = planDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) {
          final ext = p.extension(f.path).toLowerCase();
          return ['.png', '.jpg', '.jpeg', '.gif', '.webp', '.heic', '.heif'].contains(ext);
        })
        .toList();

    if (files.isEmpty) {
      if (!context.mounted) return null;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('No images'),
          content: const Text('No images found in the plan folder.'),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
        ),
      );
      return null;
    }

    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose image'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: files.length,
            itemBuilder: (c, i) {
              final f = files[i];
              final rel = p.relative(f.path, from: widget.storageFolderPath);
              return ListTile(
                title: Text(p.basename(f.path)),
                subtitle: Text(rel, maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.pop(ctx, f.path),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx, null), child: const Text('Cancel'))],
      ),
    );

    return choice;
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
    _focusNodes.keys
        .where((k) => !ids.contains(k))
        .toList()
        .forEach((k) => _focusNodes.remove(k)?.dispose());
    for (final item in items) {
      if (!_controllers.containsKey(item.id)) {
        _controllers[item.id] = TextEditingController(text: item.text);
        _focusNodes[item.id] = FocusNode();
        _editing[item.id] = false;
        _stagedAttachments[item.id] = [];
      } else if (_controllers[item.id]!.text != item.text) {
        // Only overwrite the controller text when the item is NOT in edit
        // mode. If the user is currently editing (possibly with staged
        // attachments and placeholders), we must not clobber their temporary
        // edits. Consider either explicit `_editing` flag OR the focus node
        // being focused as an indication the user is actively editing.
        final isEditing = (_editing[item.id] ?? false) || (_focusNodes[item.id]?.hasFocus ?? false);
        if (!isEditing) {
          final ctrl = _controllers[item.id]!;
          final sel = ctrl.selection;
          ctrl.text = item.text;
          try {
            ctrl.selection = sel;
          } catch (_) {}
        } else {
          debugPrint('[PROC_DBG] Skipping controller sync for id=${item.id} because item is being edited');
        }
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    for (final f in _focusNodes.values) {
      f.dispose();
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
    // Mark new item as editing so the TextField appears immediately.
    _editing[newItem.id] = true;
    _stagedAttachments[newItem.id] = [];
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
    debugPrint('[PROC_DBG] _pickImage start index=$index storageFolderPath="${widget.storageFolderPath}" imageRelativePath="${widget.imageRelativePath}"');
    // Must have a folder selected before we can save images.
    if (widget.storageFolderPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please select a data folder first (Home screen) before adding images.'),
        ),
      );
      debugPrint('[PROC_DBG] _pickImage aborted: no storageFolderPath');
      return;
    }
    // Let the user choose between browsing existing plan images or picking a new file.
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Insert Image'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'existing'),
            child: const Text('Choose existing from plan folder'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'new'),
            child: const Text('Pick a new file from disk'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    debugPrint('[PROC_DBG] _pickImage choice=$choice');
    if (choice == null) {
      debugPrint('[PROC_DBG] _pickImage cancelled by choice');
      return;
    }

    String? sourcePath;
    if (choice == 'existing') {
      sourcePath = await _browsePlanImages(context);
      debugPrint('[PROC_DBG] _pickImage browse returned sourcePath=$sourcePath');
      if (sourcePath == null) {
        debugPrint('[PROC_DBG] _pickImage cancelled during browse');
        return;
      }
    } else {
      // 1. Pick the source image file.
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: false, // we use path on macOS
      );
      if (result == null || result.files.single.path == null) {
        debugPrint('[PROC_DBG] _pickImage FilePicker returned null');
        return;
      }
      sourcePath = result.files.single.path!;
      debugPrint('[PROC_DBG] _pickImage picked sourcePath=$sourcePath');
    }
    final originalName = p.basename(sourcePath);
    final ext = p.extension(originalName); // e.g. ".png"

    // 2. Ask the user for a label / name.
    if (!context.mounted) {
      debugPrint('[PROC_DBG] _pickImage aborted: context not mounted');
      return;
    }
    final imageName = await _showImageNameDialog(context, originalName);
    debugPrint('[PROC_DBG] _pickImage imageName dialog returned: $imageName');
    if (imageName == null) {
      debugPrint('[PROC_DBG] _pickImage cancelled by imageName dialog');
      return; // cancelled
    }

    // Ensure the name has the correct extension.
    final safeLabel = imageName.trim().isEmpty ? originalName : imageName.trim();
    final fileName = safeLabel.endsWith(ext) ? safeLabel : '$safeLabel$ext';
    debugPrint('[PROC_DBG] _pickImage safeLabel="$safeLabel" fileName="$fileName" ext="$ext"');

    // 3. Determine if the selected file is already inside the storage root.
    final normalizedStorage = p.normalize(widget.storageFolderPath).toLowerCase();
    final normalizedSource = p.normalize(sourcePath).toLowerCase();
    String relativeFilePath;
    if (normalizedSource.startsWith(normalizedStorage)) {
      // Already inside storage root; compute relative path and do not copy.
      relativeFilePath = p.relative(sourcePath, from: widget.storageFolderPath);
      debugPrint('[PROC_DBG] source already inside storage, relativeFilePath=$relativeFilePath');
    } else {
      // Copy the image into the plan-level image folder under storage root.
      final destDir = Directory(p.join(widget.storageFolderPath, widget.imageRelativePath));
      if (!await destDir.exists()) {
        await destDir.create(recursive: true);
      }
      final destPath = p.join(destDir.path, fileName);
      debugPrint('[PROC_DBG] copying sourcePath=$sourcePath -> destPath=$destPath');
      await File(sourcePath).copy(destPath);
      debugPrint('[PROC_DBG] copy completed');
      relativeFilePath = p.join(widget.imageRelativePath, fileName);
    }
    debugPrint('[PROC_DBG] computed relativeFilePath=$relativeFilePath fileName=$fileName');
    final mimeType = _mimeFromExtension(fileName);
    final id = _uuid.v4();

    debugPrint('[PROC_DBG] about to create Attachment with id=$id');
    final attachment = Attachment(
      id: id,
      fileName: fileName,
      mimeType: mimeType,
      filePath: relativeFilePath,
    );
    debugPrint('[PROC_DBG] created attachment id=${attachment.id} filePath=${attachment.filePath} fileName=${attachment.fileName}');

    // 5. Stage the attachment and append placeholder into the controller
    // text only. The attachment and text are committed on Save.
    final linkLabel = safeLabel.endsWith(ext)
        ? safeLabel.substring(0, safeLabel.length - ext.length)
        : safeLabel;
    final placeholder = '[📎 $linkLabel](attachment:$id)';
    debugPrint('[PROC_DBG] placeholder="$placeholder"');
    final item = widget.items[index];
    final cid = item.id;
    // Ensure staged list exists
    _stagedAttachments[cid] = [...?_stagedAttachments[cid], attachment];
    debugPrint('[PROC_DBG] staged attachments for cid=$cid count=${_stagedAttachments[cid]?.length}');
    // Insert or replace into controller at selection/caret. If the user has
    // selected text (e.g. Ctrl+A), replace that range with the placeholder.
    final ctrl = _controllers[cid]!;
    final sel = ctrl.selection;
    debugPrint('[PROC_DBG] controller before insert (cid=$cid) text="${ctrl.text}" selection=$sel');
    final hasSelection = sel.isValid && sel.start != sel.end;
    final insertIndex = (sel.isValid) ? sel.start : ctrl.text.length;
    final newText = hasSelection
        ? ctrl.text.replaceRange(sel.start, sel.end, placeholder)
        : ctrl.text.replaceRange(insertIndex, insertIndex, placeholder);
    ctrl.text = newText;
    // Notify parent about the text change so the underlying items reflect
    // the inserted placeholder immediately (this ensures previews and any
    // external listeners see the change even before Save).
    _onTextChanged(index, ctrl.text);
    debugPrint('[PROC_DBG] controller after insert (cid=$cid) text="${ctrl.text}"');
    try {
      final base = hasSelection ? sel.start : insertIndex;
      final pos = base + placeholder.length;
      ctrl.selection = TextSelection.collapsed(offset: pos);
      debugPrint('[PROC_DBG] controller selection moved to $pos');
    } catch (_) {
      debugPrint('[PROC_DBG] failed to set selection');
    }
  }

  void _startEdit(int index) {
    final id = widget.items[index].id;
    setState(() {
      _editing[id] = true;
      _stagedAttachments[id] = [];
      // ensure controller exists
      _controllers[id] = _controllers[id] ?? TextEditingController(text: widget.items[index].text);
      // focus
      Future.microtask(() => _focusNodes[id]?.requestFocus());
    });
  }

  void _saveItem(int index) {
    debugPrint('[PROC_DBG] _saveItem index=$index');
    final updated = List<ProcedureItem>.from(widget.items);
    final item = updated[index];
    final id = item.id;
    final ctrl = _controllers[id]!;
    final staged = _stagedAttachments[id] ?? [];
    debugPrint('[PROC_DBG] saving id=$id text="${ctrl.text}" staged=${staged.map((a) => a.fileName).toList()} existing=${item.attachments.map((a) => a.fileName).toList()}');
    updated[index] = item.copyWith(
      text: ctrl.text,
      attachments: [...item.attachments, ...staged],
    );
    _editing[id] = false;
    _stagedAttachments[id] = [];
    _emit(_reorder(updated));
  }

  void _cancelEdit(int index) {
    final id = widget.items[index].id;
    // revert controller text to original
    _controllers[id]?.text = widget.items[index].text;
    _stagedAttachments[id] = [];
    setState(() => _editing[id] = false);
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
        content: StatefulBuilder(builder: (ctx2, setState) {
          // Ensure the default text is selected after the dialog is shown
          WidgetsBinding.instance.addPostFrameCallback((_) {
            try {
              ctrl.selection = TextSelection(baseOffset: 0, extentOffset: ctrl.text.length);
            } catch (_) {}
          });
          return TextField(
            controller: ctrl,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Image label',
              hintText: 'e.g. Login screenshot',
              suffixText: ext,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (v) => Navigator.pop(ctx, v.trim().isEmpty ? null : v),
          );
        }),
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
                focusNode: _focusNodes[item.id]!,
                isEditing: _editing[item.id] ?? false,
                onSave: () => _saveItem(i),
                onCancel: () => _cancelEdit(i),
                onEnterEdit: () => _startEdit(i),
                hint: widget.itemHint,
                onTextChanged: (text) => _onTextChanged(i, text),
                onPickImage: () => _pickImage(ctx, i),
                onDelete: () => _deleteItem(i),
                onShowImage: (att) => _showImagePreview(ctx, att),
                stagedAttachments: _stagedAttachments[item.id],
              );
            },
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ProcedureItemRow extends StatefulWidget {
  final int index;
  final ProcedureItem item;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onEnterEdit;
  final String hint;
  final ValueChanged<String> onTextChanged;
  final VoidCallback onPickImage;
  final VoidCallback onDelete;
  final ValueChanged<Attachment> onShowImage;
  final List<Attachment>? stagedAttachments;
  const _ProcedureItemRow({
    super.key,
    required this.index,
    required this.item,
    required this.controller,
    required this.focusNode,
    required this.isEditing,
    required this.onSave,
    required this.onCancel,
    required this.onEnterEdit,
    required this.hint,
    required this.onTextChanged,
    required this.onPickImage,
    required this.onDelete,
    required this.onShowImage,
    this.stagedAttachments,
  });

  @override
  State<_ProcedureItemRow> createState() => _ProcedureItemRowState();
}

class _ProcedureItemRowState extends State<_ProcedureItemRow> {
  void _onFocusChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant _ProcedureItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_onFocusChanged);
      widget.focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final hasFocus = widget.focusNode.hasFocus;
    final editing = widget.isEditing || hasFocus || widget.controller.text.isEmpty;
    final combinedAttachments = [
      ...widget.item.attachments,
      ...?widget.stagedAttachments,
    ];
    if (hasFocus) {
      // Place the caret at the end so users can continue typing after a tap.
      try {
        final end = widget.controller.text.length;
        widget.controller.selection = TextSelection.collapsed(offset: end);
      } catch (_) {}
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: NumberedDragHandle(index: widget.index),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Edit mode: show TextField and Save / Cancel actions.
                if (editing)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: widget.controller,
                        focusNode: widget.focusNode,
                        decoration: InputDecoration(
                          hintText: widget.hint,
                          isDense: true,
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.image_outlined, size: 18),
                            tooltip: 'Insert image',
                            onPressed: widget.onPickImage,
                          ),
                        ),
                        maxLines: null,
                        onChanged: widget.onTextChanged,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          FilledButton.icon(
                            icon: const Icon(Icons.check),
                            label: const Text('Save'),
                            onPressed: widget.onSave,
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.close),
                            label: const Text('Cancel'),
                            onPressed: widget.onCancel,
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: widget.onEnterEdit,
                    child: ProcedureText(
                      text: widget.item.text,
                      attachments: widget.item.attachments,
                      onAttachmentTap: widget.onShowImage,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                // Attachment chips (include staged attachments while editing)
                if (combinedAttachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: combinedAttachments.map((att) {
                        return ActionChip(
                          avatar: const Icon(Icons.photo, size: 14),
                          label: Text(
                            att.filePath.isNotEmpty
                                ? p.basenameWithoutExtension(att.fileName)
                                : att.fileName,
                            style: const TextStyle(fontSize: 12),
                          ),
                          onPressed: () => widget.onShowImage(att),
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
              onPressed: widget.onDelete,
              tooltip: 'Remove item',
            ),
          ),
        ],
      ),
    );
  }
}
