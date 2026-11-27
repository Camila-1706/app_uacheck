// Resultado de matricular estudiantes en una materia.
class EnrollResult {
  final int added;   // estudiantes nuevos en la materia
  final int updated; // ya estaban matriculados

  const EnrollResult({required this.added, required this.updated});

  int get total => added + updated;
}