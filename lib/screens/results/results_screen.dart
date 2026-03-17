import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/dialogs.dart';
import '../../utils/date_utils.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runsAsync = ref.watch(testRunsProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text('Test Results',
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Import Excel'),
                  onPressed: () => _importExcel(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: runsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (runs) {
                // Only show completed runs; incomplete/saved runs live in
                // the Release Plans screen.
                final completed = runs.where((r) => r.isComplete).toList();
                if (completed.isEmpty) {
                  return const EmptyState(
                    icon: Icons.bar_chart,
                    title: 'No Test Results Yet',
                    subtitle:
                        'Execute a test plan to generate results, or import an Excel file.',
                  );
                }

                // Sort most recent first
                final sorted = [...completed]
                  ..sort((a, b) => b.executedAt.compareTo(a.executedAt));

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sorted.length,
                  itemBuilder: (ctx, i) {
                    final run = sorted[i];
                    final allPassed =
                        run.failedSteps == 0 && run.totalSteps > 0;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: allPassed
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          child: Icon(
                            allPassed ? Icons.check_circle : Icons.cancel,
                            color: allPassed ? Colors.green : Colors.red,
                          ),
                        ),
                        title: Text(run.name),
                        subtitle: Text(
                          '${run.executedAt.toDisplayDateTime()} · ${run.passedSteps}/${run.totalSteps} passed${run.releaseVersion != null ? ' · v${run.releaseVersion}' : ''}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.download),
                              tooltip: 'Re-export Excel',
                              onPressed: () async {
                                await ref
                                    .read(storageServiceProvider)
                                    .exportTestRunToExcel(run);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () async {
                                final ok = await showConfirmDialog(context,
                                    title: 'Delete Result',
                                    content:
                                        'Delete "${run.name}"? This cannot be undone.');
                                if (ok) {
                                  await ref
                                      .read(testRunsProvider.notifier)
                                      .deleteTestRun(run.id);
                                }
                              },
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () => context.go('/results/${run.id}'),
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

  Future<void> _importExcel(BuildContext context, WidgetRef ref) async {
    final run = await ref.read(storageServiceProvider).importTestRunFromExcel();
    if (run == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No valid Excel file selected.')));
      }
      return;
    }
    await ref.read(testRunsProvider.notifier).importRun(run);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test run imported successfully!')));
    }
  }
}
