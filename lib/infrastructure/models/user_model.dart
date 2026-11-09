class UserModel {
  final String id;
  final String fullName;
  final String code;
  final String email;
  final String role;
  final String program;
  final String campus;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.code,
    required this.email,
    required this.role,
    required this.program,
    required this.campus,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) => UserModel(
        id: id,
        fullName: map['full_name'] as String,
        code: map['code'] as String,
        email: map['email'] as String,
        role: map['role'] as String,
        program: map['program'] as String? ?? '',
        campus: map['campus'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
        'full_name': fullName,
        'code': code,
        'email': email,
        'role': role,
        'program': program,
        'campus': campus,
      };
}
