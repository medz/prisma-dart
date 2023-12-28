// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

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
        builder.methods.add(generateMethod(action));
      }
    });

    client.body.add(delegate);
    types[client] = [...?types[client], delegate.name];

    return refer(delegate.name);
  }
}

extension on Client {
  Method generateMethod(MapEntry<dmmf.ModelAction, String> action) {
    final field = findAction(action.value);

    return Method((builder) {
      builder.name = action.key.name.toDartPropertyNameString();
      builder.returns = refer('Action').copyWith(
        url: 'package:orm/orm.dart',
        types: [
          generateUnserialized(field),
          generateModelType(field, generateOutput(field.outputType)),
        ],
      );
    });
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
