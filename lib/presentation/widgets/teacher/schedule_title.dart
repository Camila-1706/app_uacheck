import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ScheduleTitle extends StatelessWidget {
  final String time;
  final String period;
  final String nombreAsignatura;
  final String location;

  const ScheduleTitle({
    super.key,
    required this.time,
    required this.period,
    required this.nombreAsignatura,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(bottom: BorderSide(color: AppColors.primaryDark)),
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(children: [
              Text(time),
              Text(period),
            ],),
            SizedBox(width: 8,),
            Column(children: [
              Text(nombreAsignatura),
              Text(location),
            ],)
        ],),

        
        ),
    );
  }
}
