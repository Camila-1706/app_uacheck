import '../constants/app_constants.dart';

/// Validaciones de formularios. Devuelven el mensaje de error o null si es válido.
class Validators {
  static String? required(String? value, [String field = 'Este campo']) {
    if (value == null || value.trim().isEmpty) return '$field es obligatorio';
    return null;
  }

  static String? fullName(String? value) {
    final error = required(value, 'El nombre');
    if (error != null) return error;
    final words = value!.trim().split(RegExp(r'\s+'));
    if (words.length < 2) return 'Escribe tu nombre y apellido';
    if (RegExp(r'[0-9]').hasMatch(value)) return 'El nombre no puede tener números';
    return null;
  }

  /// Código estudiantil o docente: solo números (6 a 15)
  static String? userCode(String? value) {
    final error = required(value, 'El código');
    if (error != null) return error;
    if (!RegExp(r'^[0-9]{6,15}$').hasMatch(value!.trim())) {
      return 'Solo números (entre 6 y 15 dígitos)';
    }
    return null;
  }

  static String? institutionalEmail(String? value) {
    final error = required(value, 'El correo');
    if (error != null) return error;
    final email = value!.trim().toLowerCase();
    if (!RegExp(r'^[\w.\-+]+@[\w\-]+(\.[\w\-]+)+$').hasMatch(email)) {
      return 'Correo no válido';
    }
    if (!email.endsWith(AppConstants.institutionalDomain)) {
      return 'Usa tu correo ${AppConstants.institutionalDomain}';
    }
    return null;
  }

  /// Para iniciar sesión solo se exige que no esté vacía
  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    return null;
  }

  /// Para registrarse: mínimo 8 caracteres, con letras y números
  static String? newPassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < AppConstants.minPasswordLength) {
      return 'Mínimo ${AppConstants.minPasswordLength} caracteres';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Debe combinar letras y números';
    }
    return null;
  }

  static String? group(String? value) {
    final error = required(value, 'El grupo');
    if (error != null) return error;
    if (value!.trim().length > 10) return 'Máximo 10 caracteres';
    return null;
  }

  /// Hora en formato HH:mm -> minutos desde medianoche.
  static int toMinutes(String hhmm) {
    final parts = hhmm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  static String? timeRange(String start, String end) {
    if (toMinutes(end) <= toMinutes(start)) {
      return 'La hora de fin debe ser posterior a la de inicio';
    }
    return null;
  }
}
