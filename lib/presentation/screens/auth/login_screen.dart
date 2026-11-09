import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_uacheck_1/config/theme/app_colors.dart';
import 'package:app_uacheck_1/presentation/providers/providers.dart';
import 'package:app_uacheck_1/presentation/widgets/shared/custom_app_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    // El rol que la persona eligió en la pantalla de bienvenida
    final role = ref.read(selectedRoleProvider);

    // Si por alguna razón no eligió rol, la devolvemos al inicio
    if (role == null) {
      context.go('/');
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text, role);

    if (!success && mounted) {
      final errorMessage =
          ref.read(authProvider).error ?? 'Error al iniciar sesión';
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
              const CustomAppBar(title: 'Iniciar sesión'),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successSoft,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        'PORTAL INSTITUCIONAL',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    const Text(
                      'Bienvenido de nuevo',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6.0),

                    const Text(
                      'Ingresa con las credenciales asignadas por la Universidad de la Amazonia.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 28.0),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Campo Correo
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Ingresa tu correo institucional';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'nombre@uniamazonia.edu.co',
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

                          const SizedBox(height: 20.0),

                          // Campo Contraseña
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu contraseña';
                              }
                              return null;
                            },
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

                          const SizedBox(height: 12.0),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28.0),

                          ElevatedButton.icon(
                            onPressed: isLoading ? null : _submitLogin,
                            icon: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.login, size: 20.0),
                            label: Text(
                              isLoading ? 'Cargando...' : 'Iniciar sesión',
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

                          const SizedBox(height: 32.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '¿Primera vez aquí? ',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 14.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push('/register'),
                                child: const Text(
                                  'Regístrate',
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
