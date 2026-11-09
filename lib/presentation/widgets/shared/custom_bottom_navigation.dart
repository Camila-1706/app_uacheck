import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: AppColors.textMuted)
        
        ),
        
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              Icon(
                Icons.home_outlined,
              ),
              
          
              ElevatedButton.icon(
                label: Text('Inicio'),
                icon: Icon(Icons.home_outlined),
                 onPressed: () {  },
              ),
          
              ElevatedButton.icon(
                label: Text('Inicio'),
                icon: Icon(Icons.home_outlined),
                 onPressed: () {  },
              ),
          
              ElevatedButton.icon(
                label: Text('Inicio'),
                icon: Icon(Icons.home_outlined),
                 onPressed: () {  },
              )
              
          
          ],
                ),
        ),


    );
  }
}