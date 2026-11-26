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
  Future<void> createCourse({
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

    await datasource.createCourse(
      name: name,
      code: code,
      groupName: groupName,
      classroom: classroom,
      days: days,
      startTime: startTime,
      endTime: endTime,
    );
  }
}