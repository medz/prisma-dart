import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart';

// final Map<String, String> _map = {
//   'string': 'String',
//   'float': 'double',
//   'decimal': 'double',
//   'int': 'int',
//   'bigint': 'BigInt',
//   'boolean': 'bool',
//   'json': 'dynamic',
//   'bytes': 'List<int>',
//   'unsupported': 'dynamic',
//   'null': 'runtime.PrismaNull',
// };

// String scalar(String name) {
//   if (_map.containsKey(name.toLowerCase())) {
//     return _map[name.toLowerCase()].toString();
//   }

//   return name;
// }

/// ----------------------------
/// New code
/// ----------------------------
final Map<String, Reference> _references = {
  'string': Reference('String'),
  'float': Reference('double'),
  'decimal': Reference('double'),
  'int': Reference('int'),
  'bigint': Reference('BigInt'),
  'boolean': Reference('bool'),
  'json': Reference('dynamic'),
  'bytes': TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = 'List';
    updates.types.add(Reference('int'));
  }),
  'unsupported': Reference('dynamic'),
  'null': Reference('PrismaNull', 'package:orm/orm.dart'),
};

TypeReference scalarForString(String name, [bool isNullable = false]) {
  if (isNullable) {
    return TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'PrismaNullable';
      updates.types.add(scalarForString(name, false));
    });
  }

  final Reference? reference = _references[name.toLowerCase()];
  if (reference is TypeReference) return reference;

  return TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = reference?.symbol ?? name;
    updates.url = reference?.url;
  });
}

TypeReference scalar(SchemaType schemaType, [bool isNullable = false]) {
  if (isNullable) {
    return TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'PrismaNullable';
      updates.url = 'package:orm/orm.dart';
      updates.types.add(scalar(schemaType, false));
    });
  } else if (schemaType.isList) {
    return TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'List';

      final SchemaType newType = SchemaType.fromJson({
        ...schemaType.toJson(),
        'isList': false,
      });

      updates.types.add(scalar(newType, isNullable));
    });
  }

  final Reference? reference = _references[schemaType.type.toLowerCase()];
  if (reference is TypeReference) return reference;

  return TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = reference?.symbol ?? schemaType.type;
    updates.url = reference?.url;
  });
}
