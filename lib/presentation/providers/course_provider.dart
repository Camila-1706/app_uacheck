import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/course.dart';
import 'repository_providers.dart';

/// Lista de materias del docente
/// FutureProvider = guarda 3 estados solitos: cargando, error o datos.
/// autoDispose = cuando sales de la pantalla se descarta y la próxima vez
/// vuelve a consultar, así siempre ves datos frescos.
final teacherCoursesProvider = FutureProvider.autoDispose<List<Course>>((ref) {
  return ref.watch(courseRepositoryProvider).getTeacherCourses();
});