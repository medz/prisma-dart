import 'package:code_builder/code_builder.dart';
import 'package:orm/prisma_generator_helper/dmmf.dart';

import 'packages.dart' as packages;
import 'utils.dart';

/// This map is used to convert a Prisma schema type to a Dart type.
final Map<String, Reference> scalarReferences = {
  // Prisma schema types
  'string': refer('String'),
  'float': refer('double'),
  'decimal': refer('double'),
  'int': refer('int'),
  'bigint': refer('BigInt'),
  'boolean': refer('bool'),
  'json': refer('Object'),
  'bytes': TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = 'List';
    updates.types.add(Reference('int'));
  }),
  'unsupported': refer('dynamic'),
  'null': refer('PrismaNull', packages.orm),
  'datetime': refer('DateTime'),
  'date': refer('DateTime'),
}.map((key, value) => MapEntry(key.toLowerCase(), value));

/// Resolve prisma type
Reference scalar(
  String type, {
  required FieldLocation location,
  bool isNullable = false,
  bool isList = false,
}) {
  // Check if the type is a scalar type in the schema.
  Reference reference = scalarReferences[type.toLowerCase()] ??
      // If the type is not a scalar type, then it must be a model type.
      // Try to resolve the type as a model.
      _resolvePrismaScalar(type, location);

  // If the type is list, then return a list of the type.
  if (isList) {
    reference = TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'Iterable';
      updates.types.add(reference);
    });
  }

  // If the type is nullable, then return a nullable reference to the type.
  return isNullable ? reference.nullable : reference;
}

/// Returns a reference to the Dart class that represents the Prisma scalar type
/// [type].
///
/// If the type is a scalar type, a reference to the Dart class that represents
/// the Prisma scalar type is returned. Otherwise, a reference to the Dart class
/// that represents the GraphQL type is returned.
Reference _resolvePrismaScalar(String type, FieldLocation location) {
  // 1. Check if the type is a scalar type
  if (location == FieldLocation.scalar) {
    // 2. A scalar type is a type that is defined in the GraphQL schema
    return refer(type);
  }

  // 3. Otherwise, return the Dart class name
  return refer(type.toDartClassName());
}
