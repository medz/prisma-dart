// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../src/dart_style_fixer.dart';
import '../src/utils/dmmf_schema_types.dart';
import 'client+common.dart';
import 'client.dart';

extension Client$Enum on Client {
  Reference generateEnum(dmmf.TypeReference typeRefer) {
    if (typeRefer.location != dmmf.TypeLocation.enumTypes) {
      throw ArgumentError.value(typeRefer, 'typeRefer',
          'Expected type location to be enumTypes, but got ${typeRefer.location}');
    }

    // TODO: Scalar and other enum types.

    final name = typeRefer.type.toDartClassNameString();
    if (namespaceTypeExists(name, typeRefer.namespace)) {
      return getNamespaceRefer(name, typeRefer.namespace);
    }

    final builder = getNamespaceLibraryBuilder(typeRefer.namespace);
    types[builder] = [...?types[builder], name];

    final enumValues = findEnumValues(typeRefer);
    final spec = Enum((builder) {
      builder.name = name;
      builder.implements.add(TypeReference((builder) {
        builder.symbol = 'PrismaEnum';
        builder.url = 'package:orm/orm.dart';
      }));
      builder.fields.add(Field((builder) {
        builder.modifier = FieldModifier.final$;
        builder.name = 'name';
        builder.type = refer('String');
        builder.annotations.add(refer('override'));
      }));
      builder.constructors.add(Constructor((builder) {
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = 'name';
          builder.toThis = true;
        }));
        builder.constant = true;
      }));

      for (final name in enumValues) {
        builder.values.add(EnumValue((builder) {
          builder.name = name.toDartPropertyNameString();
          builder.arguments.add(literalString(name));
        }));
      }
    });

    builder.body.add(spec);

    return getNamespaceRefer(name, typeRefer.namespace);
  }
}

extension on Client {
  Iterable<String> findEnumValues(dmmf.TypeReference typeRefer) {
    return options.dmmf.schema.enumTypes.pattern
        .firstWhere((element) => element.name == typeRefer.type)
        .values;
  }
}
