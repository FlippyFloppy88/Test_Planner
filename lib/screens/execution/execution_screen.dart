import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import '../../widgets/common/procedure_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

class ExecutionScreen extends ConsumerWidget {
  const ExecutionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(executionProvider);

    if (session == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No active test run.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/test-plans'),
                child: const Text('Go to Test Plans'),
              ),
            ],
          ),
        ),
      );
    }

    if (session.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/execution/complete');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final group = session.currentCase;
    if (group == null) {
      return const Scaffold(body: Center(child: Text('No test cases to run.')));
    }

    return Scaffold(
      body: Column(
        children: [
          _ExecutionHeader(
            runName: session.run.name,
            caseIndex: session.currentCaseIndex,
            totalCases: session.caseGroups.length,
            onEndRun: () => _confirmEndRun(context, ref),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: _CaseSidebar(session: session),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: _TestCasePage(
                    key: ValueKey(group.testCaseId),
                    session: session,
                    group: group,
                    storageFolderPath:
                        ref.read(storageServiceProvider).hasFolderOpen
                            ? ref.read(storageServiceProvider).folderPath
                            : '',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmEndRun(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('End Test Run?'),
        content: const Text(
            'This will end the run. Incomplete steps will be marked as not run.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(ctx).colorScheme.error),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('End Run')),
        ],
      ),
    );
    if (ok == true) ref.read(executionProvider.notifier).completeRun();
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ExecutionHeader extends StatelessWidget {
  final String runName;
  final int caseIndex;
  final int totalCases;
  final VoidCallback onEndRun;

  const _ExecutionHeader({
    required this.runName,
    required this.caseIndex,
    required this.totalCases,
    required this.onEndRun,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalCases == 0 ? 0.0 : (caseIndex + 1) / totalCases;
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(runName,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('Test Case ${caseIndex + 1} of $totalCases',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.stop),
                label: const Text('End Run'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
                onPressed: onEndRun,
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CaseSidebar extends ConsumerWidget {
  final ExecutionState session;
  const _CaseSidebar({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: session.caseGroups.length,
      itemBuilder: (ctx, i) {
        final group = session.caseGroups[i];
        final isCurrent = i == session.currentCaseIndex;
        final stepResults = group.stepIndices
            .map((idx) => session.run.stepResults[idx])
            .toList();
        final hasFailed =
            stepResults.any((r) => r.status == StepResultStatus.failed);
        final allDone =
            stepResults.every((r) => r.status != StepResultStatus.notRun);
        final anyDone =
            stepResults.any((r) => r.status != StepResultStatus.notRun);

        final icon = hasFailed
            ? const Icon(Icons.cancel, color: Colors.red, size: 16)
            : allDone
                ? const Icon(Icons.check_circle, color: Colors.green, size: 16)
                : anyDone
                    ? const Icon(Icons.timelapse,
                        color: Colors.orange, size: 16)
                    : const Icon(Icons.radio_button_unchecked,
                        color: Colors.grey, size: 16);

        return ListTile(
          selected: isCurrent,
          selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
          dense: true,
          leading: icon,
          title: Text(
            group.testCaseName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: isCurrent ? FontWeight.bold : null,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: null,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _TestCasePage extends ConsumerStatefulWidget {
  final ExecutionState session;
  final CaseGroup group;
  final String storageFolderPath;

  const _TestCasePage({
    super.key,
    required this.session,
    required this.group,
    required this.storageFolderPath,
  });

  @override
  ConsumerState<_TestCasePage> createState() => _TestCasePageState();
}

class _TestCasePageState extends ConsumerState<_TestCasePage> {
  bool _precondExpanded = false;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(executionProvider)!;
    final group = widget.group;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.testCaseName,
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),

          // Preconditions
          if (group.preconditions.isNotEmpty) ...[
            InkWell(
              onTap: () => setState(() => _precondExpanded = !_precondExpanded),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Text('Preconditions',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Icon(
                      _precondExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            if (_precondExpanded)
              _ProcedureView(
                items: group.preconditions,
                storageFolderPath: widget.storageFolderPath,
              ),
            const Divider(),
            const SizedBox(height: 8),
          ],

          // Steps header
          Text('Steps',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          ...group.stepIndices.map((idx) {
            final result = session.run.stepResults[idx];
            return _StepRow(
              key: ValueKey(result.stepId),
              result: result,
              storageFolderPath: widget.storageFolderPath,
              onUpdate: (updated) => ref
                  .read(executionProvider.notifier)
                  .updateStepResult(idx, updated),
            );
          }),

          const SizedBox(height: 32),

          // Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                onPressed: session.hasPrevCase
                    ? () => ref.read(executionProvider.notifier).previousCase()
                    : null,
              ),
              FilledButton.icon(
                icon: Icon(
                    session.hasNextCase ? Icons.arrow_forward : Icons.flag),
                label: Text(session.hasNextCase ? 'Next Case' : 'Finish Run'),
                onPressed: () =>
                    ref.read(executionProvider.notifier).nextCase(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _StepRow extends StatefulWidget {
  final StepResult result;
  final String storageFolderPath;
  final ValueChanged<StepResult> onUpdate;

  const _StepRow({
    super.key,
    required this.result,
    required this.storageFolderPath,
    required this.onUpdate,
  });

  @override
  State<_StepRow> createState() => _StepRowState();
}

class _StepRowState extends State<_StepRow> {
  bool _procedureExpanded = false;

  bool get _isSubStep => widget.result.stepName.contains(' > ');

  void _onCheckboxChanged(bool? checked) {
    if (checked != true) {
      widget.onUpdate(widget.result.copyWith(
        status: StepResultStatus.notRun,
        actualPassFail: null,
        actualValue: null,
      ));
      return;
    }
    final er = widget.result.expectedResult;
    if (er.answerType == AnswerType.none) {
      widget.onUpdate(widget.result.copyWith(status: StepResultStatus.passed));
    } else {
      _showResultDialog();
    }
  }

  Future<void> _showResultDialog() async {
    final er = widget.result.expectedResult;
    bool? passFail = widget.result.actualPassFail;
    final valueCtrl =
        TextEditingController(text: widget.result.actualValue ?? '');

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) {
          final enteredValue = double.tryParse(valueCtrl.text);
          final inRange = enteredValue != null &&
              (er.minValue == null || enteredValue >= er.minValue!) &&
              (er.maxValue == null || enteredValue <= er.maxValue!);

          return AlertDialog(
            title: Text(widget.result.stepName.split(' > ').last),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (er.description.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(ctx).colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(er.description),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (er.answerType == AnswerType.passFail) ...[
                    Text('Result:', style: Theme.of(ctx).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ChoiceChip(
                          label: const Text('Pass'),
                          selected: passFail == true,
                          selectedColor: Colors.green.shade100,
                          avatar: const Icon(Icons.check, size: 16),
                          onSelected: (_) => setLocal(() => passFail = true),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Fail'),
                          selected: passFail == false,
                          selectedColor: Colors.red.shade100,
                          avatar: const Icon(Icons.close, size: 16),
                          onSelected: (_) => setLocal(() => passFail = false),
                        ),
                      ],
                    ),
                  ],
                  if (er.answerType == AnswerType.value) ...[
                    if (er.minValue != null || er.maxValue != null)
                      Chip(
                        label: Text(
                          'Expected: ${er.minValue ?? '—'} – ${er.maxValue ?? '—'}'
                          '${er.unit != null ? ' ${er.unit}' : ''}',
                        ),
                      ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: valueCtrl,
                      autofocus: true,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText:
                            'Actual Value${er.unit != null ? ' (${er.unit})' : ''}',
                        isDense: true,
                        border: const OutlineInputBorder(),
                        suffixIcon: enteredValue != null
                            ? Icon(
                                inRange ? Icons.check_circle : Icons.error,
                                color: inRange ? Colors.green : Colors.red,
                              )
                            : null,
                      ),
                      onChanged: (_) => setLocal(() {}),
                    ),
                    if (enteredValue != null && !inRange)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('⚠ Value out of range',
                            style: TextStyle(
                                color: Theme.of(ctx).colorScheme.error)),
                      ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel')),
              if (er.answerType == AnswerType.passFail && passFail == false)
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(ctx).colorScheme.error),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _recordFailure(passFail: passFail);
                  },
                  child: const Text('Record Failure'),
                )
              else
                FilledButton(
                  onPressed: _canConfirm(er, passFail, valueCtrl.text)
                      ? () {
                          Navigator.pop(ctx);
                          _resolveResult(
                              passFail: passFail,
                              value: valueCtrl.text,
                              er: er);
                        }
                      : null,
                  child: const Text('Confirm'),
                ),
            ],
          );
        },
      ),
    );
  }

  bool _canConfirm(ExpectedResult er, bool? passFail, String valueText) {
    return switch (er.answerType) {
      AnswerType.none => true,
      AnswerType.passFail => passFail != null,
      AnswerType.value => double.tryParse(valueText) != null,
    };
  }

  void _resolveResult(
      {bool? passFail, String? value, required ExpectedResult er}) {
    final enteredValue = double.tryParse(value ?? '');
    final bool passed = switch (er.answerType) {
      AnswerType.none => true,
      AnswerType.passFail => passFail == true,
      AnswerType.value => enteredValue != null &&
          (er.minValue == null || enteredValue >= er.minValue!) &&
          (er.maxValue == null || enteredValue <= er.maxValue!),
    };

    if (!passed) {
      _recordFailure(passFail: passFail, value: value);
      return;
    }
    widget.onUpdate(widget.result.copyWith(
      status: StepResultStatus.passed,
      actualPassFail: passFail,
      actualValue: (value?.isNotEmpty == true) ? value : null,
    ));
  }

  Future<void> _recordFailure({bool? passFail, String? value}) async {
    final descCtrl = TextEditingController();
    final bugCtrl = TextEditingController();
    bool recorded = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.cancel, color: Theme.of(ctx).colorScheme.error),
              const SizedBox(width: 8),
              const Text('Record Failure'),
            ],
          ),
          content: SizedBox(
            width: 460,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  value: recorded,
                  onChanged: (v) => setLocal(() => recorded = v ?? false),
                  title: const Text('Bug already recorded in Jira'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: bugCtrl,
                  decoration: const InputDecoration(
                    labelText: 'New Jira Bug Link (optional)',
                    hintText: 'https://jira.example.com/browse/BUG-123',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Additional failure details (optional)',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(ctx).colorScheme.error),
              onPressed: () {
                Navigator.pop(ctx);
                widget.onUpdate(widget.result.copyWith(
                  status: StepResultStatus.failed,
                  actualPassFail: passFail,
                  actualValue: (value?.isNotEmpty == true) ? value : null,
                  failureDescription: descCtrl.text,
                  jiraBugLink: bugCtrl.text,
                  bugRecordedInJira: recorded,
                ));
              },
              child: const Text('Record & Continue'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final er = result.expectedResult;
    final status = result.status;
    final isChecked = status != StepResultStatus.notRun;

    final statusIcon = switch (status) {
      StepResultStatus.passed =>
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
      StepResultStatus.failed =>
        const Icon(Icons.cancel, color: Colors.red, size: 20),
      StepResultStatus.skipped =>
        const Icon(Icons.skip_next, color: Colors.orange, size: 20),
      StepResultStatus.notRun => const SizedBox(width: 20),
    };

    final displayName =
        _isSubStep ? result.stepName.split(' > ').last : result.stepName;

    return Padding(
      padding: EdgeInsets.only(left: _isSubStep ? 32.0 : 0),
      child: Card(
        elevation: _isSubStep ? 0 : 1,
        color: _isSubStep
            ? Theme.of(context).colorScheme.surfaceContainerLow
            : null,
        margin: const EdgeInsets.only(bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: _onCheckboxChanged,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              decoration: status == StepResultStatus.passed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                      if (result.storyLink != null &&
                          result.storyLink!.isNotEmpty)
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse(result.storyLink!)),
                          child: Text(
                            '🔗 ${result.storyLink}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
                statusIcon,
                if (result.procedure.isNotEmpty)
                  IconButton(
                    icon: Icon(
                      _procedureExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      size: 18,
                    ),
                    onPressed: () => setState(
                        () => _procedureExpanded = !_procedureExpanded),
                    tooltip: 'Show procedure',
                  ),
                const SizedBox(width: 4),
              ],
            ),

            // Result summary after completion
            if (status != StepResultStatus.notRun &&
                er.answerType != AnswerType.none)
              Padding(
                padding: const EdgeInsets.only(left: 48, right: 12, bottom: 8),
                child: _ResultSummary(result: result),
              ),

            // Procedure
            if (_procedureExpanded && result.procedure.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 48, right: 12, bottom: 12),
                child: _ProcedureView(
                  items: result.procedure,
                  storageFolderPath: widget.storageFolderPath,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ResultSummary extends StatelessWidget {
  final StepResult result;
  const _ResultSummary({required this.result});

  @override
  Widget build(BuildContext context) {
    final er = result.expectedResult;
    final failed = result.status == StepResultStatus.failed;
    final color =
        failed ? Theme.of(context).colorScheme.error : Colors.green.shade700;
    final text = failed
        ? switch (er.answerType) {
            AnswerType.passFail => 'Failed',
            AnswerType.value =>
              'Value: ${result.actualValue ?? '?'} — out of range',
            AnswerType.none => 'Failed',
          }
        : switch (er.answerType) {
            AnswerType.passFail => 'Passed',
            AnswerType.value =>
              'Value: ${result.actualValue ?? '?'}${er.unit != null ? ' ${er.unit}' : ''}',
            AnswerType.none => 'Completed',
          };

    return Text(text,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: color, fontWeight: FontWeight.w600));
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ProcedureView extends StatelessWidget {
  final List<ProcedureItem> items;
  final String storageFolderPath;

  const _ProcedureView({required this.items, this.storageFolderPath = ''});

  void _showImagePreview(BuildContext context, Attachment att) {
    final absPath = att.filePath.isNotEmpty && storageFolderPath.isNotEmpty
        ? p.join(storageFolderPath, att.filePath)
        : null;

    Widget imageWidget;
    if (absPath != null && File(absPath).existsSync()) {
      imageWidget = InteractiveViewer(child: Image.file(File(absPath)));
    } else {
      imageWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.broken_image, size: 48),
          const SizedBox(height: 8),
          Text(absPath != null ? 'File not found:\n$absPath' : 'No image data',
              textAlign: TextAlign.center),
        ],
      );
    }

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(att.fileName),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx))
              ],
            ),
            Flexible(child: imageWidget),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${i + 1}. ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Expanded(
                        child: ProcedureText(
                      text: item.text,
                      attachments: item.attachments,
                      onAttachmentTap: (att) => _showImagePreview(context, att),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ],
                ),
                if (item.attachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 20),
                    child: Wrap(
                      spacing: 6,
                      children: item.attachments
                          .map((att) => ActionChip(
                                avatar: const Icon(Icons.photo, size: 14),
                                label: Text(att.fileName,
                                    style: const TextStyle(fontSize: 11)),
                                onPressed: () =>
                                    _showImagePreview(context, att),
                              ))
                          .toList(),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
