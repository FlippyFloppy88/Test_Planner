import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

/// Flattens test plan / release plan into an ordered list of
/// (testCase, testStep) pairs for sequential execution.
class ExecutionService {
  static const _uuid = Uuid();

  /// Flattens all steps (including nested) from a TestCase into a list of StepResults.
  static List<StepResult> flattenTestCase(TestCase tc) {
    final results = <StepResult>[];
    for (final step in tc.steps) {
      _flattenStep(step, tc.id, tc.name, results);
    }
    return results;
  }

  static void _flattenStep(
    TestStep step,
    String caseId,
    String caseName,
    List<StepResult> out, {
    String prefix = '',
  }) {
    final name = prefix.isEmpty ? step.name : '$prefix > ${step.name}';
    out.add(StepResult(
      stepId: step.id,
      stepName: name,
      testCaseId: caseId,
      testCaseName: caseName,
      status: StepResultStatus.notRun,
      procedure: step.procedure,
      storyLink: step.storyLink.isNotEmpty ? step.storyLink : null,
      expectedResult: step.expectedResult,
    ));
    for (final sub in step.subSteps) {
      _flattenStep(sub, caseId, caseName, out, prefix: name);
    }
  }

  /// Flattens a list of TestCases (from plan or release plan).
  static List<StepResult> flattenTestCases(List<TestCase> cases) {
    return cases.expand((tc) => flattenTestCase(tc)).toList();
  }

  /// Build a unique run name, appending run_N suffix if duplicates exist.
  static String buildRunName({
    required String baseName,
    required DateTime date,
    required List<TestRun> existingRuns,
    String? releaseVersion,
  }) {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final versionPart = releaseVersion != null ? '_v$releaseVersion' : '';
    final base = '$baseName${versionPart}_$dateStr';

    // Count existing runs with same base name on same day
    final matches = existingRuns
        .where((r) => r.name == base || r.name.startsWith('${base}_run_'))
        .toList();

    if (matches.isEmpty) return base;
    return '${base}_run_${matches.length}';
  }

  static String newId() => _uuid.v4();
}

/// Web download helper using dart:js_interop
class WebFileDownloader {
  static void downloadBytes(Uint8List bytes, String fileName) {
    if (!kIsWeb) return;
    _performDownload(bytes, fileName);
  }

  // This is resolved by web-specific implementation using dart:js_interop
  static void _performDownload(Uint8List bytes, String fileName) {
    // Actual implementation injected at runtime via conditional imports
  }
}
