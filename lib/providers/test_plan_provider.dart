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

  Future<void> addTestPlan(String name, String description) async {
    final plans = List<TestPlan>.from(state.valueOrNull ?? []);
    final now = DateTime.now();
    plans.add(TestPlan(
      id: _uuid.v4(),
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    ));
    await _save(plans);
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
      await ref.read(storageServiceProvider).deleteRelativeFolder(slug);
      await ref.read(storageServiceProvider).deleteFileIfExists('$slug.json');
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
