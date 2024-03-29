import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_helpers.dart';
import 'generate_include.dart';
import 'generate_input.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateSelect on Generator {
  Reference generateSelect(dmmf.OutputField field) {
    final outout = findOutputField(field.outputType);
    final name = '${outout.name.className}Select';
    if (generated.prisma.contains(name)) {
      return refer(name).namespace(dmmf.TypeNamespace.prisma);
    }

    generated.prisma.add(name);
    libraries.prisma.body.add(Class((builder) {
      builder.name = name;
      builder.constructors.add(generateDefaultConstructor(outout));
      builder.implements.add(TypeReference((builder) {
        builder.symbol = 'JsonConvertible';
        builder.url = 'package:orm/orm.dart';
        builder.types.add(refer('Map<String, dynamic>'));
      }));

      for (final field in outout.fields) {
        builder.fields.add(generateField(field, outout.name.className));
      }

      builder.methods.add(generateToJson(outout));
    }));

    return refer(name).namespace(dmmf.TypeNamespace.prisma);
  }

  Reference generateTypeWithFieldArgs(
      dmmf.OutputField field, String outoutName) {
    final name = '${outoutName.className}${field.name.className}Args';
    if (generated.prisma.contains(name)) {
      return TypeReference((builder) {
        builder.symbol = 'PrismaUnion';
        builder.url = 'package:orm/orm.dart';
        builder.types.addAll([
          refer('bool'),
          refer(name).namespace(dmmf.TypeNamespace.prisma),
        ]);
      });
    }

    final fields = List<dmmf.InputField>.from(field.args);
    if (field.outputType.location == dmmf.TypeLocation.outputObjectTypes) {
      generateSelect(field);
      fields.add(dmmf.InputField(
        name: 'select',
        isNullable: true,
        isRequired: false,
        inputTypes: [
          dmmf.TypeReference(
            isList: false,
            namespace: dmmf.TypeNamespace.prisma,
            location: dmmf.TypeLocation.outputObjectTypes,
            type: '${field.outputType.type}Select',
          ),
        ],
      ));
    }

    if (allowInclude(field.outputType)) {
      generateInclude(field.outputType);
      fields.add(dmmf.InputField(
        name: 'include',
        isNullable: true,
        isRequired: false,
        inputTypes: [
          dmmf.TypeReference(
            isList: false,
            namespace: dmmf.TypeNamespace.prisma,
            location: dmmf.TypeLocation.outputObjectTypes,
            type: '${field.outputType.type}Include',
          ),
        ],
      ));
    }

    final input = dmmf.InputType(
      name: name,
      constraints: const dmmf.InputTypeConstraints(),
      fields: fields,
    );
    final type = generateInputByInput(
      input,
      namespace: dmmf.TypeNamespace.prisma,
    );

    return TypeReference((builder) {
      builder.symbol = 'PrismaUnion';
      builder.url = 'package:orm/orm.dart';
      builder.types.addAll([refer('bool'), type]);
    });
  }
}

extension on Generator {
  Method generateToJson(dmmf.OutputType output) {
    final entries =
        output.fields.map((e) => MapEntry(e.name, refer(e.name.propertyName)));

    return Method((builder) {
      builder.name = 'toJson';
      builder.returns = refer('Map<String, dynamic>');
      builder.body = literalMap(Map.fromEntries(entries)).code;
      builder.annotations.add(refer('override'));
    });
  }

  Constructor generateDefaultConstructor(dmmf.OutputType output) {
    return Constructor((builder) {
      builder.constant = true;

      for (final arg in output.fields) {
        builder.optionalParameters.add(Parameter((builder) {
          builder.name = arg.name.propertyName;
          builder.toThis = true;
          builder.named = true;
        }));
      }
    });
  }

  Field generateField(dmmf.OutputField field, String outoutName) {
    return Field((builder) {
      builder.modifier = FieldModifier.final$;
      builder.name = field.name.propertyName;
      builder.type = generateSelectType(field, outoutName).nullable(true);
    });
  }

  Reference generateSelectType(dmmf.OutputField field, String outoutName) {
    if (field.outputType.location == dmmf.TypeLocation.outputObjectTypes) {
      return generateTypeWithFieldArgs(field, outoutName);
    }

    return refer('bool');
  }

  dmmf.OutputType findOutputField(dmmf.TypeReference type) {
    final types = switch (type.namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.outputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.outputTypes.prisma,
      _ => const <dmmf.OutputType>[],
    };

    return types.firstWhere(
      (element) => element.name == type.type,
      orElse: () => throw ArgumentError(
        'Output type ${type.type} not found.',
        type.type,
      ),
    );
  }
}
