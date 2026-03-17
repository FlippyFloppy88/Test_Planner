import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/numbered_drag_handle.dart';

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
                    FilledButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Test Plan'),
                      onPressed: () =>
                          _addTestPlanRef(context, ref, plan.id, testPlans),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),

              Expanded(
                child: plan.items.isEmpty
                    ? const EmptyState(
                        icon: Icons.playlist_add,
                        title: 'No Items Yet',
                        subtitle: 'Add test plans to this release plan.',
                      )
                    : ReorderableListView.builder(
                        buildDefaultDragHandles: false,
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
                          return _ReleasePlanItemCard(
                            key: ValueKey(item.id),
                            item: item,
                            index: i,
                            releasePlanId: plan.id,
                            testPlans: testPlans,
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

// ── Per-item card with numbered drag handle + expandable test cases ──────────
class _ReleasePlanItemCard extends ConsumerStatefulWidget {
  final ReleasePlanItem item;
  final int index;
  final String releasePlanId;
  final List<TestPlan> testPlans;

  const _ReleasePlanItemCard({
    required super.key,
    required this.item,
    required this.index,
    required this.releasePlanId,
    required this.testPlans,
  });

  @override
  ConsumerState<_ReleasePlanItemCard> createState() =>
      _ReleasePlanItemCardState();
}

class _ReleasePlanItemCardState
    extends ConsumerState<_ReleasePlanItemCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return widget.item.map(
      testPlanRef: (ref_) {
        // Look up the live test plan to show its test cases
        final livePlan = widget.testPlans
            .where((tp) => tp.id == ref_.testPlanId)
            .firstOrNull;
        final testCases = livePlan?.testCases ?? [];

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 12, right: 4),
                leading: NumberedDragHandle(index: widget.index),
                title: Text(ref_.testPlanName),
                subtitle: Text(
                    '${testCases.length} test case${testCases.length != 1 ? 's' : ''}'),
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
                      icon: const Icon(Icons.remove_circle_outline),
                      tooltip: 'Remove from release plan',
                      onPressed: () => ref
                          .read(releasePlansProvider.notifier)
                          .removeItem(widget.releasePlanId, ref_.id),
                    ),
                  ],
                ),
              ),
              if (_expanded) ...[
                const Divider(height: 1),
                if (testCases.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'No test cases in this plan.',
                        style: textTheme.bodySmall
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: testCases.length,
                    itemBuilder: (_, j) {
                      final tc = testCases[j];
                      return ListTile(
                        dense: true,
                        contentPadding:
                            const EdgeInsets.only(left: 56, right: 16),
                        leading: Text(
                          '${j + 1}.',
                          style: textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                        title: Text(tc.name, style: textTheme.bodyMedium),
                        subtitle: Text(
                          '${tc.steps.length} test${tc.steps.length != 1 ? 's' : ''}',
                          style: textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
              ],
            ],
          ),
        );
      },
      oneOff: (o) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 12, right: 4),
          leading: NumberedDragHandle(index: widget.index),
          title: Text(o.testCase.name),
          subtitle: const Text('One-off Test Case'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            tooltip: 'Remove from release plan',
            onPressed: () => ref
                .read(releasePlansProvider.notifier)
                .removeItem(widget.releasePlanId, o.id),
          ),
        ),
      ),
    );
  }
}
