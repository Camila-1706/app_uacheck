class CourseModel {
  final String id;
  final String teacherId;
  final String name;
  final String code;
  final String groupName;
  final String classroom;
  final List<int> days;
  final String startTime;
  final String endTime;
  final int studentsCount;

  const CourseModel({
    required this.id,
    required this.teacherId,
    required this.name,
    required this.code,
    required this.groupName,
    required this.classroom,
    required this.days,
    required this.startTime,
    required this.endTime,
    required this.studentsCount,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    // Cuando pedimos 'enrollments(count)', Supabase responde: [{count: 3}]
    int count = 0;
    final enrollments = map['enrollments'];
    if (enrollments is List && enrollments.isNotEmpty) {
      count = enrollments.first['count'] as int;
    }

    return CourseModel(
      id: map['id'] as String,
      teacherId: map['teacher_id'] as String,
      name: map['name'] as String,
      code: map['code'] as String? ?? '',
      groupName: map['group_name'] as String,
      classroom: map['classroom'] as String? ?? '',
      days: List<int>.from(map['days'] as List),
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      studentsCount: count,
    );
  }
}