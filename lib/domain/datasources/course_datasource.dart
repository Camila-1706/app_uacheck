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
}
