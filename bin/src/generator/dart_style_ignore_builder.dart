final List<String> _dartStyleIgnore = [
  'non_constant_identifier_names',
  'prefer_void_to_null',
];

String dartStyleIgnoreBuilder() {
  final StringBuffer code = StringBuffer();
  code.write('// ignore_for_file: ');
  code.writeln(_dartStyleIgnore.join(', '));

  return code.toString();
}
