
class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;

  /// Convierte cualquier error en un texto amigable
  static String messageOf(Object error) {
    if (error is AppException) return error.message;
    return 'Ocurrió un error inesperado. Intenta de nuevo.';
  }
}
