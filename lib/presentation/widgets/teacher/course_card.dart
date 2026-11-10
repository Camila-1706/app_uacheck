import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final String schedule;
  final String classroom;
  final int studentsCount;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.schedule,
    required this.classroom,
    required this.studentsCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryOnDark,
                  borderRadius: BorderRadius.circular(8.0)
                  ),
                child: Icon(Icons.menu_book_rounded),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(code, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
          SizedBox(height: 12,),
          Row(children: [
            Row(children: [
              Icon(Icons.watch_later_outlined, ),
              Text(schedule),
            ],),
            Spacer(flex: 1,),
            Row(children: [
              Icon(Icons.home_outlined),
              Text(classroom),
            ],),
            Spacer(flex: 1,),
            Row(children: [
              Icon((Icons.person_outline)),
              Text('$studentsCount')
            ],)

          ],)
        ],
      ),
    );
  }
}
