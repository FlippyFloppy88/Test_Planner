import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';

class ExecutionCompleteScreen extends ConsumerStatefulWidget {
  const ExecutionCompleteScreen({super.key});

  @override
  ConsumerState<ExecutionCompleteScreen> createState() =>
      _ExecutionCompleteScreenState();
}

/// Automatically saves the completed run, exports to Excel, then navigates
/// directly to the result detail page so the user can view results
/// immediately after pressing Finish.
class _ExecutionCompleteScreenState
    extends ConsumerState<ExecutionCompleteScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _autoSaveAndNavigate());
  }

  Future<void> _autoSaveAndNavigate() async {
    if (!mounted) return;
    final run = ref.read(executionProvider)?.run;
    if (run == null) {
      if (mounted) context.go('/');
      return;
    }
    setState(() {
      _error = null;
    });
    try {
      await ref.read(testRunsProvider.notifier).addTestRun(run);
      await ref.read(storageServiceProvider).exportTestRunToExcel(run);
      if (!mounted) return;
      ref.read(executionProvider.notifier).clearSession();
      context.go('/results/${run.id}');
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 56, color: Colors.red),
                const SizedBox(height: 16),
                Text('Failed to save run', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(_error!, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      onPressed: _autoSaveAndNavigate,
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        ref.read(executionProvider.notifier).clearSession();
                        context.go('/');
                      },
                      child: const Text('Go Home'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Saving run and exporting to Excel…'),
          ],
        ),
      ),
    );
  }
}
