import 'package:app_uacheck_1/domain/entities/enroll_result.dart';
import 'package:app_uacheck_1/domain/entities/enrolled_student.dart';
import 'package:app_uacheck_1/domain/entities/imported_student.dart';

import '../entities/course.dart';

// Reglas de negocio de las materias.
abstract class CourseRepository {
  Future<List<Course>> getTeacherCourses();

  // Crea la materia y devuelve su id
  Future<String> createCourse({
    required String name,
    required String code,
    required String groupName,
    required String classroom,
    required List<int> days,
    required String startTime,
    required String endTime,
  });

  Future<EnrollResult> enrollStudents({
    required String courseId,
    required List<ImportedStudent> students,
  });

  Future<List<EnrolledStudent>> getCourseStudents(String courseId);

  Future<void> removeStudent({
    required String courseId,
    required String studentCode,
  });
}
