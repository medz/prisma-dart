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

Reference scalar(
  String type, {
  required FieldLocation location,
  bool isNullable = false,
  bool isList = false,
}) {
  Reference reference = scalarReferneces[type.toLowerCase()] ??
      _resolvePrismaScalar(type, location);

  // If the type is list, then return a list of the type.
  if (isList) {
    reference = TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'Iterable';
      updates.types.add(reference);
    });
  }

  return isNullable ? reference.nullable : reference;
}

/// Resolve prisma type
Reference _resolvePrismaScalar(String type, FieldLocation location) {
  return refer(
      location == FieldLocation.scalar ? type : type.toDartClassName());
}
