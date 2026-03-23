import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/dialogs.dart';
import '../../widgets/common/numbered_drag_handle.dart';
import '../../utils/date_utils.dart';

class TestPlanDetailScreen extends ConsumerWidget {
  final String planId;
  const TestPlanDetailScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('[NAV_DBG] TestPlanDetailScreen.build called planId=$planId');
    final plansAsync = ref.watch(testPlansProvider);
    debugPrint('[NAV_DBG] testPlansProvider state: ${plansAsync.runtimeType}');

    return plansAsync.when(
      loading: () {
        debugPrint('[NAV_DBG] TestPlanDetailScreen -> loading state');
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      error: (e, st) {
        debugPrint('[NAV_DBG] TestPlanDetailScreen -> error state: $e');
        return Scaffold(body: Center(child: Text('Error: $e')));
      },
      data: (plans) {
        debugPrint('[NAV_DBG] TestPlanDetailScreen -> data state: ${plans.length} plans');
        late final TestPlan plan;
        try {
          plan = plans.firstWhere((p) => p.id == planId);
          debugPrint('[NAV_DBG] Found plan "${plan.name}" with ${plan.testCases.length} test cases');
          for (var i = 0; i < plan.testCases.length; i++) {
            debugPrint('[NAV_DBG]   case[$i] id=${plan.testCases[i].id} name="${plan.testCases[i].name}"');
          }
        } catch (e) {
          debugPrint('[NAV_DBG] Plan id=$planId NOT FOUND in ${plans.length} plans');
          return Scaffold(
            appBar: AppBar(title: const Text('Test Plan')),
            body: Center(child: Text('Plan not found')),
          );
        }

        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go('/test-plans'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plan.name,
                              style: Theme.of(context).textTheme.headlineSmall),
                          Text(
                              '${plan.testCases.length} test case${plan.testCases.length != 1 ? 's' : ''}',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Execute'),
                      onPressed: plan.testCases.isEmpty
                          ? null
                          : () => _startExecution(context, ref, plan),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Test Case'),
                      onPressed: () => _addTestCase(context, ref, plan.id),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),

              // Test Cases list
              Expanded(
                child: plan.testCases.isEmpty
                    ? EmptyState(
                        icon: Icons.assignment_outlined,
                        title: 'No Test Cases',
                        subtitle: 'Add test cases to this plan.',
                        actionLabel: 'Add Test Case',
                        onAction: () => _addTestCase(context, ref, plan.id),
                      )
                    : ReorderableListView.builder(
                        buildDefaultDragHandles: false,
                        padding: const EdgeInsets.all(16),
                        itemCount: plan.testCases.length,
                        onReorder: (oldIdx, newIdx) async {
                          if (newIdx > oldIdx) newIdx--;
                          debugPrint('[NAV_DBG] reorderTestCases oldIdx=$oldIdx newIdx=$newIdx');
                          await ref
                              .read(testPlansProvider.notifier)
                              .reorderTestCases(plan.id, oldIdx, newIdx);
                        },
                        itemBuilder: (ctx, i) {
                          final tc = plan.testCases[i];
                          debugPrint('[NAV_DBG] itemBuilder[$i] building _TestCaseCard id=${tc.id} name="${tc.name}"');
                          return _TestCaseCard(
                            key: ValueKey(tc.id),
                            tc: tc,
                            index: i,
                            planId: plan.id,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addTestCase(
      BuildContext context, WidgetRef ref, String planId) async {
    debugPrint('[NAV_DBG] _addTestCase called for planId=$planId');
    final name = await showInputDialog(context,
        title: 'New Test Case', label: 'Test Case Name');
    if (name == null || name.isEmpty) {
      debugPrint('[NAV_DBG] _addTestCase cancelled (no name)');
      return;
    }
    debugPrint('[NAV_DBG] _addTestCase adding "$name" to planId=$planId');
    await ref.read(testPlansProvider.notifier).addTestCase(planId, name, '');
    debugPrint('[NAV_DBG] _addTestCase done');
  }

  Future<void> _startExecution(
      BuildContext context, WidgetRef ref, TestPlan plan) async {
    final existingRuns = ref.read(testRunsProvider).valueOrNull ?? [];
    ref.read(executionProvider.notifier).startTestPlan(
          plan: plan,
          existingRuns: existingRuns,
        );
    if (context.mounted) context.go('/execution');
  }
}

// ── Per-test-case card with numbered drag handle + expandable tests list ─────
class _TestCaseCard extends ConsumerStatefulWidget {
  final TestCase tc;
  final int index;
  final String planId;

  const _TestCaseCard({
    required super.key,
    required this.tc,
    required this.index,
    required this.planId,
  });

  @override
  ConsumerState<_TestCaseCard> createState() => _TestCaseCardState();
}

class _TestCaseCardState extends ConsumerState<_TestCaseCard> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    debugPrint('[NAV_DBG] _TestCaseCard MOUNTED id=${widget.tc.id} name="${widget.tc.name}" index=${widget.index}');
  }

  @override
  void didUpdateWidget(_TestCaseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tc.id != widget.tc.id || oldWidget.index != widget.index) {
      debugPrint('[NAV_DBG] _TestCaseCard didUpdateWidget: id ${oldWidget.tc.id}->${widget.tc.id} index ${oldWidget.index}->${widget.index}');
    }
  }

  @override
  void dispose() {
    debugPrint('[NAV_DBG] _TestCaseCard DISPOSED id=${widget.tc.id} name="${widget.tc.name}"');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tc = widget.tc;
    debugPrint('[NAV_DBG] _TestCaseCard.build id=${tc.id} name="${tc.name}" index=${widget.index}');
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final incomplete = _isTestCaseIncomplete(tc);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 12, right: 4),
            leading: NumberedDragHandle(index: widget.index),
            title: Text(tc.name),
            subtitle: Row(
              children: [
                if (incomplete) ...[
                  Icon(Icons.warning_amber_rounded, size: 14, color: colors.error),
                  const SizedBox(width: 4),
                  Text(
                    'Incomplete · ',
                    style: textTheme.bodySmall?.copyWith(color: colors.error),
                  ),
                ],
                Text(
                  '${tc.steps.length} test${tc.steps.length != 1 ? 's' : ''} · ${tc.updatedAt.toDisplayDate()}',
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Expand/collapse tests
                IconButton(
                  icon: AnimatedRotation(
                    turns: _expanded ? 0.0 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more),
                  ),
                  tooltip: _expanded ? 'Collapse' : 'Show tests',
                  onPressed: () => setState(() => _expanded = !_expanded),
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  tooltip: 'Open test case',
                  onPressed: () {
                    debugPrint('[NAV_DBG] Open button pressed -> context.go(/test-plans/${widget.planId}/case/${tc.id})');
                    context.go('/test-plans/${widget.planId}/case/${tc.id}');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Delete',
                  onPressed: _onDelete,
                ),
              ],
            ),
            onTap: () {
              debugPrint('[NAV_DBG] ListTile onTap -> context.go(/test-plans/${widget.planId}/case/${tc.id})');
              context.go('/test-plans/${widget.planId}/case/${tc.id}');
            },
          ),

          // ── Expanded tests list ─────────────────────────────────────
          if (_expanded) ...[
            const Divider(height: 1),
            if (tc.steps.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'No tests yet — open the test case to add some.',
                    style: textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tc.steps.length,
                itemBuilder: (_, j) {
                  final step = tc.steps[j];
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(left: 56, right: 16),
                    leading: Text(
                      '${j + 1}.',
                      style: textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                    title: Text(step.name,
                        style: textTheme.bodyMedium),
                  );
                },
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _onDelete() async {
    final ok = await showConfirmDialog(context,
        title: 'Delete Test Case',
        content: 'Delete "${widget.tc.name}"? This cannot be undone.');
    if (ok && mounted) {
      await ref
          .read(testPlansProvider.notifier)
          .deleteTestCase(widget.planId, widget.tc.id);
    }
  }
}

bool _isTestCaseIncomplete(TestCase tc) {
  if (tc.steps.isEmpty) return true;
  for (final step in tc.steps) {
    final er = step.expectedResult;
    if (er.items.isEmpty && er.description.isEmpty) return true;
  }
  return false;
}
