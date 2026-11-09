import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../infrastructure/datasources/supabase/supabase_auth_datasource.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(SupabaseAuthDatasource()),
);