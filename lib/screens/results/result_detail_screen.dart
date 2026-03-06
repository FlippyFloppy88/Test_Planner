import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/date_utils.dart';

class ResultDetailScreen extends ConsumerWidget {
  final String runId;
  const ResultDetailScreen({super.key, required this.runId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runsAsync = ref.watch(testRunsProvider);

    return runsAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (runs) {
        final run = runs.firstWhere((r) => r.id == runId,
            orElse: () => throw StateError('Run not found'));
        return _ResultDetailView(run: run);
      },
    );
  }
}

class _ResultDetailView extends StatelessWidget {
  final TestRun run;
  const _ResultDetailView({required this.run});

  @override
  Widget build(BuildContext context) {
    final allPassed = run.failedSteps == 0 && run.totalSteps > 0;
    final passRate = run.totalSteps > 0
        ? (run.passedSteps / run.totalSteps * 100).toStringAsFixed(1)
        : '0';

    return Scaffold(
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 24, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/results'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(run.name,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(run.executedAt.toDisplayDateTime(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary
                  _SummarySection(
                    run: run,
                    allPassed: allPassed,
                    passRate: passRate,
                  ),
                  const SizedBox(height: 24),

                  // Failures
                  if (run.failures.isNotEmpty) ...[
                    Text('Failed Steps',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ...run.failures.map((f) => _FailureListTile(f)),
                    const SizedBox(height: 24),
                  ],

                  // Jira
                  if (run.uniqueJiraBugs.isNotEmpty) ...[
                    Text('Jira Bugs',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ...run.uniqueJiraBugs.map((b) => ListTile(
                          leading: const Icon(Icons.bug_report),
                          title: Text(b),
                          onTap: () => launchUrl(Uri.parse(b)),
                        )),
                    const SizedBox(height: 24),
                  ],

                  // All step results
                  Text('All Step Results',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  _StepResultsTable(stepResults: run.stepResults),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  final TestRun run;
  final bool allPassed;
  final String passRate;

  const _SummarySection({
    required this.run,
    required this.allPassed,
    required this.passRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _InfoChip(
                label: 'Source', value: '${run.sourceType}: ${run.sourceName}'),
            if (run.releaseVersion != null)
              _InfoChip(label: 'Release', value: 'v${run.releaseVersion}'),
            _InfoChip(
                label: 'Steps Run', value: '${run.runSteps}/${run.totalSteps}'),
            _InfoChip(
                label: 'Passed',
                value: run.passedSteps.toString(),
                color: Colors.green),
            _InfoChip(
                label: 'Failed',
                value: run.failedSteps.toString(),
                color: Colors.red),
            _InfoChip(
                label: 'Skipped',
                value: run.skippedSteps.toString(),
                color: Colors.orange),
            _InfoChip(
                label: 'Pass Rate',
                value: '$passRate%',
                color: allPassed ? Colors.green : Colors.orange),
          ],
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _InfoChip({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (color ?? Theme.of(context).colorScheme.primary)
                .withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  )),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _FailureListTile extends StatelessWidget {
  final StepResult failure;
  const _FailureListTile(this.failure);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.4),
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.cancel, color: Colors.red),
        title: Text('${failure.testCaseName} › ${failure.stepName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (failure.expectedResult.description.isNotEmpty)
              Text('Expected: ${failure.expectedResult.description}'),
            if (failure.actualValue != null)
              Text('Actual: ${failure.actualValue}'),
            if (failure.failureDescription.isNotEmpty)
              Text('Notes: ${failure.failureDescription}'),
            if (failure.jiraBugLink.isNotEmpty)
              InkWell(
                onTap: () => launchUrl(Uri.parse(failure.jiraBugLink)),
                child: Text('Bug: ${failure.jiraBugLink}',
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}

class _StepResultsTable extends StatelessWidget {
  final List<StepResult> stepResults;
  const _StepResultsTable({required this.stepResults});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        columns: const [
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Test Case')),
          DataColumn(label: Text('Step')),
          DataColumn(label: Text('Expected')),
          DataColumn(label: Text('Actual')),
          DataColumn(label: Text('Notes')),
        ],
        rows: stepResults.map((sr) {
          Color? rowColor;
          if (sr.status == StepResultStatus.failed) {
            rowColor =
                Theme.of(context).colorScheme.errorContainer.withOpacity(0.3);
          } else if (sr.status == StepResultStatus.passed) {
            rowColor = Colors.green.withOpacity(0.05);
          }

          return DataRow(
            color: WidgetStateProperty.all(rowColor),
            cells: [
              DataCell(_StatusIcon(sr.status)),
              DataCell(Text(sr.testCaseName, overflow: TextOverflow.ellipsis)),
              DataCell(SizedBox(
                  width: 200,
                  child: Text(sr.stepName, overflow: TextOverflow.ellipsis))),
              DataCell(SizedBox(
                  width: 150,
                  child: Text(sr.expectedResult.description,
                      overflow: TextOverflow.ellipsis))),
              DataCell(Text(_formatActual(sr))),
              DataCell(SizedBox(
                  width: 150,
                  child: Text(sr.failureDescription,
                      overflow: TextOverflow.ellipsis))),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _formatActual(StepResult sr) {
    if (sr.actualValue != null) return sr.actualValue!;
    if (sr.actualPassFail != null) return sr.actualPassFail! ? 'Pass' : 'Fail';
    return '—';
  }
}

class _StatusIcon extends StatelessWidget {
  final StepResultStatus status;
  const _StatusIcon(this.status);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepResultStatus.passed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case StepResultStatus.failed:
        return const Icon(Icons.cancel, color: Colors.red, size: 20);
      case StepResultStatus.skipped:
        return const Icon(Icons.skip_next, color: Colors.orange, size: 20);
      case StepResultStatus.notRun:
        return const Icon(Icons.radio_button_unchecked,
            color: Colors.grey, size: 20);
    }
  }
}
