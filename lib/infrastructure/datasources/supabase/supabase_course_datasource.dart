import 'package:app_uacheck_1/domain/entities/enroll_result.dart';
import 'package:app_uacheck_1/domain/entities/enrolled_student.dart';
import 'package:app_uacheck_1/domain/entities/imported_student.dart';
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
  Future<String> createCourse({
    required String name,
    required String code,
    required String groupName,
    required String classroom,
    required List<int> days,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final row = await _client
          .from('courses')
          .insert({
            'teacher_id': _teacherId,
            'name': name.trim(),
            'code': code.trim(),
            'group_name': groupName.trim(),
            'classroom': classroom.trim(),
            'days': days,
            'start_time': startTime,
            'end_time': endTime,
          })
          .select('id')
          .single();

      return row['id'] as String;
    } on PostgrestException catch (e) {
      debugPrint('Error creando materia: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    }
  }

  @override
  Future<EnrollResult> enrollStudents({
    required String courseId,
    required List<ImportedStudent> students,
  }) async {
    try {
      final existingRows = await _client
          .from('enrollments')
          .select('student_code, student_name')
          .eq('course_id', courseId);

      final existingNames = <String, String>{
        for (final row in existingRows)
          row['student_code'] as String: row['student_name'] as String? ?? '',
      };

      final added = students
          .where((s) => !existingNames.containsKey(s.code))
          .length;
      final updated = students.length - added;
      final rows = students.map((student) {
        final name = student.name.isNotEmpty
            ? student.name
            : existingNames[student.code];
        return {
          'course_id': courseId,
          'student_code': student.code,
          'student_name': name ?? '',
        };
      }).toList();

      await _client
          .from('enrollments')
          .upsert(rows, onConflict: 'course_id,student_code');

      return EnrollResult(added: added, updated: updated);
    } on PostgrestException catch (e) {
      debugPrint('Error matriculando: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    } catch (e) {
      debugPrint('Error de red matriculando: $e');
      throw const AppException(
        'No se pudo conectar. Revisa tu internet e intenta de nuevo.',
      );
    }
  }

  String _dbMessage(PostgrestException e) {
    // 42501 = Supabase bloqueo la operacion por las políticas RLS
    if (e.code == '42501') {
      return 'No tienes permiso para esta operación. Revisa las políticas (RLS).';
    }
    // 42P01 = una tabla no existe
    if (e.code == '42P01') {
      return 'Falta una tabla en Supabase. Revisa que el SQL se ejecutó completo.';
    }
    // 42703 / PGRST204 = falta una columna
    if (e.code == '42703' || e.code == 'PGRST204') {
      return 'Falta actualizar la base de datos (columna nueva). Ejecuta el SQL del paso 1.';
    }
    // 23503 = la materia a la que apuntamos ya no existe
    if (e.code == '23503') return 'La materia ya no existe.';
    // 23514 = un dato no cumple el formato que exige la base de datos
    if (e.code == '23514') return 'Algún dato no tiene el formato permitido.';
    return 'No se pudo acceder a los datos de las materias.';
  }

  @override
  Future<List<EnrolledStudent>> getCourseStudents(String courseId) async {
    try {
      final enrollmentRows = await _client
          .from('enrollments')
          .select('student_code, student_name')
          .eq('course_id', courseId)
          .order('student_name');

      final studentCodes = enrollmentRows
          .map((row) => row['student_code'] as String)
          .toList();

      // Codigos que ya tienen cuenta en la app
      final registeredCodes = <String>{};
      if (studentCodes.isNotEmpty) {
        final userRows = await _client
            .from('users')
            .select('code')
            .inFilter('code', studentCodes);

        for (final row in userRows) {
          registeredCodes.add(row['code'] as String);
        }
      }

      return enrollmentRows.map((row) {
        final code = row['student_code'] as String;
        return EnrolledStudent(
          code: code,
          name: row['student_name'] as String? ?? '',
          hasAccount: registeredCodes.contains(code),
        );
      }).toList();
    } on PostgrestException catch (e) {
      debugPrint('Error leyendo estudiantes: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    } catch (e) {
      debugPrint('Error de red leyendo estudiantes: $e');
      throw const AppException(
        'No se pudo conectar. Revisa tu internet e intenta de nuevo.',
      );
    }
  }

  @override
  Future<void> removeStudent({
    required String courseId,
    required String studentCode,
  }) async {
    try {
      await _client
          .from('enrollments')
          .delete()
          .eq('course_id', courseId)
          .eq('student_code', studentCode);
    } on PostgrestException catch (e) {
      debugPrint('Error quitando estudiante: ${e.code} - ${e.message}');
      throw AppException(_dbMessage(e));
    } catch (e) {
      debugPrint('Error de red quitando estudiante: $e');
      throw const AppException(
        'No se pudo conectar. Revisa tu internet e intenta de nuevo.',
      );
    }
  }
}
