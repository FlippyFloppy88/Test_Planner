import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'storage_provider.dart';

const _uuid = Uuid();

class ReleasePlansNotifier extends AsyncNotifier<List<ReleasePlan>> {
  @override
  Future<List<ReleasePlan>> build() async {
    await ref.watch(storageInitProvider.future);
    return ref.read(storageServiceProvider).loadReleasePlans();
  }

  Future<void> _save(List<ReleasePlan> plans) async {
    await ref.read(storageServiceProvider).saveReleasePlans(plans);
    state = AsyncData(plans);
  }

  Future<void> addReleasePlan(String productName, String description) async {
    final plans = List<ReleasePlan>.from(state.valueOrNull ?? []);
    final now = DateTime.now();
    plans.add(ReleasePlan(
      id: _uuid.v4(),
      productName: productName,
      description: description,
      createdAt: now,
      updatedAt: now,
    ));
    await _save(plans);
  }

  Future<void> updateReleasePlan(ReleasePlan updated) async {
    final plans = List<ReleasePlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == updated.id);
    if (idx != -1) {
      plans[idx] = updated.copyWith(updatedAt: DateTime.now());
      await _save(plans);
    }
  }

  Future<void> deleteReleasePlan(String id) async {
    final plans = (state.valueOrNull ?? []).where((p) => p.id != id).toList();
    await _save(plans);
  }

  Future<void> addTestPlanRef(
      String releasePlanId, String testPlanId, String testPlanName) async {
    final plans = List<ReleasePlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == releasePlanId);
    if (idx == -1) return;
    final items = List<ReleasePlanItem>.from(plans[idx].items);
    items.add(ReleasePlanItem.testPlanRef(
      id: _uuid.v4(),
      testPlanId: testPlanId,
      testPlanName: testPlanName,
      order: items.length,
    ));
    plans[idx] = plans[idx].copyWith(items: items, updatedAt: DateTime.now());
    await _save(plans);
  }

  Future<void> addOneOffTestCase(String releasePlanId, TestCase tc) async {
    final plans = List<ReleasePlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == releasePlanId);
    if (idx == -1) return;
    final items = List<ReleasePlanItem>.from(plans[idx].items);
    items.add(ReleasePlanItem.oneOff(
      id: _uuid.v4(),
      testCase: tc,
      order: items.length,
    ));
    plans[idx] = plans[idx].copyWith(items: items, updatedAt: DateTime.now());
    await _save(plans);
  }

  Future<void> reorderItems(
      String releasePlanId, int oldIndex, int newIndex) async {
    final plans = List<ReleasePlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == releasePlanId);
    if (idx == -1) return;
    final items = List<ReleasePlanItem>.from(plans[idx].items);
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    // Update order field
    final reordered = items.indexed.map((e) {
      return e.$2.map(
        testPlanRef: (r) => r.copyWith(order: e.$1),
        oneOff: (o) => o.copyWith(order: e.$1),
      );
    }).toList();
    plans[idx] =
        plans[idx].copyWith(items: reordered, updatedAt: DateTime.now());
    await _save(plans);
  }

  Future<void> removeItem(String releasePlanId, String itemId) async {
    final plans = List<ReleasePlan>.from(state.valueOrNull ?? []);
    final idx = plans.indexWhere((p) => p.id == releasePlanId);
    if (idx == -1) return;
    plans[idx] = plans[idx].copyWith(
      items: plans[idx].items.where((i) => i.id != itemId).toList(),
      updatedAt: DateTime.now(),
    );
    await _save(plans);
  }
}

final releasePlansProvider =
    AsyncNotifierProvider<ReleasePlansNotifier, List<ReleasePlan>>(
  ReleasePlansNotifier.new,
);
