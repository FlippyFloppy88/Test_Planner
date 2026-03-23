import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import '../../utils/image_pick_helper.dart';
import '../common/formatting_toolbar.dart';
import '../common/procedure_widget.dart';
import '../common/numbered_drag_handle.dart';
import '../common/procedure_text.dart';

const _uuid = Uuid();

/// Editor for a single [TestStep].
///
/// [storageFolderPath] and [testCaseName] are forwarded from the parent
/// [TestCaseEditorScreen] so that images can be saved to:
///   <storageFolderPath>/<testCaseName>/<stepSlug>/<imageName>
///   <storageFolderPath>/<testCaseName>/<stepSlug>_sub_<subIndex>/<imageName>
class TestStepEditor extends StatefulWidget {
  final TestStep step;

  /// 0-based index of this step among its siblings (used to build the path slug).
  final int stepIndex;

  final int depth;
  final ValueChanged<TestStep> onChanged;
  final VoidCallback? onDelete;

  /// Absolute path to the root storage folder.
  final String storageFolderPath;

  /// Sanitized test case name used as the top-level subfolder.
  final String testCaseName;
  final String planImageRelativePath;

  /// For sub-step editors: the path segment of the parent step, e.g. "step_1".
  /// Leave empty for top-level steps.
  final String parentPathSegment;

  const TestStepEditor({
    super.key,
    required this.step,
    required this.onChanged,
    this.stepIndex = 0,
    this.onDelete,
    this.depth = 0,
    this.storageFolderPath = '',
    this.testCaseName = '',
    this.planImageRelativePath = '',
    this.parentPathSegment = '',
  });

  @override
  State<TestStepEditor> createState() => _TestStepEditorState();
}

class _TestStepEditorState extends State<TestStepEditor> {
  late TextEditingController _nameCtrl;
  late TextEditingController _storyCtrl;
  bool _expanded = true;
  bool _procedureExpanded = false;

