import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../config/helpers/app_exception.dart';
import '../../../domain/datasources/auth_datasource.dart';
import '../../../domain/entities/user.dart';
import '../../mappers/user_mapper.dart';
import '../../models/user_model.dart';

class SupabaseAuthDatasource implements AuthDatasource {
  // Atajo para no escribir Supabase.instance.client cada vez
  SupabaseClient get _client => Supabase.instance.client;

  Future<AppUser> _loadProfile(String uid) async {
    Map<String, dynamic>? row;

    try {
      row = await _client.from('users').select().eq('id', uid).maybeSingle();
    } on PostgrestException catch (e) {
      debugPrint('Error leyendo perfil: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    }

    // Si no hay fila, la cuenta existe en Supabase pero sin perfil
    if (row == null) {
      await _client.auth.signOut();
      throw const AppException('No se encontró el perfil de tu cuenta.');
    }

    final model = UserModel.fromMap(uid, row);
    return UserMapper.toEntity(model);
  }

  @override
  Future<AppUser> login(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final authUser = response.user;
      if (authUser == null) {
        throw const AppException('No se pudo iniciar sesión.');
      }

      return await _loadProfile(authUser.id);
    } on AuthException catch (e) {
      throw AppException(_authMessage(e.message));
    }
  }

  @override
  Future<AppUser> register({
    required String fullName,
    required String code,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );

      final authUser = response.user;

      if (authUser == null || response.session == null) {
        throw const AppException(
          'Cuenta creada. Confirma tu correo y luego inicia sesión.',
        );
      }

      String roleText = 'student';
      String program = 'Programa por definir';
      if (role == UserRole.teacher) {
        roleText = 'teacher';
        program = 'Facultad por definir';
      }

      final model = UserModel(
        id: authUser.id,
        fullName: fullName.trim(),
        code: code.trim(),
        email: email.trim().toLowerCase(),
        role: roleText,
        program: program,
        campus: 'Florencia',
      );

      final data = model.toMap();
      data['id'] = authUser.id;

      try {
        await _client.from('users').insert(data);
      } on PostgrestException catch (e) {
        debugPrint('Error guardando perfil: ${e.code} - ${e.message}');
        await _client.auth.signOut();
        throw AppException(_dbMessage(e));
      }

      return UserMapper.toEntity(model);
    } on AuthException catch (e) {
      throw AppException(_authMessage(e.message));
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) return null;
    return _loadProfile(authUser.id);
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email.trim());
    } on AuthException catch (e) {
      throw AppException(_authMessage(e.message));
    }
  }

  @override
  Future<void> logout() => _client.auth.signOut();

  String _dbMessage(PostgrestException e) {
    // 23505 = dato repetido - código o correo ya existen
    if (e.code == '23505') {
      final text = e.message.toLowerCase();
      if (text.contains('code')) return 'Ya existe una cuenta con ese código.';
      if (text.contains('email')) return 'Ya existe una cuenta con ese correo.';
      return 'Ya existe una cuenta con esos datos.';
    }
    // 42501 = Supabase bloqueó la operación por las políticas RLS
    if (e.code == '42501') {
      return 'Sin permiso en la tabla users. Revisa las políticas (RLS).';
    }
    // 42P01 = la tabla no existe
    if (e.code == '42P01') {
      return 'La tabla users no existe en Supabase.';
    }
    return 'No se pudo acceder a los datos del perfil.';
  }

  String _authMessage(String raw) {
    debugPrint('Auth error: $raw');
    final t = raw.toLowerCase();
    if (t.contains('invalid login')) return 'Correo o contraseña incorrectos.';
    if (t.contains('already registered')) {
      return 'Ya existe una cuenta con ese correo.';
    }
    if (t.contains('not confirmed')) return 'Primero confirma tu correo.';
    if (t.contains('rate limit') || t.contains('too many')) {
      return 'Demasiados intentos. Espera un momento.';
    }
    if (t.contains('password')) {
      return 'La contraseña no cumple los requisitos.';
    }
    if (t.contains('clientexception') ||
        t.contains('socket') ||
        t.contains('host lookup') ||
        t.contains('network') ||
        t.contains('fetch')) {
      return 'No se pudo conectar con Supabase. Revisa tu internet y la URL.';
    }
    return 'No se pudo completar la operación.';
  }
}