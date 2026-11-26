import '../../domain/entities/course.dart';
import '../models/course_model.dart';

class CourseMapper {
  static Course toEntity(CourseModel m) => Course(
        id: m.id,
        teacherId: m.teacherId,
        name: m.name,
        code: m.code,
        groupName: m.groupName,
        classroom: m.classroom,
        days: m.days,
        startTime: _hhmm(m.startTime),
        endTime: _hhmm(m.endTime),
        studentsCount: m.studentsCount,
      );

  static String _hhmm(String time) {
    return time.length >= 5 ? time.substring(0, 5) : time;
  }
}