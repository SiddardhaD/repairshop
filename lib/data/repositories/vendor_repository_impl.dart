import 'package:hive/hive.dart';
import '../../domain/entities/vendor.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../models/vendor_model.dart';
import '../services/mock_data_service.dart';

class VendorRepositoryImpl implements VendorRepository {
  final Box<VendorModel> _vendorBox;
  final MockDataService _mockDataService;

  VendorRepositoryImpl(this._vendorBox, this._mockDataService);

  Future<void> _initializeMockData() async {
    if (_vendorBox.isEmpty) {
      final vendors = _mockDataService.getMockVendors();
      for (final vendor in vendors) {
        final model = VendorModel.fromEntity(vendor);
        await _vendorBox.put(vendor.id, model);
      }
    }
  }

  @override
  Future<List<Vendor>> getAllVendors() async {
    await _initializeMockData();
    return _vendorBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Vendor>> getFeaturedVendors({int limit = 10}) async {
    await _initializeMockData();
    final vendors = _vendorBox.values
        .where((model) => model.isAvailable)
        .map((model) => model.toEntity())
        .toList();

    vendors.sort((a, b) => b.rating.compareTo(a.rating));
    return vendors.take(limit).toList();
  }

  @override
  Future<List<Vendor>> getNearbyVendors({
    required double latitude,
    required double longitude,
    double radiusInKm = 10,
  }) async {
    await _initializeMockData();
    final vendors = _vendorBox.values
        .where((model) => model.distanceInKm <= radiusInKm)
        .map((model) => model.toEntity())
        .toList();

    vendors.sort((a, b) => a.distanceInKm.compareTo(b.distanceInKm));
    return vendors;
  }

  @override
  Future<Vendor?> getVendorById(String id) async {
    await _initializeMockData();
    final model = _vendorBox.get(id);
    return model?.toEntity();
  }

  @override
  Future<List<Vendor>> getVendorsBySpecialty(String specialty) async {
    await _initializeMockData();
    final vendors = _vendorBox.values
        .where((model) => model.specialties.contains(specialty))
        .map((model) => model.toEntity())
        .toList();

    vendors.sort((a, b) => b.rating.compareTo(a.rating));
    return vendors;
  }

  @override
  Future<List<Vendor>> searchVendors(String query) async {
    await _initializeMockData();
    final lowerQuery = query.toLowerCase();
    final vendors = _vendorBox.values
        .where((model) =>
            model.name.toLowerCase().contains(lowerQuery) ||
            model.specialties.any((s) => s.toLowerCase().contains(lowerQuery)))
        .map((model) => model.toEntity())
        .toList();

    return vendors;
  }
}
