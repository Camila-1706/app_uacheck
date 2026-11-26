import '../entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getTeacherCourses();

  Future<void> createCourse({
    required String name,
    required String code,
    required String groupName,
    required String classroom,
    required List<int> days,
    required String startTime,
    required String endTime,
  });
}