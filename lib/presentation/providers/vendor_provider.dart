import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/vendor.dart';
import 'repository_providers.dart';

final featuredVendorsProvider = FutureProvider<List<Vendor>>((ref) async {
  final vendorRepository = ref.watch(vendorRepositoryProvider);
  return vendorRepository.getFeaturedVendors(limit: 10);
});

final allVendorsProvider = FutureProvider<List<Vendor>>((ref) async {
  final vendorRepository = ref.watch(vendorRepositoryProvider);
  return vendorRepository.getAllVendors();
});

final vendorByIdProvider =
    FutureProvider.family<Vendor?, String>((ref, vendorId) async {
  final vendorRepository = ref.watch(vendorRepositoryProvider);
  return vendorRepository.getVendorById(vendorId);
});
