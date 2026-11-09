import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/domain/entities/user.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _codeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitRegister() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final selectedRole = ref.read(selectedRoleProvider) ?? UserRole.student;

    final success = await ref
        .read(authProvider.notifier)
        .register(
          fullName: _fullNameController.text.trim(),
          code: _codeController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          role: selectedRole,
        );

    if (!success && mounted) {
      final errorMessage =
          ref.read(authProvider).error ?? 'Error al registrarse';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.loading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(title: 'Registro'),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Únete a UACheck',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Usa tus datos oficiales. Verificaremos tu correo institucional.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nombre completo',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _fullNameController,
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'Ingresa tu nombre completo'
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Valentina Rodríguez Mora',
                              hintStyle: const TextStyle(
                                color: AppColors.textMuted,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: AppColors.textMuted,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18.0),

                          const Text(
                            'Código estudiantil o docente',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _codeController,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'Ingresa tu código institucional'
                                : null,
                            decoration: InputDecoration(
                              hintText: '20231248017',
                              hintStyle: const TextStyle(
                                color: AppColors.textMuted,
                              ),
                              prefixIcon: const Icon(
                                Icons.badge_outlined,
                                color: AppColors.textMuted,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18.0),

                          const Text(
                            'Correo institucional',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'Ingresa tu correo institucional'
                                : null,
                            decoration: InputDecoration(
                              hintText: 'v.rodriguez@uniamazonia.edu.co',
                              hintStyle: const TextStyle(
                                color: AppColors.textMuted,
                              ),
                              prefixIcon: const Icon(
                                Icons.mail_outline,
                                color: AppColors.textMuted,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18.0),

                          const Text(
                            'Contraseña',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) =>
                                (value == null || value.length < 6)
                                ? 'La contraseña debe tener al menos 6 caracteres'
                                : null,
                            decoration: InputDecoration(
                              hintText: '••••••••••',
                              hintStyle: const TextStyle(
                                color: AppColors.textMuted,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: AppColors.textMuted,
                              ),
                              suffixIcon: const Icon(
                                Icons.visibility_off_outlined,
                                color: AppColors.textMuted,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28.0),

                          ElevatedButton.icon(
                            onPressed: isLoading ? null : _submitRegister,
                            icon: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person_add_alt_1_outlined,
                                    size: 20.0,
                                  ),
                            label: Text(
                              isLoading ? 'Registrando...' : 'Registrarse',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50.0),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '¿Ya tienes cuenta? ',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 14.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push('/login'),
                                child: const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
