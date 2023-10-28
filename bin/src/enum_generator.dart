import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' hide EnumValue, Field;
import 'package:recase/recase.dart';

import 'context.dart';

class EnumGenerator {
  final Context context;

  const EnumGenerator(this.context);

  Future<void> handle(SchemaEnum schema) async {
    final meta = LibraryMeta(
      type: schema.name,
      location: FieldLocation.enumTypes,
      namespace: FieldNamespace.model,
    );
    if (context.libraries.containsKey(meta)) {
      return;
    }

    context.libraries[meta] = Library((builder) {
      builder.body.add(_generateEnum(schema));
      builder.ignoreForFile.add('non_constant_identifier_names');
    });
  }

  Enum _generateEnum(SchemaEnum schema) {
    return Enum((builder) {
      builder
        ..name = schema.name.pascalCase
        ..implements.add(coreRefer('PrismaEnum'))
        ..fields.add(
          Field((builder) {
            builder
              ..name = 'PRISMA_ENUM_VALUE'
              ..type = refer('String')
              ..annotations.add(refer('override'))
              ..modifier = FieldModifier.final$;
          }),
        )
        ..constructors.add(
          Constructor((builder) {
            builder
              ..constant = true
              ..requiredParameters.add(Parameter((builder) {
                builder
                  ..name = 'value'
                  ..type = refer('String');
              }))
              ..initializers.add(Code('PRISMA_ENUM_VALUE = value'));
          }),
        )
        ..values.addAll(schema.values.map(_generateEnumValue));
    });
  }

  EnumValue _generateEnumValue(String value) {
    return EnumValue((builder) {
      builder
        ..name = value.camelCase
        ..arguments.add(literalString(value));
    });
  }
}
