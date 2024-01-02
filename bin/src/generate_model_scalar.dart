import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/scalars.dart';

extension GenerateModelScalar on Generator {
  Reference generateModelScalar(String enumName) {
    final modelName =
        enumName.substring(0, enumName.indexOf('ScalarFieldEnum')).className;
    final name = '${modelName}Scalar';
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

      for (final field in fields) {
        builder.values.add(EnumValue((builder) {
          builder.name = field.name.propertyName;
          builder.arguments.addAll([
            literalString(field.name),
            literalString(model.name),
          ]);
          builder.types.add(field.type.scalar);
        }));
      }

      // TODO: implement model scalar
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
