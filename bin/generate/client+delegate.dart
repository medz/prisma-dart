// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' show ModelActionToJsonQueryAction;

import '../src/dart_style_fixer.dart';
import '../src/reference.dart';
import 'client+output.dart';
import 'client.dart';

final _clientField = Field((builder) {
  builder.name = '_client';
  builder.type = refer('PrismaClient').copyWith(
    types: [refer('T')],
    url: 'package:orm/orm.dart',
  );
  builder.modifier = FieldModifier.final$;
});

final _defaultConstructor = Constructor((builder) {
  builder.name = '_';
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = 'client';
    builder.type = _clientField.type;
  }));
  builder.constant = true;
  builder.initializers.add(Code('${_clientField.name} = client'));
});

extension Client$Delegate on Client {
  Reference generateDelegate(dmmf.ModelMapping modelMapping) {
    final delegate = Class((builder) {
      builder.name = '${modelMapping.model}Delegate'.toDartClassNameString();
      builder.types.add(refer('T'));
      builder.fields.add(_clientField);
      builder.constructors.add(_defaultConstructor);

      for (final action in modelMapping.actions.entries) {
        builder.methods.add(
          generateMethod(modelMapping.model, (action.key, action.value)),
        );
      }
    });

    client.body.add(delegate);
    types[client] = [...?types[client], delegate.name];

    return refer(delegate.name);
  }
}

extension on Client {
  Reference generateOptions(
      String model, dmmf.ModelAction action, dmmf.OutputField field) {
    final typeName =
        '${model}_${action.name}_ActionOptions'.toDartClassNameString();
    if (types[client]?.contains(typeName) == true) {
      return refer(typeName);
    }

    final options = Class((builder) {
      builder.name = typeName;
      builder.abstract = true;
      builder.modifier = ClassModifier.final$;
    });
    client.body.add(options);

    types[client] = [...?types[client], options.name];

    return refer(options.name);
  }

  Method generateMethod(String model, (dmmf.ModelAction, String) action) {
    final field = findAction(action.$2);

    return Method((builder) {
      final returnType = refer('Action').copyWith(
        url: 'package:orm/orm.dart',
        types: [
          generateUnserialized(field),
          generateModelType(field, generateOutput(field.outputType)),
          generateOptions(model, action.$1, field),
        ],
      );

      builder.name = action.$1.name.toDartPropertyNameString();
      builder.returns = returnType;
      builder.body = returnType.newInstance([], {
        'datamodel': refer('PrismaClientExtension').property('_datamodel'),
        'client': refer('_client'),
        'action': literalConstRecord([
          refer('JsonQueryAction', 'package:orm/orm.dart').property(
            action.$1.toJsonQueryAction().name,
          ),
          literalString(action.$2),
        ], {}),
        'model': literalString(model),
        'factory': generateActionFactory(field),
      }).code;
    });
  }

  Expression generateActionFactory(dmmf.OutputField field) {
    final fromJson = generateOutput(field.outputType).property('fromJson');
    if (field.outputType.isList) {
      return refer('JsonConvertible', 'package:orm/orm.dart')
          .property('createIterableFromJson')
          .call([fromJson]);
    } else if (field.isNullable && !field.name.endsWith('OrThrow')) {
      return refer('JsonConvertible', 'package:orm/orm.dart')
          .property('createNullableFromJson')
          .call([fromJson]);
    }

    return fromJson;
  }

  Reference generateModelType(dmmf.OutputField action, Reference type) {
    if (action.outputType.isList) {
      return TypeReference((builder) {
        builder.symbol = 'Iterable';
        builder.types.add(type);
      });
    } else if (action.name.endsWith('OrThrow')) {
      return type;
    }

    return TypeReference((builder) {
      builder.symbol = type.symbol;
      builder.url = type.url;
      builder.isNullable = action.isNullable;
    });
  }

  Reference generateUnserialized(dmmf.OutputField action) {
    final type = refer('Map');

    if (action.outputType.isList) {
      return TypeReference((builder) {
        builder.symbol = 'Iterable';
        builder.types.add(type);
      });
    } else if (action.isNullable && !action.name.endsWith('OrThrow')) {
      return type.toNullable();
    }

    return type;
  }

  dmmf.OutputField findAction(String actionName) {
    for (final type in options.dmmf.schema.outputTypes.prisma) {
      if (type.name != 'Query' && type.name != 'Mutation') {
        continue;
      }

      final action =
          type.fields.firstWhereOrNull((element) => element.name == actionName);
      if (action == null) {
        continue;
      }

      return action;
    }

    throw StateError('Action $actionName not found');
  }
}

extension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }

    return null;
  }
}
