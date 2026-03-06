import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/services.dart';

/// Provides the initialized StorageService singleton.
/// The real instance is injected via ProviderScope.overrides in main().
final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError(
      'storageServiceProvider must be overridden at startup');
});

/// No-op – kept so existing `ref.watch(storageInitProvider.future)` calls
/// in notifier build() methods continue to compile and resolve immediately.
final storageInitProvider = FutureProvider<void>((ref) async {});
