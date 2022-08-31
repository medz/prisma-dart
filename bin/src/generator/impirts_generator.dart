const Map<String, String> _imports = <String, String>{
  // 'convert': 'dart:convert',
  'runtime': 'package:orm/orm.dart',
  // 'generator_helper': 'package:orm/generator_helper.dart',
  // 'json_annotation': 'package:json_annotation/json_annotation.dart',
};

Future<String> importsGenerator() async {
  final StringBuffer imports = StringBuffer();
  for (final String alias in _imports.keys) {
    imports.writeln('import \'${_imports[alias]}\' as $alias;');
  }

  return imports.toString();
}
