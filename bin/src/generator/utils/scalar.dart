import 'package:code_builder/code_builder.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

final Map<String, Reference> scalarReferneces = {
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

  final Reference? reference = scalarReferneces[name.toLowerCase()];
  if (reference is TypeReference) return reference;

  return TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = reference?.symbol ?? name;
    updates.url = reference?.url;
  });
}

TypeReference scalar(SchemaType schemaType, [bool isNullable = false]) {
  final SchemaType resolvedSchemaType = SchemaType(
    isList: schemaType.isList,
    type: schemaType.location == FieldLocation.scalar
        ? schemaType.type
        : dartClassnameFixer(schemaType.type),
    location: schemaType.location,
    namespace: schemaType.namespace,
  );

  if (isNullable) {
    // See https://github.com/dart-lang/code_builder/issues/315
    // If the issue is fixed, then PrismaNullable can be removed.
    return TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'PrismaNullable';
      updates.url = 'package:orm/orm.dart';
      updates.types.add(scalar(resolvedSchemaType, false));
    });
  } else if (resolvedSchemaType.isList) {
    return TypeReference((TypeReferenceBuilder updates) {
      updates.symbol = 'List';

      final SchemaType newType = SchemaType.fromJson({
        ...resolvedSchemaType.toJson(),
        'isList': false,
      });

      updates.types.add(scalar(newType, isNullable));
    });
  }

  final Reference? reference =
      scalarReferneces[resolvedSchemaType.type.toLowerCase()];
  if (reference is TypeReference) return reference;

  return TypeReference((TypeReferenceBuilder updates) {
    updates.symbol = reference?.symbol ?? resolvedSchemaType.type;
    updates.url = reference?.url;
  });
}
