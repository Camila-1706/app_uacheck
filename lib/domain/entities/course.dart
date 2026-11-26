
class Course {
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

  const Course({
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

  static const _dayNames = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];


  String get title => '$name - $groupName';

  String get scheduleText {
    final names = days.map((d) => _dayNames[d - 1]).join('/');
    return '$names $startTime';
  }
}