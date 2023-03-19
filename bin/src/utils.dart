import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart' show visibleForTesting;
import 'package:recase/recase.dart';
import 'package:analyzer/dart/ast/token.dart' show Keyword;

extension DartStyleName on String {
  /// These Dart reserved keywords are not allowed as field names
  @visibleForTesting
  static final Iterable<String> dartReservedPropertyKeywords = Keyword.values
      .where((element) => element.isReservedWord)
      .map((e) => e.lexeme.toLowerCase());

  /// Prisma where reversed keywords
  @visibleForTesting
  static const Iterable<String> prismaWhereReservedKeywords = [
    'and',
    'or',
    'not',
  ];

  /// Convert to dart class name
  String toDartClassName() => _toDartPublicName().pascalCase;

  /// Convert to dart property name
  String toDartPropertyName() {
    if (prismaWhereReservedKeywords
        .map((e) => e.toUpperCase())
        .contains(this)) {
      return this;
    }

    final property = _toDartPublicName().camelCase;
    if (dartReservedPropertyKeywords.contains(property.toLowerCase())) {
      return r'$' + property;
    }

    return property;
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
