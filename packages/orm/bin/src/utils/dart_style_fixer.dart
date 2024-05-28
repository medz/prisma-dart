import 'package:recase/recase.dart';

const _dartReservedProperties = <String>{
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

const prismaReservedpProperties = <String>{'AND', 'OR', 'NOT'};

extension DartStyleFixer on String {
  /// Returns dart class name string.
  String get className => pascalCase._publicName;

  /// Returns dart property name string.
  String get propertyName {
    if (prismaReservedpProperties.contains(this)) return this;
    if (_dartReservedProperties.contains(toLowerCase())) {
      return '\$$this'.camelCase;
    }

    return _publicName.camelCase;
  }

  String get _publicName {
    if (startsWith('_')) {
      return r'$' + substring(1);
    }

    return this;
  }
}
