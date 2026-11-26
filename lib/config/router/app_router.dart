import 'package:app_uacheck_1/presentation/screens/auth/login_screen.dart';
import 'package:app_uacheck_1/presentation/screens/auth/register_screen.dart';
import 'package:app_uacheck_1/presentation/screens/auth/welcome_screen.dart';
import 'package:app_uacheck_1/presentation/screens/home/home_student_screen.dart';
import 'package:app_uacheck_1/presentation/screens/home/home_teacher_screen.dart';
import 'package:app_uacheck_1/presentation/screens/profile/profile_teacher_screen.dart';
import 'package:app_uacheck_1/presentation/screens/student/scan_qr_screen.dart';
import 'package:app_uacheck_1/presentation/screens/student/student_courses_screen.dart';
import 'package:app_uacheck_1/presentation/screens/student/student_history_screen.dart';
import 'package:app_uacheck_1/presentation/screens/profile/profile_student_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/add_course_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/course_detail_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/course_stats_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/generate_qr_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/live_session_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/student_list_screen.dart';
import 'package:app_uacheck_1/presentation/screens/teacher/teacher_courses_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);

  ref.listen(authProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/welcome',
    refreshListenable: refresh,
    redirect: (context, state) {
      final user = ref.read(authProvider).user;
      final location = state.matchedLocation;

      const publicRoutes = ['/welcome', '/login', '/register'];
      final isPublic = publicRoutes.contains(location);

      if (user == null) return isPublic ? null : '/welcome';

      if (isPublic) {
        return user.isTeacher ? '/teacher/home' : '/student/home';
      }

      if (user.isTeacher && location.startsWith('/student')) {
        return '/teacher/home';
      }
      if (!user.isTeacher && location.startsWith('/teacher')) {
        return '/student/home';
      }

      return null;
    },
    routes: [
      //AUTH
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      //DOCENTE
      GoRoute(
        path: '/teacher/home',
        builder: (context, state) => const HomeTeacherScreen(),
      ),
      GoRoute(
        path: '/teacher/courses',
        builder: (context, state) => const TeacherCoursesScreen(),
      ),
      GoRoute(
        path: '/teacher/add-course',
        builder: (context, state) => const AddCourseScreen(),
      ),
      GoRoute(
        path: '/teacher/course-detail',
        builder: (context, state) => const CourseDetailScreen(),
      ),
      GoRoute(
        path: '/teacher/generate-qr',
        builder: (context, state) => const GenerateQrScreen(),
      ),
      GoRoute(
        path: '/teacher/live-session',
        builder: (context, state) => const LiveSessionScreen(),
      ),
      GoRoute(
        path: '/teacher/student-list',
        builder: (context, state) => const StudentListScreen(),
      ),
      GoRoute(
        path: '/teacher/stats',
        builder: (context, state) => const CourseStatsScreen(),
      ),
      GoRoute(
        path: '/teacher/profile',
        builder: (context, state) => const ProfileTeacherScreen(),
      ),

      //ESTUDIANTE
      GoRoute(
        path: '/student/home',
        builder: (context, state) => const HomeStudentScreen(),
      ),
      GoRoute(
        path: '/student/courses',
        builder: (context, state) => const StudentCoursesScreen(),
      ),
      GoRoute(
        path: '/student/scan-qr',
        builder: (context, state) => const ScanQrScreen(),
      ),
      GoRoute(
        path: '/student/history',
        builder: (context, state) => const StudentHistoryScreen(),
      ),
      GoRoute(
        path: '/student/profile',
        builder: (context, state) => const ProfileStudentScreen(),
      ),
    ],
  );
});
