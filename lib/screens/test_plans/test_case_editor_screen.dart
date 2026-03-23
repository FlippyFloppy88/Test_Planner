import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/test_step/test_step_editor.dart';
import '../../widgets/common/procedure_widget.dart';

/// Strips characters unsafe for folder names, returns a compact slug.
String _safeName(String s) => s
    .replaceAll(RegExp(r'[^\w\s-]'), '')
    .replaceAll(RegExp(r'\s+'), '_')
    .trim();

const _uuid = Uuid();

class TestCaseEditorScreen extends ConsumerStatefulWidget {
  final String planId;
  final String caseId;

  const TestCaseEditorScreen({
    super.key,
    required this.planId,
    required this.caseId,
  });

  @override
  ConsumerState<TestCaseEditorScreen> createState() =>
      _TestCaseEditorScreenState();
}

class _TestCaseEditorScreenState extends ConsumerState<TestCaseEditorScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _jiraInputCtrl;
  List<TestStep>? _steps;
  List<ProcedureItem> _preconditions = [];
  List<String> _jiraLinks = [];
  String _planImageFolder = '';
  bool _dirty = false;
  Timer? _autoSaveTimer;
  bool _precondExpanded = false;
  bool _jiraExpanded = false;
  bool _testsExpanded = true;

  @override
  void initState() {
    super.initState();
    debugPrint('[NAV_DBG] TestCaseEditorScreen.initState planId=${widget.planId} caseId=${widget.caseId}');
    _nameCtrl = TextEditingController();
    _descCtrl = TextEditingController();
    _jiraInputCtrl = TextEditingController();
    // Eagerly load from the provider if data is already available.
    // This avoids scheduling a postFrameCallback from inside build(), which
    // races with go_router's async _processParsedRouteInformation and causes
    // a "setState during build" crash on the Router widget.
    final plans = ref.read(testPlansProvider).valueOrNull;
    if (plans != null) _loadFromPlan(plans);
  }

  /// Sets dirty and starts a 10-second auto-save timer if one isn't already
  /// running. Subsequent changes while the timer is active do nothing — the
  /// existing countdown continues uninterrupted.
  void _markDirty() {
    if (!_dirty) setState(() => _dirty = true);
    if (_autoSaveTimer == null || !_autoSaveTimer!.isActive) {
      _autoSaveTimer = Timer(const Duration(seconds: 3), () {
        if (mounted && _dirty) _save(silent: true);
      });
    }
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _jiraInputCtrl.dispose();
    super.dispose();
  }

  void _loadFromPlan(List<TestPlan> plans) {
    if (_steps != null) return;
    debugPrint('[NAV_DBG] _loadFromPlan called: ${plans.length} plans, looking for planId=${widget.planId} caseId=${widget.caseId}');
    for (final p in plans) {
      debugPrint('[NAV_DBG]   plan id=${p.id} name="${p.name}" cases=${p.testCases.length}');
      for (final c in p.testCases) {
        debugPrint('[NAV_DBG]     case id=${c.id} name="${c.name}"');
      }
    }
    final plan = plans.firstWhere((p) => p.id == widget.planId,
        orElse: () => throw StateError('Plan not found: ${widget.planId}'));
    final tc = plan.testCases.firstWhere((c) => c.id == widget.caseId,
        orElse: () => throw StateError('Case not found: ${widget.caseId} in plan ${plan.id}'));
    debugPrint('[NAV_DBG] _loadFromPlan found plan "${plan.name}" case "${tc.name}" steps=${tc.steps.length}');
    _nameCtrl.text = tc.name;
    _descCtrl.text = tc.description;
    _steps = List<TestStep>.from(tc.steps);
    _preconditions = List<ProcedureItem>.from(tc.preconditions);
    _jiraLinks = List<String>.from(tc.jiraLinks);
    _planImageFolder = 'test_plans/${_safeName(plan.name.isEmpty ? plan.id : plan.name)}';
    debugPrint('[NAV_DBG] _loadFromPlan complete _planImageFolder=$_planImageFolder');
  }

  /// Collect all storyLinks from steps and sub-steps recursively.
  Set<String> _collectStepLinks(List<TestStep> steps) {
    final links = <String>{};
    for (final step in steps) {
      if (step.storyLink.isNotEmpty) links.add(step.storyLink);
      links.addAll(_collectStepLinks(step.subSteps));
    }
    return links;
  }

  /// Merge step links into _jiraLinks (no duplicates).
  void _syncJiraLinksFromSteps() {
    final stepLinks = _collectStepLinks(_steps ?? []);
    for (final link in stepLinks) {
      if (!_jiraLinks.contains(link)) {
        _jiraLinks = [..._jiraLinks, link];
      }
    }
  }

  Future<void> _save({bool silent = false}) async {
    _syncJiraLinksFromSteps();
    final plans = ref.read(testPlansProvider).valueOrNull ?? [];
    final plan = plans.firstWhere((p) => p.id == widget.planId);
    final tc = plan.testCases.firstWhere((c) => c.id == widget.caseId);
    final updated = tc.copyWith(
      name: _nameCtrl.text,
      description: _descCtrl.text,
      preconditions: _preconditions,
      jiraLinks: _jiraLinks,
      steps: _steps ?? [],
      updatedAt: DateTime.now(),
    );
    await ref
        .read(testPlansProvider.notifier)
        .updateTestCase(widget.planId, updated);
    if (mounted) {
      if (!silent) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Test case saved.')));
      }
      setState(() => _dirty = false);
    }
  }

  void _addStep() {
    setState(() {
      _steps = [
        ...(_steps ?? []),
        TestStep(
          id: _uuid.v4(),
          order: (_steps?.length ?? 0) + 1,
          name: 'Test ${(_steps?.length ?? 0) + 1}',
          expectedResult: const ExpectedResult(),
        ),
      ];
      _dirty = true;
    });
    _markDirty();
  }

  void _updateStep(int index, TestStep updated) {
    setState(() {
      final newSteps = List<TestStep>.from(_steps!);
      newSteps[index] = updated;
      _steps = newSteps;
      _dirty = true;
      _syncJiraLinksFromSteps();
    });
    _markDirty();
  }

  void _deleteStep(int index) {
    setState(() {
      _steps = List<TestStep>.from(_steps!)..removeAt(index);
      _dirty = true;
    });
    _markDirty();
  }

  void _addJiraLink() {
    final val = _jiraInputCtrl.text.trim();
    if (val.isEmpty || _jiraLinks.contains(val)) return;
    setState(() {
      _jiraLinks = [..._jiraLinks, val];
      _jiraInputCtrl.clear();
      _dirty = true;
    });
    _markDirty();
  }

  void _removeJiraLink(String link) {
    setState(() {
      _jiraLinks = _jiraLinks.where((l) => l != link).toList();
      _dirty = true;
    });
    _markDirty();
  }

  /// Returns true if the test case is incomplete:
  ///  - no test steps at all, OR
  ///  - any step has no expected result (items list empty AND legacy description empty)
  bool _isIncomplete() {
    if (_steps == null || _steps!.isEmpty) return true;
    for (final step in _steps!) {
      final er = step.expectedResult;
      if (er.items.isEmpty && er.description.isEmpty) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[NAV_DBG] TestCaseEditorScreen.build planId=${widget.planId} caseId=${widget.caseId} _steps=${_steps?.length}');
    final plansAsync = ref.watch(testPlansProvider);
    debugPrint('[NAV_DBG] TestCaseEditorScreen plansAsync=${plansAsync.runtimeType}');

    return plansAsync.when(
      loading: () {
        debugPrint('[NAV_DBG] TestCaseEditorScreen -> loading');
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      error: (e, st) {
        debugPrint('[NAV_DBG] TestCaseEditorScreen -> error: $e');
        return Scaffold(body: Center(child: Text('Error: \$e')));
      },
      data: (plans) {
        debugPrint('[NAV_DBG] TestCaseEditorScreen -> data: ${plans.length} plans, _steps=$_steps');
        if (_steps == null) {
          debugPrint('[NAV_DBG] TestCaseEditorScreen _steps==null, scheduling postFrameCallback');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            debugPrint('[NAV_DBG] postFrameCallback fired: mounted=$mounted _steps=$_steps');
            if (mounted && _steps == null) {
              debugPrint('[NAV_DBG] calling setState(_loadFromPlan) from postFrameCallback');
              setState(() => _loadFromPlan(plans));
              debugPrint('[NAV_DBG] setState(_loadFromPlan) returned');
            }
          });
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final title =
            _nameCtrl.text.isEmpty ? 'Edit Test Case' : _nameCtrl.text;

        return PopScope(
          canPop: !_dirty && !_isIncomplete(),
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            // Dirty check first.
            if (_dirty) {
              final save = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Unsaved Changes'),
                  content: const Text('Save before leaving?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Discard'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
              if (save == true) await _save();
              if (!context.mounted) return;
            }
            // Incomplete check.
            if (_isIncomplete()) {
              final proceed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Incomplete Test Case'),
                  content: const Text(
                    'This test case has no tests or is missing expected results.\n\n'
                    'Do you still want to leave without completing it?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Keep Editing'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Leave Anyway'),
                    ),
                  ],
                ),
              );
              if (proceed != true || !context.mounted) return;
            }
            if (context.mounted) context.pop();
          },
          child: Scaffold(
            body: Column(
              children: [
                // ── Top Bar ─────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_dirty)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: const Text('Unsaved'),
                            backgroundColor:
                                Theme.of(context).colorScheme.errorContainer,
                          ),
                        ),
                      FilledButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        onPressed: _save,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Name ────────────────────────────────────────────
                        TextField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                              labelText: 'Test Case Name *'),
                          onChanged: (_) => _markDirty(),
                        ),
                        const SizedBox(height: 16),

                        // ── Description (always visible) ─────────────────
                        TextField(
                          controller: _descCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Description (optional)',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: null,
                          minLines: 1,
                          onChanged: (_) => _markDirty(),
                        ),
                        const SizedBox(height: 12),

                        // ── Preconditions (expandable, ProcedureWidget) ───
                        _ExpandableSection(
                          title: 'Preconditions',
                          badge: _preconditions.isEmpty
                              ? null
                              : '${_preconditions.length} step${_preconditions.length != 1 ? 's' : ''}',
                          expanded: _precondExpanded,
                          onToggle: () => setState(
                              () => _precondExpanded = !_precondExpanded),
                          child: Builder(builder: (ctx) {
                            final storage = ref.read(storageServiceProvider);
                            // final tcName unused; keep test case name available elsewhere
                            return ProcedureWidget(
                              items: _preconditions,
                              onChanged: (items) {
                                setState(() => _preconditions = items);
                                _markDirty();
                              },
                              storageFolderPath: storage.hasFolderOpen
                                  ? storage.folderPath
                                  : '',
                              // Images organized per test plan rather than per step
                              imageRelativePath: _planImageFolder,
                              itemHint: 'Enter a precondition...',
                            );
                          }),
                        ),
                        const SizedBox(height: 12),

                        // ── Jira / Story Links (expandable) ──────────────
                        _ExpandableSection(
                          title: 'Jira / Story Links',
                          badge: _jiraLinks.isEmpty
                              ? null
                              : '${_jiraLinks.length} link${_jiraLinks.length != 1 ? 's' : ''}',
                          expanded: _jiraExpanded,
                          onToggle: () =>
                              setState(() => _jiraExpanded = !_jiraExpanded),
                          child: _buildJiraLinks(context),
                        ),
                        const SizedBox(height: 12),

                        // ── Tests ────────────────────────────────────────
                        _ExpandableSection(
                          title: 'Tests',
                          badge: (_steps == null || _steps!.isEmpty)
                              ? null
                              : '${_steps!.length} test${_steps!.length != 1 ? 's' : ''}',
                          expanded: _testsExpanded,
                          onToggle: () =>
                              setState(() => _testsExpanded = !_testsExpanded),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  FilledButton.tonalIcon(
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add Test'),
                                    onPressed: _addStep,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (_steps != null && _steps!.isNotEmpty)
                                ReorderableListView.builder(
                                  buildDefaultDragHandles: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _steps!.length,
                                  onReorder: (oldIdx, newIdx) {
                                    setState(() {
                                      if (newIdx > oldIdx) newIdx--;
                                      final s = List<TestStep>.from(_steps!);
                                      final item = s.removeAt(oldIdx);
                                      s.insert(newIdx, item);
                                      _steps = s;
                                      _dirty = true;
                                    });
                                    _markDirty();
                                  },
                                  itemBuilder: (ctx, i) {
                                    final storage =
                                        ref.read(storageServiceProvider);
                                    final tcName =
                                        _safeName(_nameCtrl.text.isEmpty
                                            ? widget.caseId
                                            : _nameCtrl.text);
                                    return TestStepEditor(
                                      key: ValueKey(_steps![i].id),
                                      step: _steps![i],
                                      stepIndex: i,
                                      depth: 0,
                                      storageFolderPath: storage.hasFolderOpen
                                          ? storage.folderPath
                                          : '',
                                      testCaseName: tcName,
                                      planImageRelativePath: _planImageFolder,
                                      onChanged: (updated) =>
                                          _updateStep(i, updated),
                                      onDelete: () => _deleteStep(i),
                                    );
                                  },
                                )
                              else
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.list_alt,
                                            size: 48, color: Colors.grey),
                                        const SizedBox(height: 8),
                                        const Text('No tests yet'),
                                        const SizedBox(height: 16),
                                        OutlinedButton.icon(
                                          icon: const Icon(Icons.add),
                                          label: const Text('Add First Test'),
                                          onPressed: _addStep,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildJiraLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input row
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _jiraInputCtrl,
                decoration: const InputDecoration(
                  labelText: 'Add link (URL or ticket ID)',
                  hintText: 'https://jira.example.com/browse/PROJ-123',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addJiraLink(),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add'),
              onPressed: _addJiraLink,
            ),
          ],
        ),
        if (_jiraLinks.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _jiraLinks.map((link) {
              return Chip(
                label: Text(link,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis),
                onDeleted: () => _removeJiraLink(link),
                deleteIconColor: Theme.of(context).colorScheme.error,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
        ] else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No links yet. Links added to steps are synced here automatically.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ExpandableSection extends StatelessWidget {
  final String title;
  /// If provided, shown as a small badge when the section is collapsed.
  final String? badge;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;

  const _ExpandableSection({
    required this.title,
    this.badge,
    required this.expanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Text(title,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(width: 6),
                // When collapsed and has content, show a count badge;
                // otherwise show the '(optional)' hint.
                if (!expanded && badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge!,
                      style: textTheme.labelSmall?.copyWith(
                          color: colors.onSecondaryContainer),
                    ),
                  )
                else
                  Text('(optional)',
                      style: textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant)),
                const Spacer(),
                Icon(
                  expanded ? Icons.expand_more : Icons.expand_less,
                  size: 18,
                  color: colors.primary,
                ),
              ],
            ),
          ),
        ),
        if (expanded) ...[
          const SizedBox(height: 8),
          child,
          const SizedBox(height: 8),
        ],
        const Divider(height: 1),
      ],
    );
  }
}
