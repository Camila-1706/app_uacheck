
class AppConstants {
  static const appName = 'UACheck';
  static const universityName = 'Universidad de la Amazonia';
  static const currentSemester = '2026-2';

  /// Solo se permiten correos de este dominio
  static const institutionalDomain = '@udla.edu.co';

  /// Vigencia del QR que muestra el docente
  static const qrCycleSeconds = 180;

  /// Pasados estos minutos desde el inicio de la sesión, se marca "Tarde".
  static const lateAfterMinutes = 15;

  /// El QR del carné del estudiante se renueva cada 30 segundos
  static const studentCardRefreshSeconds = 30;

  static const minPasswordLength = 8;

  /// true  = permite probar la app cualquier día (ignora el día de la clase).
  /// false = solo deja tomar asistencia el día que corresponde al horario.
  static const testMode = true;
}
