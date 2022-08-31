const Map<String, String> _imports = <String, String>{
  'runtime': 'package:orm/orm.dart',
  'dmmf': 'package:orm/dmmf.dart',
};

Future<String> importsGenerator() async {
  final StringBuffer imports = StringBuffer();
  for (final String alias in _imports.keys) {
    imports.writeln('import \'${_imports[alias]}\' as $alias;');
  }

  return imports.toString();
}
