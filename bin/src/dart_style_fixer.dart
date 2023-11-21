import 'package:recase/recase.dart';

const reserved = <String>{
  'is',
  'throw',
  'if',
  'case',
  'for',
  'else',
  'class',
  'final',
  'var',
  'const',
  'void',
  'null',
  'default',
};

extension DartClassNameStyleFixer on String {
  String toDartClassNameString() {
    return pascalCase..fixStartsWithUnderline();
  }

  String toDartPropertyNameString() {
    final propertyName = camelCase;
    if (reserved.contains(propertyName.toLowerCase())) {
      return '\$$propertyName';
    }

    return propertyName.fixStartsWithUnderline();
  }

  String fixStartsWithUnderline() {
    if (startsWith('_')) {
      return r'$' + substring(1);
    }

    return this;
  }
}
