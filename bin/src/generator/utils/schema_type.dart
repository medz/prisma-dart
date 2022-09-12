import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';

import 'object_field_type.dart';

Reference schemaTypeResolver(List<SchemaType> types) {
  if (types.length == 1) {
    return Reference(objectFieldType(types.first));
  }

  final Set<SchemaType> uniqueTypes = Set.from(types);
  if (uniqueTypes.length == 1) {
    return Reference(objectFieldType(uniqueTypes.first));
  }

  final Iterable<SchemaType> twoTypes = uniqueTypes.take(2);

  // Find is list type.
  final Iterable<SchemaType> listTypes = twoTypes.where((type) => type.isList);
  if (listTypes.isNotEmpty) {
    return Reference(objectFieldType(listTypes.first));
  }

  return Reference(
    'PrismaUnion<${objectFieldType(twoTypes.first)}, ${objectFieldType(twoTypes.last)}>',
    'package:orm/orm.dart',
  );
}
