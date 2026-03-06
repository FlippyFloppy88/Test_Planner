import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/execution_service.dart';
import 'storage_provider.dart';

// ── Active execution session ───────────────────────────────────────────────

class ExecutionState {
  final TestRun run;

  /// Index of the test case currently being executed.
  final int currentCaseIndex;

  /// All test cases in execution order (name + their step result indices).
  final List<CaseGroup> caseGroups;

  final bool isComplete;

  const ExecutionState({
    required this.run,
    required this.currentCaseIndex,
    required this.caseGroups,
    this.isComplete = false,
  });

  CaseGroup? get currentCase =>
      currentCaseIndex < caseGroups.length ? caseGroups[currentCaseIndex] : null;

  bool get hasNextCase => currentCaseIndex < caseGroups.length - 1;
  bool get hasPrevCase => currentCaseIndex > 0;

  ExecutionState copyWith({
    TestRun? run,
    int? currentCaseIndex,
    List<CaseGroup>? caseGroups,
    bool? isComplete,
  }) {
    return ExecutionState(
      run: run ?? this.run,
      currentCaseIndex: currentCaseIndex ?? this.currentCaseIndex,
      caseGroups: caseGroups ?? this.caseGroups,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

/// Groups the step-result indices belonging to one test case.
class CaseGroup {
  final String testCaseId;
  final String testCaseName;
  final List<ProcedureItem> preconditions;

  /// Indices into [TestRun.stepResults] for this test case's steps.
  final List<int> stepIndices;

  const CaseGroup({
    required this.testCaseId,
    required this.testCaseName,
    required this.preconditions,
    required this.stepIndices,
  });
}

List<CaseGroup> _buildCaseGroups(
    List<TestCase> cases, List<StepResult> results) {
  final groups = <CaseGroup>[];
  int resultIdx = 0;
  for (final tc in cases) {
    final count = _countSteps(tc.steps);
    groups.add(CaseGroup(
      testCaseId: tc.id,
      testCaseName: tc.name,
      preconditions: tc.preconditions,
      stepIndices: List.generate(count, (i) => resultIdx + i),
    ));
    resultIdx += count;
  }
  return groups;
}

int _countSteps(List<TestStep> steps) {
  int count = 0;
  for (final s in steps) {
    count += 1 + _countSteps(s.subSteps);
  }
  return count;
}

class ExecutionNotifier extends Notifier<ExecutionState?> {
  @override
  ExecutionState? build() => null;

  void startTestPlan({
    required TestPlan plan,
    required List<TestRun> existingRuns,
    String? releaseVersion,
  }) {
    final allCases = plan.testCases;
    final steps = ExecutionService.flattenTestCases(allCases);
    final now = DateTime.now();
    final name = ExecutionService.buildRunName(
      baseName: plan.name,
      date: now,
      existingRuns: existingRuns,
      releaseVersion: releaseVersion,
    );
    final run = TestRun(
      id: ExecutionService.newId(),
      name: name,
      sourceType: 'test_plan',
      sourceName: plan.name,
      releaseVersion: releaseVersion,
      executedAt: now,
      stepResults: steps,
    );
    state = ExecutionState(
      run: run,
      currentCaseIndex: 0,
      caseGroups: _buildCaseGroups(allCases, steps),
    );
  }

  void startReleasePlan({
    required ReleasePlan plan,
    required List<TestPlan> allTestPlans,
    required List<TestRun> existingRuns,
    String? releaseVersion,
  }) {
    final cases = <TestCase>[];
    for (final item in plan.items) {
      item.map(
        testPlanRef: (ref) {
          final tp = allTestPlans.firstWhere(
            (p) => p.id == ref.testPlanId,
            orElse: () =>
                throw StateError('Test plan not found: ${ref.testPlanId}'),
          );
          cases.addAll(tp.testCases);
        },
        oneOff: (o) => cases.add(o.testCase),
      );
    }
    final steps = ExecutionService.flattenTestCases(cases);
    final now = DateTime.now();
    final name = ExecutionService.buildRunName(
      baseName: plan.productName,
      date: now,
      existingRuns: existingRuns,
      releaseVersion: releaseVersion,
    );
    final run = TestRun(
      id: ExecutionService.newId(),
      name: name,
      sourceType: 'release_plan',
      sourceName: plan.productName,
      releaseVersion: releaseVersion,
      executedAt: now,
      stepResults: steps,
    );
    state = ExecutionState(
      run: run,
      currentCaseIndex: 0,
      caseGroups: _buildCaseGroups(cases, steps),
    );
  }

  void updateStepResult(int resultIndex, StepResult result) {
    final s = state;
    if (s == null) return;
    final steps = List<StepResult>.from(s.run.stepResults);
    steps[resultIndex] = result;
    state = s.copyWith(run: s.run.copyWith(stepResults: steps));
  }

  // Keep for backward compat — updates the first step of the current case.
  void updateCurrentStepResult(StepResult result) {
    final s = state;
    if (s == null) return;
    final idx = s.currentCase?.stepIndices.first;
    if (idx != null) updateStepResult(idx, result);
  }

  void nextCase() {
    final s = state;
    if (s == null) return;
    if (s.hasNextCase) {
      state = s.copyWith(currentCaseIndex: s.currentCaseIndex + 1);
    } else {
      completeRun();
    }
  }

  void previousCase() {
    final s = state;
    if (s == null) return;
    if (s.hasPrevCase) {
      state = s.copyWith(currentCaseIndex: s.currentCaseIndex - 1);
    }
  }

  // Legacy step navigation kept for compatibility
  void nextStep() => nextCase();
  void previousStep() => previousCase();

  void completeRun() {
    final s = state;
    if (s == null) return;
    state = s.copyWith(
      run: s.run.copyWith(isComplete: true),
      isComplete: true,
    );
  }

  void clearSession() {
    state = null;
  }

  TestRun? get completedRun => (state?.isComplete == true) ? state?.run : null;
}

final executionProvider = NotifierProvider<ExecutionNotifier, ExecutionState?>(
  ExecutionNotifier.new,
);

// ── Test Runs (persisted) ──────────────────────────────────────────────────

class TestRunsNotifier extends AsyncNotifier<List<TestRun>> {
  @override
  Future<List<TestRun>> build() async {
    await ref.watch(storageInitProvider.future);
    return ref.read(storageServiceProvider).loadTestRuns();
  }

  Future<void> addTestRun(TestRun run) async {
    final runs = List<TestRun>.from(state.valueOrNull ?? [])..add(run);
    await ref.read(storageServiceProvider).saveTestRuns(runs);
    state = AsyncData(runs);
  }

  Future<void> deleteTestRun(String id) async {
    final runs = (state.valueOrNull ?? []).where((r) => r.id != id).toList();
    await ref.read(storageServiceProvider).saveTestRuns(runs);
    state = AsyncData(runs);
  }

  Future<void> importRun(TestRun run) async {
    await addTestRun(run);
  }
}

final testRunsProvider = AsyncNotifierProvider<TestRunsNotifier, List<TestRun>>(
  TestRunsNotifier.new,
);