  // ── Expected result items state ─────────────────────────────────────────
  late List<ExpectedResultItem> _erItems;
  final Map<String, TextEditingController> _erControllers = {};  final Map<String, FocusNode> _erFocusNodes = {};  final Map<String, bool> _erEditing = {};
  final Map<String, List<Attachment>> _erStaged = {};
  final Map<String, String> _erOriginalTexts = {};

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.step.name);
    _storyCtrl = TextEditingController(text: widget.step.storyLink);
    _erItems = _effectiveItems(widget.step.expectedResult);
    _syncErControllers();
  }

  @override
  void didUpdateWidget(TestStepEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step.expectedResult != widget.step.expectedResult) {
      final newItems = _effectiveItems(widget.step.expectedResult);
      final oldIds = _erItems.map((e) => e.id).toSet();
      final newIds = newItems.map((e) => e.id).toSet();
      for (final id in oldIds.difference(newIds)) {
        _erControllers.remove(id)?.dispose();
        _erFocusNodes.remove(id)?.dispose();
        _erEditing.remove(id);
        _erStaged.remove(id);
        _erOriginalTexts.remove(id);
      }
      _erItems = newItems;
      _syncErControllers();
    }
    if (oldWidget.step.name != widget.step.name &&
        _nameCtrl.text != widget.step.name) {
      _nameCtrl.text = widget.step.name;
    }
    if (oldWidget.step.storyLink != widget.step.storyLink &&
        _storyCtrl.text != widget.step.storyLink) {
      _storyCtrl.text = widget.step.storyLink;
    }
  }

  List<ExpectedResultItem> _effectiveItems(ExpectedResult er) {
    if (er.items.isNotEmpty) return List<ExpectedResultItem>.from(er.items);
    if (er.description.isNotEmpty) {
      return [
        ExpectedResultItem(
          id: 'legacy_${widget.step.id}',
          observation: er.description,
          answerType: er.answerType,
          minValue: er.minValue,
          maxValue: er.maxValue,
          unit: er.unit,
        ),
      ];
    }
    return [];
  }

  void _syncErControllers() {
    for (final item in _erItems) {
      _erControllers.putIfAbsent(
          item.id, () => TextEditingController(text: item.observation));
      _erFocusNodes.putIfAbsent(item.id, () => FocusNode());
      _erEditing.putIfAbsent(item.id, () => false);
      _erStaged.putIfAbsent(item.id, () => []);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _storyCtrl.dispose();
    for (final c in _erControllers.values) {
      c.dispose();
    }
    for (final f in _erFocusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  void _emit(TestStep step) => widget.onChanged(step);

  void _emitErItems(List<ExpectedResultItem> items) {
    _erItems = items;
    _emit(widget.step.copyWith(
      expectedResult: widget.step.expectedResult.copyWith(items: items),
    ));
  }

  // ── ER item management ──────────────────────────────────────────────────

  void _addErItem() {
    final newItem = ExpectedResultItem(id: _uuid.v4(), order: _erItems.length);
    _erControllers[newItem.id] = TextEditingController();
    _erFocusNodes[newItem.id] = FocusNode();
    _erEditing[newItem.id] = true;
    _erStaged[newItem.id] = [];
    _erOriginalTexts[newItem.id] = '';
    setState(() => _erItems = [..._erItems, newItem]);
    _emitErItems(_erItems);
  }

  void _deleteErItem(int index) {
    final id = _erItems[index].id;
    _erControllers.remove(id)?.dispose();
    _erFocusNodes.remove(id)?.dispose();
    _erEditing.remove(id);
    _erStaged.remove(id);
    _erOriginalTexts.remove(id);
    setState(() => _erItems = List<ExpectedResultItem>.from(_erItems)..removeAt(index));
    _emitErItems(_erItems);
  }

  void _startErEdit(int index) {
    final id = _erItems[index].id;
    _erOriginalTexts[id] = _erItems[index].observation;
    setState(() {
      _erEditing[id] = true;
      _erStaged[id] = [];
    });
  }

  void _saveErItem(int index) {
    final updated = List<ExpectedResultItem>.from(_erItems);
    final item = updated[index];
    final id = item.id;
    updated[index] = item.copyWith(
      observation: _erControllers[id]!.text,
      attachments: [...item.attachments, ...(_erStaged[id] ?? [])],
    );
    setState(() {
      _erEditing[id] = false;
      _erStaged[id] = [];
      _erOriginalTexts.remove(id);
      _erItems = updated;
    });
    _emitErItems(updated);
  }

  void _cancelErEdit(int index) {
    final id = _erItems[index].id;
    final orig = _erOriginalTexts.remove(id) ?? _erItems[index].observation;
    _erControllers[id]?.text = orig;
    _erStaged[id] = [];
    final updated = List<ExpectedResultItem>.from(_erItems);
    updated[index] = updated[index].copyWith(observation: orig);
    setState(() {
      _erEditing[id] = false;
      _erItems = updated;
    });
    _emitErItems(updated);
  }

  void _updateErItemType(int index, AnswerType type) {
    final updated = List<ExpectedResultItem>.from(_erItems);
    updated[index] = updated[index].copyWith(answerType: type);
    setState(() => _erItems = updated);
    _emitErItems(updated);
  }

  void _updateErValueRange(int index, {double? min, double? max, String? unit}) {
    final updated = List<ExpectedResultItem>.from(_erItems);
    final e = updated[index];
    updated[index] = e.copyWith(
      minValue: min ?? e.minValue,
      maxValue: max ?? e.maxValue,
      unit: unit ?? e.unit,
    );
    setState(() => _erItems = updated);
    _emitErItems(updated);
  }

  Future<void> _pickErImage(BuildContext context, int index) async {
    final result = await pickAndInsertImage(
      context: context,
      storageFolderPath: widget.storageFolderPath,
      imageRelativePath: widget.planImageRelativePath,
    );
    if (result == null || !mounted) return;
    final id = _erItems[index].id;
    _erStaged[id] = [...(_erStaged[id] ?? []), result.attachment];
    final ctrl = _erControllers[id]!;
    final sel = ctrl.selection;
    final ins = sel.isValid ? sel.start : ctrl.text.length;
    ctrl.text = ctrl.text.replaceRange(
        ins, sel.isValid ? sel.end : ins, result.placeholder);
    final updated = List<ExpectedResultItem>.from(_erItems);
    updated[index] = updated[index].copyWith(observation: ctrl.text);
    setState(() => _erItems = updated);
  }

  // ── Sub-step management ─────────────────────────────────────────────────

  void _addSubStep() {
    final sub = TestStep(
      id: _uuid.v4(),
      order: widget.step.subSteps.length + 1,
      name: 'Sub-test ${widget.step.subSteps.length + 1}',
      expectedResult: const ExpectedResult(),
    );
    _emit(widget.step.copyWith(subSteps: [...widget.step.subSteps, sub]));
  }

  void _updateSubStep(int index, TestStep updated) {
    final subs = List<TestStep>.from(widget.step.subSteps);
    subs[index] = updated;
    _emit(widget.step.copyWith(subSteps: subs));
  }

  void _deleteSubStep(int index) {
    final subs = List<TestStep>.from(widget.step.subSteps)..removeAt(index);
    _emit(widget.step.copyWith(subSteps: subs));
  }

  @override
  Widget build(BuildContext context) {
    final indent = widget.depth * 24.0;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            ListTile(
              leading: NumberedDragHandle(index: widget.stepIndex),
              title: Text(
                widget.step.name.isEmpty ? 'Unnamed Test' : widget.step.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(_expanded ? Icons.expand_more : Icons.expand_less),
                    onPressed: () => setState(() => _expanded = !_expanded),
                  ),
                  if (widget.onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: colors.error,
                      onPressed: widget.onDelete,
                    ),
                ],
              ),
            ),
            if (_expanded) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Test Name *', isDense: true),
                      maxLines: null,
                      minLines: 1,
                      onChanged: (_) =>
                          _emit(widget.step.copyWith(name: _nameCtrl.text)),
                    ),
                    const SizedBox(height: 16),
                    _ExpandableSection(
                      title: 'Procedure',
                      expanded: _procedureExpanded,
                      onToggle: () =>
                          setState(() => _procedureExpanded = !_procedureExpanded),
                      child: ProcedureWidget(
                        items: widget.step.procedure,
                        onChanged: (items) =>
                            _emit(widget.step.copyWith(procedure: items)),
                        storageFolderPath: widget.storageFolderPath,
                        imageRelativePath: widget.planImageRelativePath,
                        itemHint: 'Describe this procedure step...',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExpectedResults(context),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _storyCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Story / Bug Link (optional)',
                          hintText: 'https://jira.example.com/...',
                          isDense: true),
                      maxLines: null,
                      minLines: 1,
                      onChanged: (_) =>
                          _emit(widget.step.copyWith(storyLink: _storyCtrl.text)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Sub-tests',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Spacer(),
                        TextButton.icon(
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add Sub-test'),
                          onPressed: _addSubStep,
                        ),
                      ],
                    ),
                    if (widget.step.subSteps.isNotEmpty)
                      ReorderableListView.builder(
                        buildDefaultDragHandles: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.step.subSteps.length,
                        onReorder: (oldIndex, newIndex) {
                          final subs =
                              List<TestStep>.from(widget.step.subSteps);
                          final item = subs.removeAt(oldIndex);
                          if (newIndex > oldIndex) newIndex--;
                          subs.insert(newIndex, item);
                          _emit(widget.step.copyWith(subSteps: subs));
                        },
                        itemBuilder: (ctx, i) {
                          final sub = widget.step.subSteps[i];
                          return TestStepEditor(
                            key: ValueKey(sub.id),
                            step: sub,
                            stepIndex: i,
                            depth: widget.depth + 1,
                            storageFolderPath: widget.storageFolderPath,
                            testCaseName: widget.testCaseName,
                            parentPathSegment: '',
                            planImageRelativePath: widget.planImageRelativePath,
                            onChanged: (updated) => _updateSubStep(i, updated),
                            onDelete: () => _deleteSubStep(i),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExpectedResults(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Expected Results',
                style:
                    textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Expected Result'),
              onPressed: _addErItem,
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (_erItems.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No expected results yet. Add one to describe what to look for.',
              style: textTheme.bodySmall
                  ?.copyWith(color: colors.onSurfaceVariant),
            ),
          )
        else
          Column(
            children: List.generate(_erItems.length, (i) {
              final item = _erItems[i];
              final isEditing = _erEditing[item.id] ?? false;
              return _ErItemCard(
                key: ValueKey(item.id),
                index: i,
                item: item,
                controller: _erControllers[item.id]!,
                focusNode: _erFocusNodes[item.id]!,
                isEditing: isEditing,
                stagedAttachments: _erStaged[item.id] ?? [],
                storageFolderPath: widget.storageFolderPath,
                onEdit: () => _startErEdit(i),
                onSave: () => _saveErItem(i),
                onCancel: () => _cancelErEdit(i),
                onDelete: () => _deleteErItem(i),
                onPickImage: () => _pickErImage(context, i),
                onShowImage: (att) =>
                    showImagePreview(context, att, widget.storageFolderPath),
                onTypeChanged: (t) => _updateErItemType(i, t),
                onMinChanged: (v) =>
                    _updateErValueRange(i, min: double.tryParse(v)),
                onMaxChanged: (v) =>
                    _updateErValueRange(i, max: double.tryParse(v)),
                onUnitChanged: (v) => _updateErValueRange(i, unit: v),
              );
            }),
          ),
        const Divider(height: 1),
      ],
    );
  }
}

