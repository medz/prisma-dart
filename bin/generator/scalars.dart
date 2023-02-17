import 'package:code_builder/code_builder.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

import 'packages.dart' as packages;
import 'utils.dart';

final Map<String, Reference> scalarReferneces = {
  'string': refer('String'),
  'float': refer('double'),
  'decimal': refer('double'),
  'int': refer('int'),
  'bigint': refer('BigInt'),
  'boolean': refer('bool'),
  'json': refer('dynamic'),
  'bytes': TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = 'List';
    updates.types.add(Reference('int'));
  }),
  'unsupported': refer('dynamic'),
  'null': refer('PrismaNull', packages.orm),
  'datetime': refer('DateTime'),
  'date': refer('DateTime'),
}.map((key, value) => MapEntry(key.toLowerCase(), value));

Reference scalar(SchemaType schemaType, [bool isNullable = false]) {
  final String type = schemaType.type.toLowerCase();
  Reference reference =
      scalarReferneces[type] ?? _resolvePrismaScalar(schemaType);

  // If the type is list, then return a list of the type.
  if (schemaType.isList) {
    reference = TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'Iterable';
      updates.types.add(reference);
    });
  }

  return isNullable ? reference.nullable : reference;
}

/// Resolve prisma type
Reference _resolvePrismaScalar(SchemaType schemaType) {
  String symbol = schemaType.type;
  if (schemaType.location != FieldLocation.scalar) {
    symbol = symbol.toDartClassname();
  }

  return refer(symbol);
}
