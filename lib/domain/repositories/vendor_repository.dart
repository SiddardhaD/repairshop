import '../entities/vendor.dart';

abstract class VendorRepository {
  Future<List<Vendor>> getAllVendors();
  Future<Vendor?> getVendorById(String id);
  Future<List<Vendor>> getFeaturedVendors({int limit = 10});
  Future<List<Vendor>> searchVendors(String query);
  Future<List<Vendor>> getVendorsBySpecialty(String specialty);
  Future<List<Vendor>> getNearbyVendors({
    required double latitude,
    required double longitude,
    double radiusInKm = 10,
  });
}
