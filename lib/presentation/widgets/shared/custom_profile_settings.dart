import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProfileSettings extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onDarkModeChanged;
  final VoidCallback? onClearCache;
  final VoidCallback? onHelp;
  final VoidCallback? onLogout;

  const CustomProfileSettings({
    super.key,
    this.isDarkMode = false,
    this.onDarkModeChanged,
    this.onClearCache,
    this.onHelp,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            context: context,
            icon: Icons.nightlight_round,
            title: 'Modo oscuro',
            subtitle: isDarkMode ? 'Activado' : 'Desactivado',
            trailing: Switch(
              value: isDarkMode,
              onChanged: onDarkModeChanged ?? (value) {},
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildOptionTile(
            context: context,
            icon: Icons.delete_outline,
            title: 'Borrar caché',
            subtitle: '18,4 MB',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
            ),
            onTap: onClearCache,
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildOptionTile(
            context: context,
            icon: Icons.help_outline,
            title: 'Ayuda',
            subtitle: 'Centro de soporte',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
            ),
            onTap: onHelp,
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildOptionTile(
            context: context,
            icon: Icons.logout,
            title: 'Cerrar sesión',
            isDanger: true,
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDanger = false,
  }) {
    final colorPrincipal =
        isDanger ? AppColors.danger : Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isDanger ? AppColors.dangerSoft : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isDanger ? Colors.transparent : AppColors.successSoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: colorPrincipal, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDanger
                          ? AppColors.danger
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}