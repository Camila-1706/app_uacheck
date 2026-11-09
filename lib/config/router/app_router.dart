import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/welcome_screen.dart';
import '../../presentation/screens/home/home_student_screen.dart';
import '../../presentation/screens/home/home_teacher_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authProvider.select((s) => s.user), (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final user = ref.read(authProvider).user;
      final path = state.matchedLocation;
      final isAuth = path == '/' || path == '/login' || path == '/register';

      if (user == null) return isAuth ? null : '/';
      if (isAuth) return user.isTeacher ? '/teacher' : '/student';
      if (user.isTeacher && path.startsWith('/student')) return '/teacher';
      if (!user.isTeacher && path.startsWith('/teacher')) return '/student';
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/teacher',
        builder: (context, state) => const HomeTeacherScreen(),
      ),
      GoRoute(
        path: '/student',
        builder: (context, state) => const HomeStudentScreen(),
      ),
    ],
  );
});