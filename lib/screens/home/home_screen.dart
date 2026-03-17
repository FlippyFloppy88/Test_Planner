import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/date_utils.dart';
import '../../widgets/common/dialogs.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _pickingFolder = false;

  Future<void> _changeFolder() async {
    if (_pickingFolder) return;
    setState(() => _pickingFolder = true);

    final storage = ref.read(storageServiceProvider);
    final name = await storage.pickFolder();

    if (!mounted) return;
    setState(() => _pickingFolder = false);

    if (name != null) {
      // Folder was selected — reload all data providers from the new folder.
      ref.invalidate(testPlansProvider);
      ref.invalidate(releasePlansProvider);
      ref.invalidate(testRunsProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data folder set to "$name". Data reloaded.'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } else {
      // Browser doesn't support File System Access API or user cancelled.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Folder picker is only supported in Chrome 86+. '
            'Your data is stored in browser storage (IndexedDB).',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final testPlans = ref.watch(testPlansProvider).valueOrNull ?? [];
    final releasePlans = ref.watch(releasePlansProvider).valueOrNull ?? [];
    final testRuns = ref.watch(testRunsProvider).valueOrNull ?? [];
    final storage = ref.read(storageServiceProvider);

    final folderLabel = storage.folderPath;
    final hasFolder = storage.hasFolderOpen;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Test Planner',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          hasFolder ? Icons.folder : Icons.folder_off,
                          size: 14,
                          color: hasFolder
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hasFolder
                              ? 'Saving to: $folderLabel'
                              : 'No folder selected — $folderLabel',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: hasFolder
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.outline,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                icon: _pickingFolder
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.folder_open),
                label: Text(_pickingFolder ? 'Opening…' : 'Change Folder'),
                onPressed: _pickingFolder ? null : _changeFolder,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Stats row
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _StatCard(
                icon: Icons.checklist,
                label: 'Test Plans',
                value: testPlans.length.toString(),
                color: Theme.of(context).colorScheme.primaryContainer,
                onTap: () => context.go('/test-plans'),
              ),
              _StatCard(
                icon: Icons.rocket_launch,
                label: 'Release Plans',
                value: releasePlans.length.toString(),
                color: Theme.of(context).colorScheme.secondaryContainer,
                onTap: () => context.go('/release-plans'),
              ),
              _StatCard(
                icon: Icons.bar_chart,
                label: 'Test Runs',
                value: testRuns.length.toString(),
                color: Theme.of(context).colorScheme.tertiaryContainer,
                onTap: () => context.go('/results'),
              ),
              _StatCard(
                icon: Icons.check_circle,
                label: 'Passed (last 10)',
                value: _recentPassRate(testRuns),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                onTap: () => context.go('/results'),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Quick Actions
          Text('Quick Actions', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New Test Plan'),
                onPressed: () => _quickNewTestPlan(context),
              ),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.add),
                label: const Text('New Release Plan'),
                onPressed: () => _quickNewReleasePlan(context),
              ),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.play_circle_outline),
                label: const Text('Execute Release Plan'),
                onPressed: () => _quickExecuteReleasePlan(context),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Recent Runs
          if (testRuns.isNotEmpty) ...[
            Text('Recent Test Runs',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...testRuns.reversed.take(5).map((run) => ListTile(
                  leading: Icon(
                    run.failedSteps > 0 ? Icons.cancel : Icons.check_circle,
                    color: run.failedSteps > 0 ? Colors.red : Colors.green,
                  ),
                  title: Text(run.name),
                  subtitle: Text(
                      '${run.executedAt.toDisplayDateTime()} · ${run.passedSteps}/${run.totalSteps} passed'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/results/${run.id}'),
                )),
          ],
        ],
      ),
    );
  }

  Future<void> _quickNewTestPlan(BuildContext context) async {
    final name = await showInputDialog(context,
        title: 'New Test Plan', label: 'Plan Name');
    if (name == null || name.isEmpty) return;
    final id = await ref.read(testPlansProvider.notifier).addTestPlan(name, '');
    if (context.mounted) context.go('/test-plans/$id');
  }

  Future<void> _quickNewReleasePlan(BuildContext context) async {
    final name = await showInputDialog(context,
        title: 'New Release Plan', label: 'Product Name');
    if (name == null || name.isEmpty) return;
    final id =
        await ref.read(releasePlansProvider.notifier).addReleasePlan(name, '');
    if (context.mounted) context.go('/release-plans/$id');
  }

  Future<void> _quickExecuteReleasePlan(BuildContext context) async {
    final plans = ref.read(releasePlansProvider).valueOrNull ?? [];
    if (plans.isEmpty) {
      // No plans yet — offer to create one first.
      final name = await showInputDialog(context,
          title: 'New Release Plan', label: 'Product Name');
      if (name == null || name.isEmpty) return;
      final id = await ref
          .read(releasePlansProvider.notifier)
          .addReleasePlan(name, '');
      if (context.mounted) context.go('/release-plans/$id');
      return;
    }
    // One plan — go straight to it; multiple — show picker.
    if (plans.length == 1) {
      if (context.mounted) context.go('/release-plans/${plans.first.id}');
      return;
    }
    if (!context.mounted) return;
    final picked = await showDialog<ReleasePlan>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Release Plan'),
        content: SizedBox(
          width: 400,
          child: ListView(
            shrinkWrap: true,
            children: plans
                .map((p) => ListTile(
                      leading: const Icon(Icons.rocket_launch),
                      title: Text(p.productName),
                      subtitle: Text(
                          '${p.items.length} item${p.items.length != 1 ? 's' : ''}'),
                      onTap: () => Navigator.pop(ctx, p),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
        ],
      ),
    );
    if (picked != null && context.mounted) {
      context.go('/release-plans/${picked.id}');
    }
  }

  String _recentPassRate(List<TestRun> runs) {
    final recent = runs.reversed.take(10).toList();
    if (recent.isEmpty) return '—';
    final passed = recent.fold<int>(0, (sum, r) => sum + r.passedSteps);
    final total = recent.fold<int>(0, (sum, r) => sum + r.totalSteps);
    if (total == 0) return '—';
    return '${(passed * 100 ~/ total)}%';
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 12),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
