import '../entities/user.dart';

/// Reglas de negocio de autenticación.
abstract class AuthRepository {
  /// Inicia sesión y verifica que la cuenta pertenezca al rol elegido.
  Future<AppUser> login(String email, String password, UserRole role);

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
