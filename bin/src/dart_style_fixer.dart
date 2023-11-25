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
  'in',
};

const prismaReserved = <String>{
  'AND',
  'OR',
  'NOT',
};

extension DartClassNameStyleFixer on String {
  String toDartClassNameString() {
    return pascalCase..fixStartsWithUnderline();
  }

  String toDartPropertyNameString() {
    if (prismaReserved.contains(this)) return this;

    final propertyName = camelCase;
    if (reserved.contains(propertyName.toLowerCase()) || startsWith('_')) {
      if (propertyName.startsWith('_')) {
        return propertyName.fixStartsWithUnderline();
      }

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
