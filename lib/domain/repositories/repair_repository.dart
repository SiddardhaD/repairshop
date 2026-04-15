import '../entities/repair.dart';

abstract class RepairRepository {
  Future<List<Repair>> getUserRepairs(String userId);
  Future<Repair?> getRepairById(String id);
  Future<Repair> createRepair(Repair repair);
  Future<Repair> updateRepair(Repair repair);
  Future<void> deleteRepair(String id);
  Future<Repair> updateRepairStatus(
    String repairId,
    RepairStatus status, {
    String? notes,
  });
  Future<List<Repair>> searchRepairs(String query);
  Future<List<Repair>> filterRepairsByStatus(String userId, RepairStatus status);
}
