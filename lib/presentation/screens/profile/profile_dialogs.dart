import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';

class ProfileDialogs {
  static void showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar caché'),
        content: const Text(
          'Se liberarán 18,4 MB de datos temporales. ¿Deseas continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Caché eliminada correctamente')),
              );
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }

  static void showHelpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Centro de soporte UACheck',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const ListTile(
              leading: Icon(Icons.email_outlined, color: AppColors.primary),
              title: Text('Correo de soporte'),
              subtitle: Text('soporte.uacheck@uniamazonia.edu.co'),
            ),
            const ListTile(
              leading: Icon(Icons.qr_code_scanner, color: AppColors.primary),
              title: Text('¿Problemas con el QR o GPS?'),
              subtitle: Text(
                'Verifica que tengas el GPS activo o muestra tu carné digital.',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas salir de tu cuenta?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () {
              final container = ProviderScope.containerOf(context);
              context.pop();
              container.read(authProvider.notifier).logout();
              
            },
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }
}
