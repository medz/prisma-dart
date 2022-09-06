import 'dart:io';

/// Creates key-value pairs from strings formatted as environment
/// variable definitions.
class ParserEnv {
  Map<String, String> getVars(File fileEnv) {
    final envText = fileEnv.readAsStringSync();
    final localMap = <String, String>{};
    for (var line in envText.split('\n')) {
      line = line.replaceFirst(RegExp(r'\#.*'), '');
      line = line.trim();
      if (line.isEmpty) continue;
      final key = line.split('=').first;

      line = line
          .replaceFirst('$key=', '')
          .replaceAll('"', '')
          .replaceAll("'", '');
      localMap[key.trim()] = line.trim();
    }
    return localMap;
  }
}
