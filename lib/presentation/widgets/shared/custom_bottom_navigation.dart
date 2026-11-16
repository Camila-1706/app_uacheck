import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int indexActual;
  final bool isTeacher;

  const CustomBottomNavigation({
    super.key,
    this.indexActual = 0,
    this.isTeacher = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNav(
                context: context,
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Inicio',
              ),
              _buildNav(
                context: context,
                index: 1,
                icon: Icons.menu_book_outlined,
                selectedIcon: Icons.menu_book,
                label: 'Clases',
              ),
              _buildNav(
                context: context,
                index: 2,
                icon: isTeacher
                    ? Icons.bar_chart_outlined
                    : Icons.calendar_today_outlined,
                selectedIcon:
                    isTeacher ? Icons.bar_chart : Icons.calendar_today,
                label: isTeacher ? 'Estadísticas' : 'Historial',
              ),
              _buildNav(
                context: context,
                index: 3,
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNav({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final isSelected = indexActual == index;
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = AppColors.textMuted;

    return GestureDetector(
      onTap: () {
        if (isTeacher) {
          if (index == 0) context.go('/teacher/home');
          if (index == 1) context.go('/teacher/courses');
          if (index == 2) context.go('/teacher/stats');
          if (index == 3) context.go('/teacher/profile');
        } else {
          if (index == 0) context.go('/student/home');
          if (index == 1) context.go('/student/courses');
          if (index == 2) context.go('/student/history');
          if (index == 3) context.go('/student/profile');
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? selectedIcon : icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}