import '../../domain/entities/user.dart';
import '../models/user_model.dart';

/// Convierte entre UserModel (base de datos) y AppUser (dominio).
class UserMapper {
  static AppUser toEntity(UserModel m) => AppUser(
        id: m.id,
        fullName: m.fullName,
        code: m.code,
        email: m.email,
        role: m.role == 'teacher' ? UserRole.teacher : UserRole.student,
        program: m.program,
        campus: m.campus,
      );

  static UserModel toModel(AppUser u) => UserModel(
        id: u.id,
        fullName: u.fullName,
        code: u.code,
        email: u.email,
        role: u.role == UserRole.teacher ? 'teacher' : 'student',
        program: u.program,
        campus: u.campus,
      );
}
