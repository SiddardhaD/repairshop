import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/repair_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/vendor_model.dart';
import '../../data/repositories/repair_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/vendor_repository_impl.dart';
import '../../data/services/local_storage_service.dart';
import '../../data/services/mock_data_service.dart';
import '../../domain/repositories/repair_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/vendor_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
});

final mockDataServiceProvider = Provider<MockDataService>((ref) {
  return MockDataService();
});

final repairBoxProvider = Provider<Box<RepairModel>>((ref) {
  return Hive.box<RepairModel>('repairs');
});

final userBoxProvider = Provider<Box<UserModel>>((ref) {
  return Hive.box<UserModel>('users');
});

final vendorBoxProvider = Provider<Box<VendorModel>>((ref) {
  return Hive.box<VendorModel>('vendors');
});

final repairRepositoryProvider = Provider<RepairRepository>((ref) {
  final box = ref.watch(repairBoxProvider);
  return RepairRepositoryImpl(box);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final box = ref.watch(userBoxProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return AuthRepositoryImpl(box, storage);
});

final vendorRepositoryProvider = Provider<VendorRepository>((ref) {
  final box = ref.watch(vendorBoxProvider);
  final mockData = ref.watch(mockDataServiceProvider);
  return VendorRepositoryImpl(box, mockData);
});
