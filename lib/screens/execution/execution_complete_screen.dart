import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/date_utils.dart';

class ExecutionCompleteScreen extends ConsumerStatefulWidget {
  const ExecutionCompleteScreen({super.key});

  @override
  ConsumerState<ExecutionCompleteScreen> createState() =>
      _ExecutionCompleteScreenState();
}

class _ExecutionCompleteScreenState
    extends ConsumerState<ExecutionCompleteScreen> {
  bool _saved = false;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(executionProvider);
    final run = session?.run;

    if (run == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No completed run.'),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    }

    final passRate = run.totalSteps > 0
        ? (run.passedSteps / run.totalSteps * 100).toStringAsFixed(1)
        : '0';
    final allPassed = run.failedSteps == 0 && run.totalSteps > 0;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 700,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                // Result icon
                Icon(
                  allPassed ? Icons.check_circle : Icons.cancel,
                  size: 80,
                  color: allPassed ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  allPassed
                      ? 'Test Run Complete — All Passed!'
                      : 'Test Run Complete — Failures Detected',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(run.name, style: Theme.of(context).textTheme.titleMedium),
                if (run.releaseVersion != null)
                  Text('Release: ${run.releaseVersion}'),
                Text('Executed: ${run.executedAt.toDisplayDateTime()}'),
                const SizedBox(height: 32),

                // Stats cards
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _StatChip(
                        'Total Steps', run.totalSteps.toString(), Colors.blue),
                    _StatChip(
                        'Passed', run.passedSteps.toString(), Colors.green),
                    _StatChip('Failed', run.failedSteps.toString(), Colors.red),
                    _StatChip(
                        'Skipped', run.skippedSteps.toString(), Colors.orange),
                    _StatChip('Pass Rate', '$passRate%',
                        allPassed ? Colors.green : Colors.orange),
                  ],
                ),
                const SizedBox(height: 32),

                // Failures
                if (run.failures.isNotEmpty) ...[
                  _SectionHeader('Failed Steps'),
                  ...run.failures.map((f) => _FailureCard(failure: f)),
                  const SizedBox(height: 24),
                ],

                // Jira bugs
                if (run.uniqueJiraBugs.isNotEmpty) ...[
                  _SectionHeader('Jira Bugs Referenced'),
                  ...run.uniqueJiraBugs.map((b) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.bug_report),
                        title: Text(b),
                      )),
                  const SizedBox(height: 24),
                ],

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_saved)
                      FilledButton.icon(
                        icon: _saving
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.save),
                        label: const Text('Save & Export to Excel'),
                        onPressed:
                            _saving ? null : () => _saveRun(context, ref, run),
                      ),
                    if (_saved)
                      const Chip(
                        label: Text('Saved!'),
                        avatar: Icon(Icons.check, color: Colors.green),
                      ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.home),
                      label: const Text('Go Home'),
                      onPressed: () {
                        ref.read(executionProvider.notifier).clearSession();
                        context.go('/');
                      },
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.bar_chart),
                      label: const Text('View Results'),
                      onPressed: () {
                        ref.read(executionProvider.notifier).clearSession();
                        context.go('/results');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveRun(
      BuildContext context, WidgetRef ref, TestRun run) async {
    setState(() => _saving = true);
    try {
      await ref.read(testRunsProvider.notifier).addTestRun(run);
      await ref.read(storageServiceProvider).exportTestRunToExcel(run);
      setState(() {
        _saved = true;
        _saving = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Run saved and Excel exported!')),
        );
      }
    } catch (e) {
      setState(() => _saving = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatChip(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: color)),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}

class _FailureCard extends StatelessWidget {
  final StepResult failure;
  const _FailureCard({required this.failure});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${failure.testCaseName} › ${failure.stepName}',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            if (failure.expectedResult.description.isNotEmpty)
              Text('Expected: ${failure.expectedResult.description}'),
            if (failure.actualValue != null)
              Text('Actual Value: ${failure.actualValue}'),
            if (failure.actualPassFail != null)
              Text('Actual: ${failure.actualPassFail! ? 'Pass' : 'Fail'}'),
            if (failure.failureDescription.isNotEmpty)
              Text('Notes: ${failure.failureDescription}'),
            if (failure.jiraBugLink.isNotEmpty)
              Text('Bug: ${failure.jiraBugLink}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
