import 'package:app_uacheck_1/config/router/app_router.dart';
import 'package:app_uacheck_1/presentation/screens/home/home_student_screen.dart';
import 'package:app_uacheck_1/presentation/widgets/student/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/constants/app_constants.dart';
import 'config/theme/app_theme.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeStudentScreen()
    );
  }
}


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Supabase.initialize(
//     url: 'https://ddtdxnjhsupgvorgdemw.supabase.co',
//     publishableKey: 'sb_publishable_Yrz6YCYvPrG87lJNT_YihA_ve2Crnmc',
//   );
//   runApp(const ProviderScope(child: UACheckApp()));
// }

// class UACheckApp extends ConsumerWidget {
//   const UACheckApp({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp.router(
//       title: AppConstants.appName,
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.light,
//       routerConfig: ref.watch(routerProvider),
//     );
//   }
// }
