import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_select.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateInclude on Generator {
  Reference generateInclude(dmmf.TypeReference type) {
    final outout = findOutputField(type);
    final name = '${outout.name.className}Include';
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
        if (!isModuleRef(field)) {
          continue;
        }

        builder.fields.add(generateField(field, outout.name.className));
      }

      builder.methods.add(generateToJson(outout));
    }));

    return refer(name).namespace(dmmf.TypeNamespace.prisma);
  }
}

extension on Generator {
  Method generateToJson(dmmf.OutputType output) {
    final entries = output.fields
        .where(isModuleRef)
        .map((e) => MapEntry(e.name, refer(e.name.propertyName)));

    return Method((builder) {
      builder.name = 'toJson';
      builder.returns = refer('Map<String, dynamic>');
      builder.body = literalMap(Map.fromEntries(entries)).code;
      builder.annotations.add(refer('override'));
    });
  }

  Field generateField(dmmf.OutputField field, String outoutName) {
    return Field((builder) {
      builder.modifier = FieldModifier.final$;
      builder.name = field.name.propertyName;
      builder.type =
          generateTypeWithFieldArgs(field, outoutName).nullable(true);
    });
  }

  Constructor generateDefaultConstructor(dmmf.OutputType output) {
    return Constructor((builder) {
      builder.constant = true;

      for (final field in output.fields) {
        if (!isModuleRef(field)) {
          continue;
        }

        builder.optionalParameters.add(Parameter((builder) {
          builder.name = field.name.propertyName;
          builder.toThis = true;
          builder.named = true;
        }));
      }
    });
  }

  bool isModuleRef(dmmf.OutputField field) {
    return options.dmmf.datamodel.models
        .any((element) => element.name == field.outputType.type);
  }

  dmmf.OutputType findOutputField(dmmf.TypeReference type) {
    final types = switch (type.namespace) {
      dmmf.TypeNamespace.model => options.dmmf.schema.outputTypes.model,
      dmmf.TypeNamespace.prisma => options.dmmf.schema.outputTypes.prisma,
      _ => const <dmmf.OutputType>[],
    };

    return types.firstWhere((element) => element.name == type.type);
  }
}
