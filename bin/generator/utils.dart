import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart' show visibleForTesting;
import 'package:recase/recase.dart';

extension DartStyleName on String {
  /// Convert to dart class name
  String toDartClassName() {
    if (whereReservedKeywords.map((e) => e.toUpperCase()).contains(this)) {
      return pascalCase;
    }
    if (reservedClassKeywords.contains(toLowerCase())) {
      return r'$' + pascalCase;
    }
    return _toDartPublicName().pascalCase;
  }

  /// Convert to dart property name
  String toDartPropertyName() {
    if (whereReservedKeywords.map((e) => e.toUpperCase()).contains(this)) {
      return this;
    }
    if (reservedPropertyKeywords.contains(toLowerCase())) {
      return r'$' + camelCase;
    }
    return _toDartPublicName().camelCase;
  }

  /// To dart public property/class name
  String _toDartPublicName() {
    if (startsWith('_')) {
      return r'$' + substring(1);
    }

    return this;
  }
}

/// Nullable Reference
extension NullableReferenceExtension on Reference {
  /// Nullable reference
  Reference get nullable => TypeReference((TypeReferenceBuilder updates) {
        updates.symbol = symbol;
        updates.url = url;
        updates.isNullable = true;

        if (this is TypeReference) {
          updates.types.addAll((this as TypeReference).types);
        }
      });
}

/// Prisma where reversed keywords
@visibleForTesting
const Iterable<String> whereReservedKeywords = [
  'and',
  'or',
  'not',
];

/// These Dart reserved keywords are not allowed as field names
@visibleForTesting
const Iterable<String> reservedPropertyKeywords = [
  'abstract',
  'as',
  'async',
  'await',
  'covariant',
  'deferred',
  'dynamic',
  'export',
  'extension',
  'external',
  'factory',
  'function',
  'get',
  'hide',
  'in',
  'implements',
  'import',
  'interface',
  'late',
  'library',
  'mixin',
  'on',
  'operator',
  'part',
  'required',
  'set',
  'show',
  'static',
  'sync',
  'typedef',
  'yield',
];

/// These Dart reserved keywords are not allowed as class or type names
@visibleForTesting
const Iterable<String> reservedClassKeywords = [
  'abstract',
  'as',
  'assert',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'function',
  'get',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'set',
  'static',
  'super',
  'switch',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'while',
  'with',
];
