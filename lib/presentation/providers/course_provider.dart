import 'package:app_uacheck_1/domain/entities/enrolled_student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/course.dart';
import 'repository_providers.dart';

// Lista de materias del docente
// FutureProvider = guarda 3 estados solitos: cargando, error o datos.
// autoDispose = cuando sale de la pantalla se descarta y la proxima vez
// vuelve a consultar, asi siempre se ven datos frescos.
final teacherCoursesProvider = FutureProvider.autoDispose<List<Course>>((ref) {
  return ref.watch(courseRepositoryProvider).getTeacherCourses();
});

// .family = un provider que recibe un parametro
final courseStudentsProvider = FutureProvider.autoDispose
    .family<List<EnrolledStudent>, String>((ref, courseId) {
      return ref.watch(courseRepositoryProvider).getCourseStudents(courseId);
    }); 