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
        final plan = plans.firstWhere(
          (p) => p.id == planId,
          orElse: () => throw StateError('Plan not found'),
        );

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
                          return Card(
                            key: ValueKey(tc.id),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(Icons.assignment)),
                              title: Text(tc.name),
                              subtitle: Text(
                                  '${tc.steps.length} step${tc.steps.length != 1 ? 's' : ''} · ${tc.updatedAt.toDisplayDate()}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NumberedDragHandle(index: i),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () async {
                                      final ok = await showConfirmDialog(
                                          context,
                                          title: 'Delete Test Case',
                                          content:
                                              'Delete "${tc.name}"? This cannot be undone.');
                                      if (ok) {
                                        await ref
                                            .read(testPlansProvider.notifier)
                                            .deleteTestCase(plan.id, tc.id);
                                      }
                                    },
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                              onTap: () => context
                                  .go('/test-plans/${plan.id}/case/${tc.id}'),
                            ),
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
