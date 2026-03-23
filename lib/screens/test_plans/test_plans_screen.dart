import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/dialogs.dart';
import '../../utils/date_utils.dart';

class TestPlansScreen extends ConsumerWidget {
  const TestPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(testPlansProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text('Test Plans',
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('New Test Plan'),
                  onPressed: () => _createTestPlan(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: plansAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (plans) {
                if (plans.isEmpty) {
                  return EmptyState(
                    icon: Icons.checklist,
                    title: 'No Test Plans Yet',
                    subtitle: 'Create a test plan to get started.',
                    actionLabel: 'New Test Plan',
                    onAction: () => _createTestPlan(context, ref),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: plans.length,
                  itemBuilder: (ctx, i) => _PlanCard(
                    key: ValueKey(plans[i].id),
                    plan: plans[i],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createTestPlan(BuildContext context, WidgetRef ref) async {
    final name = await showInputDialog(context,
        title: 'New Test Plan', label: 'Plan Name');
    if (name == null || name.isEmpty) return;
    await ref.read(testPlansProvider.notifier).addTestPlan(name, '');
  }
}

// ── Drag data passed between plans ──────────────────────────────────────────
class _TestCaseDragData {
  final String fromPlanId;
  final TestCase testCase;
  const _TestCaseDragData({required this.fromPlanId, required this.testCase});
}

// ── Per-plan card with expandable test cases + cross-plan DnD ───────────────
class _PlanCard extends ConsumerStatefulWidget {
  final TestPlan plan;
  const _PlanCard({required super.key, required this.plan});

  @override
  ConsumerState<_PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends ConsumerState<_PlanCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DragTarget<_TestCaseDragData>(
        onWillAcceptWithDetails: (d) => d.data.fromPlanId != plan.id,
        onAcceptWithDetails: (d) {
          ref.read(testPlansProvider.notifier).moveTestCase(
              d.data.fromPlanId, d.data.testCase.id, plan.id);
        },
        builder: (ctx, candidateData, _) {
          final isHovered = candidateData.isNotEmpty;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: isHovered
                  ? Border.all(color: colors.primary, width: 2)
                  : Border.all(color: Colors.transparent, width: 2),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              color: isHovered ? colors.primaryContainer : null,
              child: Column(
                children: [
                  // ── Header row ────────────────────────────────────────
                  ListTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.checklist)),
                    title: Text(plan.name),
                    subtitle: Text(
                      '${plan.testCases.length} test case${plan.testCases.length != 1 ? 's' : ''} · Updated ${plan.updatedAt.toDisplayDate()}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: AnimatedRotation(
                            turns: _expanded ? 0.0 : 0.5,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.expand_more),
                          ),
                          tooltip: _expanded ? 'Collapse' : 'Show test cases',
                          onPressed: () =>
                              setState(() => _expanded = !_expanded),
                        ),
                        IconButton(
                          icon: const Icon(Icons.open_in_new),
                          tooltip: 'Open plan',
                          onPressed: () =>
                              context.go('/test-plans/${plan.id}'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy_outlined),
                          tooltip: 'Duplicate plan',
                          onPressed: _onDuplicate,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Delete plan',
                          onPressed: _onDelete,
                        ),
                      ],
                    ),
                  ),

                  // ── Expanded test cases ───────────────────────────────
                  if (_expanded) ...[
                    const Divider(height: 1),
                    if (plan.testCases.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(
                          'No test cases — drag one here or open the plan to add.',
                          style: textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: plan.testCases.length,
                        itemBuilder: (_, j) {
                          final tc = plan.testCases[j];
                          return LongPressDraggable<_TestCaseDragData>(
                            data: _TestCaseDragData(
                                fromPlanId: plan.id, testCase: tc),
                            dragAnchorStrategy:
                                pointerDragAnchorStrategy,
                            feedback: Material(
                              elevation: 6,
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: 280,
                                child: ListTile(
                                  leading: const Icon(Icons.assignment),
                                  title: Text(tc.name),
                                  subtitle: const Text('Drag to another plan'),
                                ),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: _testCaseTile(
                                  context, plan.id, tc, colors, textTheme),
                            ),
                            child: _testCaseTile(
                                context, plan.id, tc, colors, textTheme),
                          );
                        },
                      ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _testCaseTile(BuildContext context, String planId, TestCase tc,
      ColorScheme colors, TextTheme textTheme) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: const Icon(Icons.assignment_outlined, size: 20),
      title: Text(tc.name, style: textTheme.bodyMedium),
      subtitle: Text(
        '${tc.steps.length} test${tc.steps.length != 1 ? 's' : ''}',
        style: textTheme.bodySmall,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new, size: 18),
        tooltip: 'Open test case',
        onPressed: () => context.go('/test-plans/$planId/case/${tc.id}'),
      ),
      onTap: () => context.go('/test-plans/$planId/case/${tc.id}'),
    );
  }

  Future<void> _onDuplicate() async {
    final name = await showInputDialog(
      context,
      title: 'Duplicate Test Plan',
      label: 'New Plan Name',
      initialValue: '${widget.plan.name} (copy)',
    );
    if (name == null || name.trim().isEmpty) return;
    if (mounted) {
      await ref
          .read(testPlansProvider.notifier)
          .duplicateTestPlan(widget.plan.id, name.trim());
    }
  }

  Future<void> _onDelete() async {
    final ok = await showConfirmDialog(context,
        title: 'Delete Test Plan',
        content: 'Delete "${widget.plan.name}"? This cannot be undone.');
    if (ok && mounted) {
      await ref
          .read(testPlansProvider.notifier)
          .deleteTestPlan(widget.plan.id);
    }
  }
}
