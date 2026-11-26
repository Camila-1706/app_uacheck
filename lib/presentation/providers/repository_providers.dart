import '../../domain/repositories/course_repository.dart';
import '../../infrastructure/datasources/supabase/supabase_course_datasource.dart';
import '../../infrastructure/repositories/course_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../infrastructure/datasources/supabase/supabase_auth_datasource.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(SupabaseAuthDatasource()),
);

final courseRepositoryProvider = Provider<CourseRepository>(
  (ref) => CourseRepositoryImpl(SupabaseCourseDatasource()),
);