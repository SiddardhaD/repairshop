import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> getCurrentUser();
  Future<User> login(String phone, String password);
  Future<User> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
  Future<void> logout();
  Future<bool> verifyOTP(String phone, String otp);
  Future<void> sendOTP(String phone);
  Future<bool> isLoggedIn();
  Stream<User?> get authStateChanges;
}
