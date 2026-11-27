import 'package:app_uacheck_1/domain/entities/enroll_result.dart';
import 'package:app_uacheck_1/domain/entities/enrolled_student.dart';
import 'package:app_uacheck_1/domain/entities/imported_student.dart';

import '../../config/helpers/app_exception.dart';
import '../../config/helpers/validators.dart';
import '../../domain/datasources/course_datasource.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseDatasource datasource;
  CourseRepositoryImpl(this.datasource);

  @override
  Future<List<Course>> getTeacherCourses() => datasource.getTeacherCourses();

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
    if (days.isEmpty) {
      throw const AppException('Selecciona al menos un día de clase.');
    }

    final rangeError = Validators.timeRange(startTime, endTime);
    if (rangeError != null) throw AppException(rangeError);

    return datasource.createCourse(
      name: name,
      code: code,
      groupName: groupName,
      classroom: classroom,
      days: days,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  Future<List<EnrolledStudent>> getCourseStudents(String courseId) =>
      datasource.getCourseStudents(courseId);

  @override
  Future<void> removeStudent({
    required String courseId,
    required String studentCode,
  }) => datasource.removeStudent(courseId: courseId, studentCode: studentCode);

  @override
  Future<EnrollResult> enrollStudents({
    required String courseId,
    required List<ImportedStudent> students,
  }) async {
    final byCode = <String, ImportedStudent>{};
    for (final student in students) {
      if (Validators.userCode(student.code) == null) {
        byCode[student.code] = student;
      }
    }

    if (byCode.isEmpty) {
      throw const AppException('No hay estudiantes válidos para matricular.');
    }

    return datasource.enrollStudents(
      courseId: courseId,
      students: byCode.values.toList(),
    );
  }
}
