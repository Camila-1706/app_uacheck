import '../../config/helpers/app_exception.dart';
import '../../domain/datasources/auth_datasource.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;
  AuthRepositoryImpl(this.datasource);

  @override
  Future<AppUser> login(String email, String password, UserRole role) async {
    final user = await datasource.login(email, password);

    if (user.role != role) {
      await datasource.logout();
      final real = user.isTeacher ? 'docente' : 'estudiante';
      throw AppException('Esta cuenta es de $real. Regresa y elige "Soy $real".');
    }
    return user;
  }

  @override
  Future<AppUser> register({
    required String fullName,
    required String code,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return datasource.register(
      fullName: fullName,
      code: code,
      email: email,
      password: password,
      role: role,
    );
  }

  @override
  Future<AppUser?> getCurrentUser() => datasource.getCurrentUser();

  @override
  Future<void> resetPassword(String email) => datasource.resetPassword(email);

  @override
  Future<void> logout() => datasource.logout();
}
