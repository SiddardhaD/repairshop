import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String phone, String password) {
    return repository.login(phone, password);
  }
}

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<User> call({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.signup(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> call() {
    return repository.getCurrentUser();
  }
}

class VerifyOTPUseCase {
  final AuthRepository repository;

  VerifyOTPUseCase(this.repository);

  Future<bool> call(String phone, String otp) {
    return repository.verifyOTP(phone, otp);
  }
}

class SendOTPUseCase {
  final AuthRepository repository;

  SendOTPUseCase(this.repository);

  Future<void> call(String phone) {
    return repository.sendOTP(phone);
  }
}

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() {
    return repository.isLoggedIn();
  }
}
