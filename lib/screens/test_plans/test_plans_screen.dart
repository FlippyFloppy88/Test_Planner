import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
                  itemBuilder: (ctx, i) {
                    final plan = plans[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
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
                              icon: const Icon(Icons.delete_outline),
                              tooltip: 'Delete',
                              onPressed: () async {
                                final ok = await showConfirmDialog(context,
                                    title: 'Delete Test Plan',
                                    content:
                                        'Delete "${plan.name}"? This cannot be undone.');
                                if (ok) {
                                  await ref
                                      .read(testPlansProvider.notifier)
                                      .deleteTestPlan(plan.id);
                                }
                              },
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () => context.go('/test-plans/${plan.id}'),
                      ),
                    );
                  },
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
