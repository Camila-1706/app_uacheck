// ignore_for_file: use_null_aware_elements

import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    this.onBackTap,
    this.trailing,
    this.showBackButton = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(border: Border.all(color: AppColors.success)),
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

            Image.asset('assets/images/logo_icon.png', width: 50, height: 50),
            Text(
              'UaCheck',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(flex: 1),
            if (title != null && title!.isNotEmpty)
              Text(
                title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
