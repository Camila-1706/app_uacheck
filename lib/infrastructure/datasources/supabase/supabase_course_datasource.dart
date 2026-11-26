import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../config/helpers/app_exception.dart';
import '../../../domain/datasources/course_datasource.dart';
import '../../../domain/entities/course.dart';
import '../../mappers/course_mapper.dart';
import '../../models/course_model.dart';

class SupabaseCourseDatasource implements CourseDatasource {
  SupabaseClient get _client => Supabase.instance.client;

  String get _teacherId {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AppException('Tu sesión expiró. Inicia sesión de nuevo.');
    }
    return user.id;
  }

  @override
  Future<List<Course>> getTeacherCourses() async {
    try {
      final rows = await _client
          .from('courses')
          .select('*, enrollments(count)')
          .eq('teacher_id', _teacherId)
          .order('created_at', ascending: false);

      return rows
          .map((row) => CourseMapper.toEntity(CourseModel.fromMap(row)))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Error leyendo materias: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    }
  }

  @override
  Future<void> createCourse({
    required String name,
    required String code,
    required String groupName,
    required String classroom,
    required List<int> days,
    required String startTime,
    required String endTime,
  }) async {
    try {
      await _client.from('courses').insert({
        'teacher_id': _teacherId,
        'name': name.trim(),
        'code': code.trim(),
        'group_name': groupName.trim(),
        'classroom': classroom.trim(),
        'days': days,
        'start_time': startTime,
        'end_time': endTime,
      });
    } on PostgrestException catch (e) {
      debugPrint('Error creando materia: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    }
  }

  String _dbMessage(PostgrestException e) {

    if (e.code == '42501') {
      return 'Sin permiso en la tabla courses. Revisa las políticas (RLS).';
    }
    
    if (e.code == '42P01') return 'La tabla courses no existe en Supabase.';
    return 'No se pudo acceder a las materias.';
  }
}