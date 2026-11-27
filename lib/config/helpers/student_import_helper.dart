import 'package:file_picker/file_picker.dart';

import 'app_exception.dart';
import 'csv_helper.dart';

class StudentImportHelper {
  static const _maxFileBytes = 2 * 1024 * 1024; // 2 MB

  // Devuelve null si el usuario cancela el selector
  static Future<StudentImportResult?> pickAndParse() async {
    PlatformFile? pickedFile;

    try {
      pickedFile = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['csv', 'txt', 'xls', 'xlsx'],
      );
    } catch (_) {
      throw const AppException('No se pudo abrir el selector de archivos.');
    }

    if (pickedFile == null) return null;

    // Dejo elegir Excel solo para explicarle q hacer
    final fileName = pickedFile.name.toLowerCase();
    if (fileName.endsWith('.xls') || fileName.endsWith('.xlsx')) {
      throw const AppException(
        'Los archivos de Excel no se pueden leer directamente. Ábrelo en '
        'Excel, usa "Guardar como" → "CSV UTF-8 (delimitado por comas)" y '
        'sube ese archivo.',
      );
    }

    List<int> fileBytes;
    try {
      fileBytes = await pickedFile.readAsBytes();
    } catch (_) {
      throw const AppException('No se pudo leer el archivo. Intenta de nuevo.');
    }

    if (fileBytes.isEmpty) {
      throw const AppException('El archivo está vacío.');
    }
    if (fileBytes.length > _maxFileBytes) {
      throw const AppException('El archivo es muy grande (máximo 2 MB).');
    }

    final fileContent = CsvHelper.decodeBytes(fileBytes);
    final importResult = CsvHelper.parseStudents(fileContent, pickedFile.name);

    if (importResult.students.isEmpty) {
      final firstProblem = importResult.problems.isEmpty
          ? ''
          : ' ${importResult.problems.first}';
      throw AppException('No encontré ningún estudiante válido.$firstProblem');
    }

    return importResult;
  }
}
