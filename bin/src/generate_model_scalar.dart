import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_type.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/scalars.dart';

extension GenerateModelScalar on Generator {
  Reference generateModelScalar(String enumName) {
    final modelName =
        enumName.substring(0, enumName.indexOf('ScalarFieldEnum'));
    final name = '${modelName}Scalar'.className;
    if (generated.prisma.contains(name)) {
      return refer(name);
    }

    final enum$ = options.dmmf.schema.enumTypes.prisma
        .firstWhere((element) => element.name == enumName);
    final model = findModel(modelName);
    final fields = model.fields.where((e) => enum$.values.contains(e.name));

    generated.prisma.add(name);
    libraries.prisma.body.add(Enum((builder) {
      builder.name = name;
      builder.types.add(refer('T'));
      builder.implements.addAll([
        refer('PrismaEnum', 'package:orm/orm.dart'),
        TypeReference((builder) {
          builder.symbol = 'Reference';
          builder.types.add(refer('T'));
          builder.url = 'package:orm/orm.dart';
        }),
      ]);

      for (final field in fields) {
        builder.values.add(EnumValue((builder) {
          builder.name = field.name.propertyName;
          if (builder.name == 'name' || builder.name == 'model') {
            builder.name = '${builder.name}\$';
          }

          builder.arguments.addAll([
            literalString(field.name),
            literalString(model.name),
          ]);

          final type = switch (field.kind) {
            dmmf.FieldKind.scalar => field.type.scalar,
            _ => generateType(dmmf.TypeReference(
                isList: field.isList,
                namespace: dmmf.TypeNamespace.model,
                location: dmmf.TypeLocation.enumTypes,
                type: field.type,
              ))
          };
          builder.types.add(type);
        }));
      }

      builder.fields.addAll([_nameField, _modelField]);
      builder.constructors.add(_defaultConstructor);
    }));

    return refer(name);
  }
}

extension on Generator {
  dmmf.Model findModel(String name) {
    return options.dmmf.datamodel.models.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase());
  }
}

final _nameField = Field((builder) {
  builder.name = 'name';
  builder.type = refer('String');
  builder.modifier = FieldModifier.final$;
  builder.annotations.add(refer('override'));
});

final _modelField = Field((builder) {
  builder.name = 'model';
  builder.type = refer('String');
  builder.modifier = FieldModifier.final$;
  builder.annotations.add(refer('override'));
});

final _defaultConstructor = Constructor((builder) {
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = _nameField.name;
    builder.toThis = true;
  }));
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = _modelField.name;
    builder.toThis = true;
  }));

  builder.constant = true;
});
