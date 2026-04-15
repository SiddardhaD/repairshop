import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/repair.dart';
import '../../domain/repositories/repair_repository.dart';
import '../models/repair_model.dart';

class RepairRepositoryImpl implements RepairRepository {
  final Box<RepairModel> _repairBox;
  final _uuid = const Uuid();

  RepairRepositoryImpl(this._repairBox);

  @override
  Future<Repair> createRepair(Repair repair) async {
    final repairWithId = repair.copyWith(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
      statusHistory: [
        RepairStatusUpdate(
          status: repair.status,
          timestamp: DateTime.now(),
        ),
      ],
    );

    final model = RepairModel.fromEntity(repairWithId);
    await _repairBox.put(repairWithId.id, model);

    return repairWithId;
  }

  @override
  Future<void> deleteRepair(String id) async {
    await _repairBox.delete(id);
  }

  @override
  Future<List<Repair>> filterRepairsByStatus(
      String userId, RepairStatus status) async {
    final repairs = _repairBox.values
        .where((model) =>
            model.userId == userId && model.status == status.name)
        .map((model) => model.toEntity())
        .toList();

    repairs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return repairs;
  }

  @override
  Future<Repair?> getRepairById(String id) async {
    final model = _repairBox.get(id);
    return model?.toEntity();
  }

  @override
  Future<List<Repair>> getUserRepairs(String userId) async {
    final repairs = _repairBox.values
        .where((model) => model.userId == userId)
        .map((model) => model.toEntity())
        .toList();

    repairs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return repairs;
  }

  @override
  Future<List<Repair>> searchRepairs(String query) async {
    final lowerQuery = query.toLowerCase();
    final repairs = _repairBox.values
        .where((model) =>
            model.productName.toLowerCase().contains(lowerQuery) ||
            model.issueDescription.toLowerCase().contains(lowerQuery) ||
            model.vendorName.toLowerCase().contains(lowerQuery))
        .map((model) => model.toEntity())
        .toList();

    repairs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return repairs;
  }

  @override
  Future<Repair> updateRepair(Repair repair) async {
    final model = RepairModel.fromEntity(repair);
    await _repairBox.put(repair.id, model);
    return repair;
  }

  @override
  Future<Repair> updateRepairStatus(
    String repairId,
    RepairStatus status, {
    String? notes,
  }) async {
    final model = _repairBox.get(repairId);
    if (model == null) {
      throw Exception('Repair not found');
    }

    final repair = model.toEntity();
    final updatedHistory = [
      ...repair.statusHistory,
      RepairStatusUpdate(
        status: status,
        timestamp: DateTime.now(),
        notes: notes,
      ),
    ];

    final updatedRepair = repair.copyWith(
      status: status,
      statusHistory: updatedHistory,
      completedAt:
          status == RepairStatus.completed ? DateTime.now() : repair.completedAt,
      deliveredAt:
          status == RepairStatus.delivered ? DateTime.now() : repair.deliveredAt,
    );

    return updateRepair(updatedRepair);
  }
}
