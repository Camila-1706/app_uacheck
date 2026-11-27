import 'package:app_uacheck_1/domain/entities/enrolled_student.dart';

import '../entities/course.dart';
import '../entities/enroll_result.dart';
import '../entities/imported_student.dart';

abstract class CourseDatasource {
  Future<List<Course>> getTeacherCourses();

  /// Crea la materia y devuelve su id
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
