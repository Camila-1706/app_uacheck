import 'dart:convert';

import '../../domain/entities/imported_student.dart';
import 'app_exception.dart';
import 'validators.dart';

// Lo que sale de leer el archivo: los estudiantes válidos y los problemas
// encontrados (para mostrárselos al docente).
class StudentImportResult {
  final String fileName;
  final List<ImportedStudent> students;
  final List<String> problems;

  const StudentImportResult({
    required this.fileName,
    required this.students,
    required this.problems,
  });
}

class CsvHelper {
  static const maxRows = 500;

  static String decodeBytes(List<int> bytes) {
    try {
      return utf8.decode(bytes);
    } on FormatException {
      return latin1.decode(bytes);
    }
  }
  static StudentImportResult parseStudents(String content, String fileName) {

    final lines = content.replaceAll('\uFEFF', '').split(RegExp(r'\r\n|\r|\n'));

    final headerIndex = lines.indexWhere((line) => line.trim().isNotEmpty);
    if (headerIndex == -1) {
      throw const AppException('El archivo está vacío.');
    }

    final delimiter = _detectDelimiter(lines[headerIndex]);
    final headers = _splitLine(lines[headerIndex], delimiter)
        .map(_normalize)
        .toList();

    // Buscamos las columnas por el NOMBRE del encabezado, no por posición
    final codeCol = headers.indexWhere((h) => h.contains('codigo'));
    final nameCol = headers.indexWhere((h) => h.contains('nombre'));

    if (codeCol == -1) {
      throw const AppException(
        'No encontré la columna del código. La primera fila debe ser el '
        'encabezado y alguna columna debe llamarse "codigo" '
        '(por ejemplo CODIGOESTUDIANTE).',
      );
    }

    final dataRows = lines
        .skip(headerIndex + 1)
        .where((line) => line.trim().isNotEmpty)
        .length;
    if (dataRows > maxRows) {
      throw AppException(
        'El archivo tiene $dataRows filas y el máximo es $maxRows.',
      );
    }

    // Revisa fila por fila
    final students = <ImportedStudent>[];
    final problems = <String>[];
    final seenCodes = <String>{}; 

    for (var i = headerIndex + 1; i < lines.length; i++) {
      if (lines[i].trim().isEmpty) continue; // salta filas en blanco

      final rowNumber = i + 1; 
      final cells = _splitLine(lines[i], delimiter);

      final code = codeCol < cells.length ? cells[codeCol] : '';
      var name = '';
      if (nameCol != -1 && nameCol < cells.length) {
        name = cells[nameCol].replaceAll(RegExp(r'\s+'), ' ');
      }

      if (code.isEmpty) {
        problems.add('Fila $rowNumber: no tiene código.');
        continue;
      }
      if (Validators.userCode(code) != null) {
        problems.add(
          'Fila $rowNumber: el código "$code" no es válido '
          '(solo números, de 6 a 15 dígitos).',
        );
        continue;
      }
      // add() devuelve false si el código ya estaba en el Set
      if (!seenCodes.add(code)) {
        problems.add('Fila $rowNumber: el código $code está repetido.');
        continue;
      }

      students.add(ImportedStudent(code: code, name: name));
    }

    return StudentImportResult(
      fileName: fileName,
      students: students,
      problems: problems,
    );
  }

  static String _detectDelimiter(String headerLine) {
    var best = ',';
    var bestCount = 0;
    for (final delimiter in [',', ';', '\t']) {
      final count = delimiter.allMatches(headerLine).length;
      if (count > bestCount) {
        best = delimiter;
        bestCount = count;
      }
    }
    return best;
  }


  static List<String> _splitLine(String line, String delimiter) {
    final cells = <String>[];
    final current = StringBuffer();
    var insideQuotes = false;

    for (var i = 0; i < line.length; i++) {
      final char = line[i];
      if (char == '"') {
        insideQuotes = !insideQuotes; 
      } else if (char == delimiter && !insideQuotes) {
        cells.add(current.toString().trim());
        current.clear();
      } else {
        current.write(char);
      }
    }
    cells.add(current.toString().trim()); 
    return cells;
  }


  static String _normalize(String text) {
    const withAccent = 'áéíóúüñ';
    const without = 'aeiouun';
    var result = text.toLowerCase().trim();
    for (var i = 0; i < withAccent.length; i++) {
      result = result.replaceAll(withAccent[i], without[i]);
    }
    return result;
  }
}