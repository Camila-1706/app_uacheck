import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/helpers/app_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'repository_providers.dart';

class AuthState {
  final AppUser? user;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.loading = false, this.error});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AuthState()) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    try {
      final user = await _repo.getCurrentUser();
      state = AuthState(user: user);
    } catch (_) {
      state = const AuthState();
    }
  }

  Future<bool> login(String email, String password, UserRole role) async {
    state = const AuthState(loading: true);
    try {
      final user = await _repo.login(email, password, role);
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = AuthState(error: AppException.messageOf(e));
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String code,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    state = const AuthState(loading: true);
    try {
      final user = await _repo.register(
        fullName: fullName,
        code: code,
        email: email,
        password: password,
        role: role,
      );
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = AuthState(error: AppException.messageOf(e));
      return false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState();
  }

    Future<void> resetPassword(String email) async {
    await _repo.resetPassword(email);
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
