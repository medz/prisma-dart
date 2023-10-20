import 'package:orm/dmmf.dart' as dmmf;

dmmf.Field field(
  final dmmf.FieldKind kind,
  final String name,
  final String type, [
  Map<String, dynamic>? extra,
]) =>
    dmmf.Field.fromJson({
      'kind': kind == dmmf.FieldKind.enum_ ? 'enum' : kind.name,
      'name': name,
      'type': type,
      'isRequired': false,
      'isList': false,
      'isUnique': true,
      'isId': true,
      'isReadOnly': false,
      'hasDefaultValue': false,
      ...?extra,
    });

dmmf.Model model(final String name, final Iterable<dmmf.Field> fields) =>
    dmmf.Model(
      name: name,
      uniqueFields: const [],
      uniqueIndexes: const [],
      fields: [
        field(dmmf.FieldKind.scalar, 'id', 'String', {
          'isUnique': true,
          'isId': true,
        }),
        ...fields,
      ],
      primaryKey: dmmf.PrimaryKey(name: 'id', fields: ['id']),
    );
