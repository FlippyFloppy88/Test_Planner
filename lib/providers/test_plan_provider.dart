import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'storage_provider.dart';

const _uuid = Uuid();

// ── Test Plans ─────────────────────────────────────────────────────────────

class TestPlansNotifier extends AsyncNotifier<List<TestPlan>> {
  @override
  Future<List<TestPlan>> build() async {
    await ref.watch(storageInitProvider.future);
    return ref.read(storageServiceProvider).loadTestPlans();
  }

  Future<void> _save(List<TestPlan> plans) async {
    await ref.read(storageServiceProvider).saveTestPlans(plans);
    state = AsyncData(plans);
  }

  Future<String> addTestPlan(String name, String description) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final now = DateTime.now();
    final id = _uuid.v4();
    plans.add(TestPlan(
      id: id,
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    ));
    await _save(plans);
    return id;
  }

  Future<void> updateTestPlan(TestPlan updated) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == updated.id);
    if (idx != -1) {
      plans[idx] = updated.copyWith(updatedAt: DateTime.now());
      await _save(plans);
    }
  }

  Future<void> deleteTestPlan(String id) async {
    // Find the plan so we can remove its image folder and any per-plan files.
    final current = state.valueOrNull ?? [];
    final idx = current.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final plan = current[idx];
      // Compute plan-level image folder slug (same as used elsewhere).
      String slug = plan.name.isEmpty ? plan.id : plan.name;
      slug = slug.replaceAll(RegExp(r'[^\w\s-]'), '');
      slug = slug.replaceAll(RegExp(r'\s+'), '_').trim();
      // Remove plan folder and any per-plan JSON (best-effort).
      await ref.read(storageServiceProvider).deleteRelativeFolder('test_plans/$slug');
      await ref.read(storageServiceProvider).deleteFileIfExists('test_plans/$slug.json');
    }

    final plans = (state.valueOrNull ?? []).where((p) => p.id != id).toList();
    await _save(plans);
  }

  // ── Test Cases ────────────────────────────────────────────────────────────
  Future<void> addTestCase(
      String planId, String name, String description) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == planId);
    if (idx == -1) return;
    final now = DateTime.now();
    final tc = TestCase(
      id: _uuid.v4(),
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
    plans[idx] = plans[idx].copyWith(
      testCases: [...plans[idx].testCases, tc],
      updatedAt: now,
    );
    await _save(plans);
  }

  Future<void> updateTestCase(String planId, TestCase updated) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == planId);
    if (idx == -1) return;
    final cases = List<TestCase>.from(plans[idx].testCases);
    final cIdx = cases.indexWhere((c) => c.id == updated.id);
    if (cIdx != -1) {
      cases[cIdx] = updated.copyWith(updatedAt: DateTime.now());
      plans[idx] = plans[idx].copyWith(
        testCases: cases,
        updatedAt: DateTime.now(),
      );
      await _save(plans);
    }
  }

  Future<void> deleteTestCase(String planId, String caseId) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == planId);
    if (idx == -1) return;
    plans[idx] = plans[idx].copyWith(
      testCases: plans[idx].testCases.where((c) => c.id != caseId).toList(),
      updatedAt: DateTime.now(),
    );
    await _save(plans);
  }

  Future<void> moveTestCase(
      String fromPlanId, String caseId, String toPlanId) async {
    if (fromPlanId == toPlanId) return;
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final fromIdx = plans.indexWhere((p) => p.id == fromPlanId);
    final toIdx = plans.indexWhere((p) => p.id == toPlanId);
    if (fromIdx == -1 || toIdx == -1) return;
    final tc =
        plans[fromIdx].testCases.firstWhere((c) => c.id == caseId);
    plans[fromIdx] = plans[fromIdx].copyWith(
      testCases:
          plans[fromIdx].testCases.where((c) => c.id != caseId).toList(),
      updatedAt: DateTime.now(),
    );
    plans[toIdx] = plans[toIdx].copyWith(
      testCases: [...plans[toIdx].testCases, tc],
      updatedAt: DateTime.now(),
    );
    await _save(plans);
  }

  Future<void> reorderTestCases(
      String planId, int oldIndex, int newIndex) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == planId);
    if (idx == -1) return;
    final cases = List<TestCase>.from(plans[idx].testCases);
    final item = cases.removeAt(oldIndex);
    cases.insert(newIndex, item);
    plans[idx] =
        plans[idx].copyWith(testCases: cases, updatedAt: DateTime.now());
    await _save(plans);
  }
}

final testPlansProvider =
    AsyncNotifierProvider<TestPlansNotifier, List<TestPlan>>(
  TestPlansNotifier.new,
);

/// Convenience: single plan by id
final testPlanByIdProvider = Provider.family<TestPlan?, String>((ref, id) {
  return ref.watch(testPlansProvider).valueOrNull?.firstWhere((p) => p.id == id,
      orElse: () => throw StateError('Not found'));
});
