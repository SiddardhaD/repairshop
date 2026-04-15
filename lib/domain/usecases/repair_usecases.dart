import '../entities/repair.dart';
import '../repositories/repair_repository.dart';

class GetUserRepairsUseCase {
  final RepairRepository repository;

  GetUserRepairsUseCase(this.repository);

  Future<List<Repair>> call(String userId) {
    return repository.getUserRepairs(userId);
  }
}

class GetRepairByIdUseCase {
  final RepairRepository repository;

  GetRepairByIdUseCase(this.repository);

  Future<Repair?> call(String id) {
    return repository.getRepairById(id);
  }
}

class CreateRepairUseCase {
  final RepairRepository repository;

  CreateRepairUseCase(this.repository);

  Future<Repair> call(Repair repair) {
    return repository.createRepair(repair);
  }
}

class UpdateRepairStatusUseCase {
  final RepairRepository repository;

  UpdateRepairStatusUseCase(this.repository);

  Future<Repair> call(
    String repairId,
    RepairStatus status, {
    String? notes,
  }) {
    return repository.updateRepairStatus(repairId, status, notes: notes);
  }
}

class DeleteRepairUseCase {
  final RepairRepository repository;

  DeleteRepairUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteRepair(id);
  }
}

class FilterRepairsByStatusUseCase {
  final RepairRepository repository;

  FilterRepairsByStatusUseCase(this.repository);

  Future<List<Repair>> call(String userId, RepairStatus status) {
    return repository.filterRepairsByStatus(userId, status);
  }
}

class SearchRepairsUseCase {
  final RepairRepository repository;

  SearchRepairsUseCase(this.repository);

  Future<List<Repair>> call(String query) {
    return repository.searchRepairs(query);
  }
}
