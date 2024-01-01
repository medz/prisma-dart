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

const _prismaReservedpProperties = <String>{'AND', 'OR', 'NOT'};

extension DartStyleFixer on String {
  /// Returns dart class name string.
  String get className {
    return pascalCase._publicName;
  }

  /// Returns dart property name string.
  String get propertyName {
    if (_prismaReservedpProperties.contains(this)) return this;

    final propertyName = camelCase;
    if (_dartReservedProperties.contains(propertyName.toLowerCase())) {
      return '\$$propertyName';
    }

    return propertyName._publicName;
  }

  String get _publicName {
    if (startsWith('_')) {
      return r'$' + substring(1);
    }

    return this;
  }
}
