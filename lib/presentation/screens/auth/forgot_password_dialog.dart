import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/constants/app_constants.dart';
import '../../../config/helpers/app_exception.dart';
import '../../../config/helpers/context_extensions.dart';
import '../../../config/helpers/validators.dart';
import '../../providers/providers.dart';

Future<void> showForgotPasswordDialog(BuildContext context, WidgetRef ref) async {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  final email = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Recuperar contraseña'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.institutionalEmail,
          decoration: InputDecoration(hintText: 'nombre${AppConstants.institutionalDomain}'),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) Navigator.pop(ctx, controller.text);
          },
          child: const Text('Enviar'),
        ),
      ],
    ),
  );
  if (email == null || !context.mounted) return;

  try {
    await ref.read(authProvider.notifier).resetPassword(email);
    if (context.mounted) {
      context.showMessage('Te enviamos un correo para restablecer tu contraseña');
    }
  } catch (e) {
    if (context.mounted) context.showMessage(AppException.messageOf(e), error: true);
  }
}
