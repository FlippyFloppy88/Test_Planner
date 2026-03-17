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
    final plansAsync = ref.watch(testPlansProvider);

    return plansAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (plans) {
        late final TestPlan plan;
        try {
          plan = plans.firstWhere((p) => p.id == planId);
        } catch (_) {
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
                          await ref
                              .read(testPlansProvider.notifier)
                              .reorderTestCases(plan.id, oldIdx, newIdx);
                        },
                        itemBuilder: (ctx, i) {
                          final tc = plan.testCases[i];
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
    final name = await showInputDialog(context,
        title: 'New Test Case', label: 'Test Case Name');
    if (name == null || name.isEmpty) return;
    await ref.read(testPlansProvider.notifier).addTestCase(planId, name, '');
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
  Widget build(BuildContext context) {
    final tc = widget.tc;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 12, right: 4),
            leading: NumberedDragHandle(index: widget.index),
            title: Text(tc.name),
            subtitle: Text(
              '${tc.steps.length} test${tc.steps.length != 1 ? 's' : ''} · ${tc.updatedAt.toDisplayDate()}',
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
                  onPressed: () =>
                      context.go('/test-plans/${widget.planId}/case/${tc.id}'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Delete',
                  onPressed: _onDelete,
                ),
              ],
            ),
            onTap: () =>
                context.go('/test-plans/${widget.planId}/case/${tc.id}'),
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
