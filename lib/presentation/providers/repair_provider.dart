import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/repair.dart';
import 'repository_providers.dart';
import 'auth_provider.dart';

final userRepairsProvider = FutureProvider<List<Repair>>((ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];

  final repairRepository = ref.watch(repairRepositoryProvider);
  return repairRepository.getUserRepairs(user.id);
});

final repairByIdProvider =
    FutureProvider.family<Repair?, String>((ref, repairId) async {
  final repairRepository = ref.watch(repairRepositoryProvider);
  return repairRepository.getRepairById(repairId);
});

final repairsByStatusProvider = FutureProvider.family<List<Repair>, RepairStatus>(
  (ref, status) async {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return [];

    final repairRepository = ref.watch(repairRepositoryProvider);
    return repairRepository.filterRepairsByStatus(user.id, status);
  },
);

final repairStatsProvider = Provider<Map<String, int>>((ref) {
  final repairsAsync = ref.watch(userRepairsProvider);

  return repairsAsync.when(
    data: (repairs) {
      final activeRepairs = repairs
          .where((r) =>
              r.status != RepairStatus.delivered &&
              r.status != RepairStatus.completed)
          .length;
      final inProgress = repairs
          .where((r) =>
              r.status == RepairStatus.repairing ||
              r.status == RepairStatus.diagnosing)
          .length;
      final completed = repairs
          .where((r) =>
              r.status == RepairStatus.completed ||
              r.status == RepairStatus.delivered)
          .length;
      final outForDelivery =
          repairs.where((r) => r.status == RepairStatus.outForDelivery).length;

      return {
        'active': activeRepairs,
        'inProgress': inProgress,
        'completed': completed,
        'outForDelivery': outForDelivery,
      };
    },
    loading: () => {
      'active': 0,
      'inProgress': 0,
      'completed': 0,
      'outForDelivery': 0,
    },
    error: (_, __) => {
      'active': 0,
      'inProgress': 0,
      'completed': 0,
      'outForDelivery': 0,
    },
  );
});

class RepairNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  RepairNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> createRepair(Repair repair) async {
    state = const AsyncValue.loading();
    try {
      final repairRepository = ref.read(repairRepositoryProvider);
      await repairRepository.createRepair(repair);
      ref.invalidate(userRepairsProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateRepairStatus(
    String repairId,
    RepairStatus status, {
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repairRepository = ref.read(repairRepositoryProvider);
      await repairRepository.updateRepairStatus(repairId, status, notes: notes);
      ref.invalidate(userRepairsProvider);
      ref.invalidate(repairByIdProvider(repairId));
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> deleteRepair(String repairId) async {
    state = const AsyncValue.loading();
    try {
      final repairRepository = ref.read(repairRepositoryProvider);
      await repairRepository.deleteRepair(repairId);
      ref.invalidate(userRepairsProvider);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}

final repairNotifierProvider =
    StateNotifierProvider<RepairNotifier, AsyncValue<void>>((ref) {
  return RepairNotifier(ref);
});
