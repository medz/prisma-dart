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

      for (final field in outout.fields) {
        if (!isModuleRef(field)) {
          continue;
        }

        builder.fields.add(generateField(field, outout.name.className));
      }
    }));

    return refer(name).namespace(dmmf.TypeNamespace.prisma);
  }
}

extension on Generator {
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
