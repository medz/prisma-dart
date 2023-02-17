import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';

extension DartClassname on String {
  /// Dart property reserved keywords
  static final Iterable<String> _reservedKeywords = [
    'in',
    'for',
    'const',
    'final',
    'class',
    'call',
    'if',
    'else',
    'enum',
    'assert',
    'super',
    'extends',
    'is',
    'switch',
    'break',
    'this',
    'true',
    'false',
    'new',
    'class',
    'null',
    'try',
    'case',
    'finally',
    'continue',
    'var',
    'void',
    'default',
    'while',
    'rethrow',
    'do',
    'return',
  ].map((e) => e.toLowerCase());

  /// Prisma where reversed keywords
  static final Iterable<String> _whereReservedKeywords = [
    'and',
    'or',
    'not',
  ].map((e) => e.toUpperCase());

  /// Convert to dart class name
  String toDartClassname() => toDartPropertyName().pascalCase;

  /// Convert to dart property name
  String toDartPropertyName() {
    if (_whereReservedKeywords.contains(this)) {
      return this;
    }

    return withoutDartReserved().toDartPublicName().camelCase;
  }

  /// Fix dart reserved keyword
  String withoutDartReserved() {
    if (_reservedKeywords.contains(toLowerCase())) {
      return r'$' + this;
    }

    return this;
  }

  /// To dart public property/class name
  String toDartPublicName() {
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
