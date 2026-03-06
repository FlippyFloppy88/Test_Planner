import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import '../common/procedure_widget.dart';
import '../common/numbered_drag_handle.dart';

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
    this.parentPathSegment = '',
  });

  @override
  State<TestStepEditor> createState() => _TestStepEditorState();
}

class _TestStepEditorState extends State<TestStepEditor> {
  late TextEditingController _nameCtrl;
  late TextEditingController _storyCtrl;
  late TextEditingController _expectedDescCtrl;
  bool _expanded = true;
  bool _procedureExpanded = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.step.name);
    _storyCtrl = TextEditingController(text: widget.step.storyLink);
    _expectedDescCtrl =
        TextEditingController(text: widget.step.expectedResult.description);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _storyCtrl.dispose();
    _expectedDescCtrl.dispose();
    super.dispose();
  }

  void _emit(TestStep step) => widget.onChanged(step);

  /// The path segment for THIS step, e.g. "step_1" or "step_1_sub_3".
  String get _myPathSegment {
    if (widget.parentPathSegment.isEmpty) {
      return 'step_${widget.stepIndex + 1}';
    }
    return '${widget.parentPathSegment}_sub_${widget.stepIndex + 1}';
  }

  /// Full relative image path for THIS step's procedure:
  /// e.g. "My_Test_Case/step_1" or "My_Test_Case/step_1_sub_3"
  String get _procedureRelativePath => '${widget.testCaseName}/$_myPathSegment';

  void _onFieldChanged() {
    _emit(widget.step.copyWith(
      name: _nameCtrl.text,
      storyLink: _storyCtrl.text,
      expectedResult: widget.step.expectedResult.copyWith(
        description: _expectedDescCtrl.text,
      ),
    ));
  }

  void _addSubStep() {
    final sub = TestStep(
      id: _uuid.v4(),
      order: widget.step.subSteps.length + 1,
      name: 'Sub-step ${widget.step.subSteps.length + 1}',
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
                widget.step.name.isEmpty ? 'Unnamed Step' : widget.step.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
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
                          labelText: 'Step Name *', isDense: true),
                      onChanged: (_) => _onFieldChanged(),
                    ),
                    const SizedBox(height: 16),
                    _ExpandableSection(
                      title: 'Procedure',
                      expanded: _procedureExpanded,
                      onToggle: () => setState(
                          () => _procedureExpanded = !_procedureExpanded),
                      child: ProcedureWidget(
                        items: widget.step.procedure,
                        onChanged: (items) =>
                            _emit(widget.step.copyWith(procedure: items)),
                        storageFolderPath: widget.storageFolderPath,
                        imageRelativePath: _procedureRelativePath,
                        itemHint: 'Describe this procedure step...',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExpectedResult(context),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _storyCtrl,
                      decoration: const InputDecoration(
                          labelText: 'Story / Bug Link (optional)',
                          hintText: 'https://jira.example.com/...',
                          isDense: true),
                      onChanged: (_) => _onFieldChanged(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Sub-steps',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Spacer(),
                        TextButton.icon(
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add Sub-step'),
                          onPressed: _addSubStep,
                        ),
                      ],
                    ),
                    if (widget.step.subSteps.isNotEmpty)
                      ReorderableListView.builder(
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
                            parentPathSegment: _myPathSegment,
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

  Widget _buildExpectedResult(BuildContext context) {
    final er = widget.step.expectedResult;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expected Result', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          controller: _expectedDescCtrl,
          decoration: const InputDecoration(
              labelText: 'Description / Question', isDense: true),
          maxLines: 2,
          onChanged: (_) => _onFieldChanged(),
        ),
        const SizedBox(height: 8),
        SegmentedButton<AnswerType>(
          segments: const [
            ButtonSegment(value: AnswerType.none, label: Text('None')),
            ButtonSegment(value: AnswerType.passFail, label: Text('Pass/Fail')),
            ButtonSegment(value: AnswerType.value, label: Text('Value')),
          ],
          selected: {er.answerType},
          onSelectionChanged: (sel) {
            _emit(widget.step.copyWith(
              expectedResult: er.copyWith(answerType: sel.first),
            ));
          },
        ),
        if (er.answerType == AnswerType.value) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: er.minValue?.toString() ?? '',
                  decoration: const InputDecoration(
                      labelText: 'Min Value', isDense: true),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _emit(widget.step.copyWith(
                    expectedResult: er.copyWith(minValue: double.tryParse(v)),
                  )),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: er.maxValue?.toString() ?? '',
                  decoration: const InputDecoration(
                      labelText: 'Max Value', isDense: true),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _emit(widget.step.copyWith(
                    expectedResult: er.copyWith(maxValue: double.tryParse(v)),
                  )),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: er.unit ?? '',
                  decoration: const InputDecoration(
                      labelText: 'Unit (optional)', isDense: true),
                  onChanged: (v) => _emit(widget.step.copyWith(
                    expectedResult: er.copyWith(unit: v),
                  )),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

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
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),
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
