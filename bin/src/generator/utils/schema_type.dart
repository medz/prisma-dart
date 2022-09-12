import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';

import 'scalar.dart';

Reference schemaTypeResolver(List<SchemaType> types,
    [bool isNullable = false]) {
  if (types.length == 1) {
    return scalar(types.first, isNullable);
  }

  final Set<SchemaType> uniqueTypes = Set.from(types);
  if (uniqueTypes.length == 1) {
    return scalar(uniqueTypes.first, isNullable);
  }

  final Iterable<SchemaType> twoTypes = uniqueTypes.take(2);

  // Find is list type.
  final Iterable<SchemaType> listTypes = twoTypes.where((type) => type.isList);
  if (listTypes.isNotEmpty) {
    return scalar(listTypes.first, isNullable);
  }

  final TypeReference reference = TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = 'PrismaUnion';
    updates.url = 'package:orm/orm.dart';
    updates.types.addAll(types.map((type) => scalar(type)));
  });

  if (isNullable) {
    return TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'PrismaNullable';
      updates.url = 'package:orm/orm.dart';
      updates.types.add(reference);
    });
  }

  return reference;
}
