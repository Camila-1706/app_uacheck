import '../entities/user.dart';

abstract class AuthDatasource {
  Future<AppUser> login(String email, String password);

  Future<AppUser> register({
    required String fullName,
    required String code,
    required String email,
    required String password,
    required UserRole role,
  });

  Future<AppUser?> getCurrentUser();

  Future<void> resetPassword(String email);

  Future<void> logout();
}
