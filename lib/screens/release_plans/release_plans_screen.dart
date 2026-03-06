import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/dialogs.dart';
import '../../utils/date_utils.dart';

class ReleasePlansScreen extends ConsumerWidget {
  const ReleasePlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(releasePlansProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text('Release Plans',
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('New Release Plan'),
                  onPressed: () => _createReleasePlan(context, ref),
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
                    icon: Icons.rocket_launch_outlined,
                    title: 'No Release Plans Yet',
                    subtitle:
                        'Combine test plans and one-off cases into release plans.',
                    actionLabel: 'New Release Plan',
                    onAction: () => _createReleasePlan(context, ref),
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
                        leading: const CircleAvatar(
                            child: Icon(Icons.rocket_launch)),
                        title: Text(plan.productName),
                        subtitle: Text(
                            '${plan.items.length} item${plan.items.length != 1 ? 's' : ''} · ${plan.updatedAt.toDisplayDate()}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () async {
                                final ok = await showConfirmDialog(context,
                                    title: 'Delete Release Plan',
                                    content:
                                        'Delete "${plan.productName}"? This cannot be undone.');
                                if (ok) {
                                  await ref
                                      .read(releasePlansProvider.notifier)
                                      .deleteReleasePlan(plan.id);
                                }
                              },
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () => context.go('/release-plans/${plan.id}'),
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

  Future<void> _createReleasePlan(BuildContext context, WidgetRef ref) async {
    final name = await showInputDialog(context,
        title: 'New Release Plan', label: 'Product Name');
    if (name == null || name.isEmpty) return;
    await ref.read(releasePlansProvider.notifier).addReleasePlan(name, '');
  }
}
