final List<String> _dartStyleIgnore = [
  'non_constant_identifier_names',
  'constant_identifier_names',
  'camel_case_types',
  'depend_on_referenced_packages',
]..sort();

String dartStyleIgnoreBuilder() {
  final StringBuffer code = StringBuffer();
  code.write('// ignore_for_file: ');
  code.writeln(_dartStyleIgnore.join(', '));

  return code.toString();
}
