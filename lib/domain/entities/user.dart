
enum UserRole { teacher, student }

class AppUser {
  final String id;
  final String fullName;
  final String code;
  final String email;
  final UserRole role;
  final String program;
  final String campus;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.code,
    required this.email,
    required this.role,
    required this.program,
    required this.campus,
  });

  bool get isTeacher => role == UserRole.teacher;

  String get firstName => fullName.trim().split(' ').first;

    String get initials {
    final words = fullName.trim().split(RegExp(r'\s+'));
    final first = words.first.isEmpty ? '?' : words.first[0];
    final second = words.length > 1 ? words[1][0] : '';
    return (first + second).toUpperCase();
  }
}