// ── Expected result item card ─────────────────────────────────────────────────

class _ErItemCard extends StatelessWidget {
  final int index;
  final ExpectedResultItem item;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEditing;
  final List<Attachment> stagedAttachments;
  final String storageFolderPath;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onDelete;
  final VoidCallback onPickImage;
  final ValueChanged<Attachment> onShowImage;
  final ValueChanged<AnswerType> onTypeChanged;
  final ValueChanged<String> onMinChanged;
  final ValueChanged<String> onMaxChanged;
  final ValueChanged<String> onUnitChanged;

  const _ErItemCard({
    required super.key,
    required this.index,
    required this.item,
    required this.controller,
    required this.focusNode,
    required this.isEditing,
    required this.stagedAttachments,
    required this.storageFolderPath,
    required this.onEdit,
    required this.onSave,
    required this.onCancel,
    required this.onDelete,
    required this.onPickImage,
    required this.onShowImage,
    required this.onTypeChanged,
    required this.onMinChanged,
    required this.onMaxChanged,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final allAttachments = [...item.attachments, ...stagedAttachments];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(top: 2, right: 8),
                  decoration: BoxDecoration(
                      color: colors.secondaryContainer, shape: BoxShape.circle),
                  child: Center(
                    child: Text('${index + 1}',
                        style: textTheme.labelSmall
                            ?.copyWith(color: colors.onSecondaryContainer)),
                  ),
                ),
                Expanded(
                  child: isEditing
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormattingToolbar(
                              controller: controller,
                              focusNode: focusNode,
                              attachments: allAttachments,
                            ),
                            const SizedBox(height: 4),
                            TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                hintText:
                                    'Describe the expected result or question...',
                                isDense: true,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.image_outlined, size: 18),
                                  tooltip: 'Insert image',
                                  onPressed: onPickImage,
                                ),
                              ),
                              maxLines: null,
                              minLines: 1,
                            ),
                            const SizedBox(height: 6),
                            Row(children: [
                              FilledButton.icon(
                                icon: const Icon(Icons.check, size: 16),
                                label: const Text('Save'),
                                onPressed: onSave,
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.close, size: 16),
                                label: const Text('Cancel'),
                                onPressed: onCancel,
                              ),
                            ]),
                          ],
                        )
                      : GestureDetector(
                          onTap: onEdit,
                          child: item.observation.isEmpty
                              ? Text('(empty)',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      fontStyle: FontStyle.italic))
                              : ProcedureText(
                                  text: item.observation,
                                  attachments: item.attachments,
                                  onAttachmentTap: onShowImage,
                                  style: textTheme.bodyMedium,
                                ),
                        ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit_outlined,
                          size: 18, color: colors.primary),
                      tooltip: 'Edit',
                      onPressed: isEditing ? null : onEdit,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline,
                          size: 18, color: colors.error),
                      tooltip: 'Remove',
                      onPressed: onDelete,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
            if (allAttachments.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allAttachments.map((att) {
                  final absPath =
                      att.filePath.isNotEmpty && storageFolderPath.isNotEmpty
                          ? p.join(storageFolderPath, att.filePath)
                          : null;
                  final imageFile = absPath != null ? File(absPath) : null;
                  return Tooltip(
                    message: att.fileName,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => onShowImage(att),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          width: 64,
                          height: 64,
                          child: (imageFile != null && imageFile.existsSync())
                              ? Image.file(imageFile, fit: BoxFit.cover)
                              : Container(
                                  color: Colors.grey.shade200,
                                  child:
                                      const Icon(Icons.broken_image, size: 28),
                                ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 8),
            SegmentedButton<AnswerType>(
              segments: const [
                ButtonSegment(value: AnswerType.none, label: Text('None')),
                ButtonSegment(
                    value: AnswerType.passFail, label: Text('Pass/Fail')),
                ButtonSegment(value: AnswerType.value, label: Text('Value')),
              ],
              selected: {item.answerType},
              onSelectionChanged: (sel) => onTypeChanged(sel.first),
            ),
            if (item.answerType == AnswerType.value) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: item.minValue?.toString() ?? '',
                      decoration: const InputDecoration(
                          labelText: 'Min Value', isDense: true),
                      keyboardType: TextInputType.number,
                      onChanged: onMinChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: item.maxValue?.toString() ?? '',
                      decoration: const InputDecoration(
                          labelText: 'Max Value', isDense: true),
                      keyboardType: TextInputType.number,
                      onChanged: onMaxChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: item.unit ?? '',
                      decoration: const InputDecoration(
                          labelText: 'Unit (optional)', isDense: true),
                      onChanged: onUnitChanged,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Expandable section ────────────────────────────────────────────────────────

class _ExpandableSection extends StatelessWidget {
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;

  const _ExpandableSection({
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(width: 4),
                Text('(optional)',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant)),
                const Spacer(),
                Icon(expanded ? Icons.expand_more : Icons.expand_less,
                    size: 18, color: colors.onSurfaceVariant),
              ],
            ),
          ),
        ),
        if (expanded) ...[
          const SizedBox(height: 8),
          child,
        ],
      ],
    );
  }
}
