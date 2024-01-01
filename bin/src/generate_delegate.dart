import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import 'generate_type.dart';
import 'generator.dart';
import 'utils/dart_style_fixer.dart';
import 'utils/reference.dart';

extension GenerateDelegate on Generator {
  Reference generateDelegate(dmmf.ModelMapping mapping) {
    final name = '${mapping.plural.className}Delegate';
    if (generated.client.contains(name)) {
      return refer(name);
    }

    generated.client.add(name);
    libraries.client.body.add(Class((builder) {
      builder.name = name;
      builder.types.add(refer('T'));
      builder.fields.add(_clientField);
      builder.constructors.add(_defaultConstructor);

      for (final entry in mapping.actions.entries) {
        final action = (entry.key, entry.value);
        builder.methods.add(generateAction(action));
      }
    }));

    return refer(name);
  }
}

final _clientField = Field((builder) {
  builder.name = '_client';
  builder.type = TypeReference((type) {
    type.symbol = 'PrismaClient';
    type.url = 'package:orm/orm.dart';
    type.types.add(refer('T'));
  });
  builder.modifier = FieldModifier.final$;
});

final _defaultConstructor = Constructor((builder) {
  builder.name = '_';
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = _clientField.name;
    builder.toThis = true;
  }));
  builder.constant = true;
});

extension on Generator {
  Method generateAction((dmmf.ModelAction, String) action) {
    final field = findActionDefinition(action.$2);
    final returnsType = generateType(field.outputType);

    return Method((method) {
      method.name = action.$1.name.propertyName;
      method.returns = TypeReference((type) {
        type.symbol = 'Future';
        type.types.add(
          returnsType.nullable(field.isNullable),
        );
      });
    });
  }

  dmmf.OutputField findActionDefinition(String action) {
    return options.dmmf.schema.outputTypes.prisma
        .where(
            (element) => element.name == 'Query' || element.name == 'Mutation')
        .map((e) => e.fields)
        .expand((element) => element)
        .firstWhere((element) => element.name == action);
  }
}
