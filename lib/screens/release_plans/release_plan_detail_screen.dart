import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common/dialogs.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/numbered_drag_handle.dart';

const _uuid = Uuid();

class ReleasePlanDetailScreen extends ConsumerWidget {
  final String planId;
  const ReleasePlanDetailScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(releasePlansProvider);
    final testPlans = ref.watch(testPlansProvider).valueOrNull ?? [];

    return plansAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (plans) {
        final plan = plans.firstWhere((p) => p.id == planId,
            orElse: () => throw StateError('Plan not found'));

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
                      onPressed: () => context.go('/release-plans'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plan.productName,
                              style: Theme.of(context).textTheme.headlineSmall),
                          Text(
                              '${plan.items.length} item${plan.items.length != 1 ? 's' : ''}',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Execute'),
                      onPressed: plan.items.isEmpty
                          ? null
                          : () =>
                              _startExecution(context, ref, plan, testPlans),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      child: const FilledButton.tonal(
                        onPressed: null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 4),
                            Text('Add'),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 'plan') {
                          _addTestPlanRef(context, ref, plan.id, testPlans);
                        } else {
                          _addOneOffCase(context, ref, plan.id);
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'plan',
                          child: ListTile(
                            leading: Icon(Icons.checklist),
                            title: Text('Add Test Plan'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'oneoff',
                          child: ListTile(
                            leading: Icon(Icons.assignment_add),
                            title: Text('Add One-off Test Case'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),

              Expanded(
                child: plan.items.isEmpty
                    ? EmptyState(
                        icon: Icons.playlist_add,
                        title: 'No Items Yet',
                        subtitle:
                            'Add existing test plans or one-off test cases.',
                      )
                    : ReorderableListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: plan.items.length,
                        onReorder: (oldIdx, newIdx) async {
                          if (newIdx > oldIdx) newIdx--;
                          await ref
                              .read(releasePlansProvider.notifier)
                              .reorderItems(plan.id, oldIdx, newIdx);
                        },
                        itemBuilder: (ctx, i) {
                          final item = plan.items[i];
                          return item.map(
                            testPlanRef: (ref_) => Card(
                              key: ValueKey(ref_.id),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(Icons.checklist)),
                                title: Text(ref_.testPlanName),
                                subtitle: const Text('Test Plan'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    NumberedDragHandle(index: i),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      onPressed: () => ref
                                          .read(releasePlansProvider.notifier)
                                          .removeItem(plan.id, ref_.id),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            oneOff: (o) => Card(
                              key: ValueKey(o.id),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(Icons.assignment)),
                                title: Text(o.testCase.name),
                                subtitle: const Text('One-off Test Case'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    NumberedDragHandle(index: i),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      onPressed: () => ref
                                          .read(releasePlansProvider.notifier)
                                          .removeItem(plan.id, o.id),
                                    ),
                                  ],
                                ),
                              ),
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

  Future<void> _addTestPlanRef(BuildContext context, WidgetRef ref,
      String releasePlanId, List<TestPlan> testPlans) async {
    if (testPlans.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No test plans available. Create one first.')));
      return;
    }
    TestPlan? selected;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Test Plan'),
        content: SizedBox(
          width: 400,
          child: ListView(
            shrinkWrap: true,
            children: testPlans
                .map((tp) => ListTile(
                      title: Text(tp.name),
                      subtitle: Text('${tp.testCases.length} cases'),
                      onTap: () {
                        selected = tp;
                        Navigator.pop(ctx);
                      },
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ],
      ),
    );
    if (selected != null) {
      await ref
          .read(releasePlansProvider.notifier)
          .addTestPlanRef(releasePlanId, selected!.id, selected!.name);
    }
  }

  Future<void> _addOneOffCase(
      BuildContext context, WidgetRef ref, String releasePlanId) async {
    final name = await showInputDialog(context,
        title: 'One-off Test Case', label: 'Test Case Name');
    if (name == null || name.isEmpty) return;
    final now = DateTime.now();
    final tc = TestCase(
      id: _uuid.v4(),
      name: name,
      createdAt: now,
      updatedAt: now,
    );
    await ref
        .read(releasePlansProvider.notifier)
        .addOneOffTestCase(releasePlanId, tc);
  }

  Future<void> _startExecution(BuildContext context, WidgetRef ref,
      ReleasePlan plan, List<TestPlan> testPlans) async {
    // Ask for release version
    final version = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final ctrl = TextEditingController();
        return AlertDialog(
          title: const Text('Start Release Execution'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(
                labelText: 'Release Version (optional)',
                hintText: 'e.g. 1.2.3'),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(ctx, ctrl.text),
                child: const Text('Start')),
          ],
        );
      },
    );
    if (version == null) return;

    final existingRuns = ref.read(testRunsProvider).valueOrNull ?? [];
    ref.read(executionProvider.notifier).startReleasePlan(
          plan: plan,
          allTestPlans: testPlans,
          existingRuns: existingRuns,
          releaseVersion: version.isEmpty ? null : version,
        );
    if (context.mounted) context.go('/execution');
  }
}
