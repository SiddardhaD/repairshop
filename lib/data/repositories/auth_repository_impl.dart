import 'dart:async';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../services/local_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Box<UserModel> _userBox;
  final LocalStorageService _storageService;
  final _uuid = const Uuid();
  final _authStateController = StreamController<User?>.broadcast();

  AuthRepositoryImpl(this._userBox, this._storageService);

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  Future<User?> getCurrentUser() async {
    final userId = await _storageService.getUserId();
    if (userId == null) return null;

    final model = _userBox.get(userId);
    return model?.toEntity();
  }

  @override
  Future<bool> isLoggedIn() async {
    final userId = await _storageService.getUserId();
    return userId != null;
  }

  @override
  Future<User> login(String phone, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final existingUser = _userBox.values.firstWhere(
      (model) => model.phone == phone,
      orElse: () => throw Exception('User not found. Please signup first.'),
    );

    final user = existingUser.toEntity();
    await _storageService.saveUserId(user.id);
    await _storageService.saveUserName(user.name);
    await _storageService.saveUserEmail(user.email);

    _authStateController.add(user);

    return user;
  }

  @override
  Future<void> logout() async {
    await _storageService.clearUserData();
    _authStateController.add(null);
  }

  @override
  Future<void> sendOTP(String phone) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final existingUser = _userBox.values.where((model) => model.phone == phone);
    if (existingUser.isNotEmpty) {
      throw Exception('User with this phone number already exists');
    }

    final userId = _uuid.v4();
    final user = User(
      id: userId,
      name: name,
      email: email,
      phone: phone,
      createdAt: DateTime.now(),
    );

    final model = UserModel.fromEntity(user);
    await _userBox.put(userId, model);

    await _storageService.saveUserId(userId);
    await _storageService.saveUserName(name);
    await _storageService.saveUserEmail(email);

    _authStateController.add(user);

    return user;
  }

  @override
  Future<bool> verifyOTP(String phone, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    return otp == '123456';
  }

  void dispose() {
    _authStateController.close();
  }
}
