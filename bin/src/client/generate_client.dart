import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart';

import '../dart_style_fixer.dart';
import '../reference.dart';
import '../scalars.dart';
import '../types/generate_input.dart';

extension on dmmf.ModelMapping {
  String toModelDelegateClassName() =>
      '${model}Delegate'.toDartClassNameString();
}

Library generateClientLibrary(dmmf.DMMF document) {
  return Library((builder) {
    builder.name = 'prisma.client';
    builder.body.add(generateClientExtension(document));
    builder.body.addAll(generateModelDelegate(document));
  });
}

Extension generateClientExtension(dmmf.DMMF document) {
  return Extension((builder) {
    builder.name = 'ModelDelegateIntoPrismaClient';
    builder.on = refer('PrismaClient')
        .toPackage(Packages.prismaRuntime)
        .copyWith(types: [refer('T')]);
    builder.types.add(refer('T'));
    builder.methods
        .addAll(generateModelDelegateIntoPrismaClientMethod(document));
  });
}

Iterable<Method> generateModelDelegateIntoPrismaClientMethod(
    dmmf.DMMF document) {
  return document.mappings.modelOperations.map((e) {
    return Method((builder) {
      builder.type = MethodType.getter;
      builder.name = e.model.toDartPropertyNameString();
      builder.returns =
          refer('ModelDelegate').toPackage(Packages.prismaRuntime).copyWith(
        types: [
          refer(e.model.toDartClassNameString())
              .toPackage(Packages.generatedTypes),
          refer('T'),
        ],
      );
      builder.body = refer('ModelDelegate')
          .toPackage(Packages.prismaRuntime)
          .newInstance([refer('this')]).code;
    });
  });
}

Iterable<Extension> generateModelDelegate(dmmf.DMMF document) sync* {
  for (final mapping in document.mappings.modelOperations) {
    yield Extension((builder) {
      builder.name = mapping.toModelDelegateClassName();
      builder.on =
          refer('ModelDelegate').toPackage(Packages.prismaRuntime).copyWith(
        types: [
          refer(mapping.model.toDartClassNameString())
              .toPackage(Packages.generatedTypes),
          refer('T')
        ],
      );
      builder.types.add(refer('T'));
      builder.methods.addAll(generateDelegateMethods(mapping, document));
    });
  }
}

Iterable<Method> generateDelegateMethods(
    dmmf.ModelMapping mapping, dmmf.DMMF document) sync* {
  for (final entity in mapping.actions.entries) {
    yield generateDelegateMethod(entity, mapping, document);
  }
}

dmmf.OutputField findSchemaField(String name, dmmf.DMMF document) {
  final query = document.schema.outputTypes.prisma
      .where((element) => element.name == 'Query')
      .firstOrNull
      ?.fields;
  final mutation = document.schema.outputTypes.prisma
      .where((element) => element.name == 'Mutation')
      .firstOrNull
      ?.fields;

  final result = query?.where((element) => element.name == name).firstOrNull ??
      mutation?.where((element) => element.name == name).firstOrNull;

  if (result == null) {
    throw ArgumentError.value(name, 'name', 'Field not found');
  }

  return result;
}

extension on dmmf.OutputField {
  bool get nullable {
    if (name.endsWith('OrThrow')) return false;

    return isNullable;
  }

  Reference toModelDelegateReturnType(dmmf.DMMF document) {
    return outputType
        .toDartReference(document, innerTypes: false)
        .switchNullable(nullable);
  }

  bool allowSelectAndInlcude(dmmf.ModelAction action) {
    const disallowedActions = <dmmf.ModelAction>[
      dmmf.ModelAction.createMany,
      dmmf.ModelAction.updateMany,
      dmmf.ModelAction.count,
      dmmf.ModelAction.groupBy,
      dmmf.ModelAction.findRaw,
      dmmf.ModelAction.aggregateRaw,
    ];

    return outputType.location == dmmf.TypeLocation.outputObjectTypes &&
        outputType.namespace == dmmf.TypeNamespace.model &&
        !disallowedActions.contains(action);
  }
}

extension on Reference {
  TypeReference wrapperFuture() {
    return TypeReference((builder) {
      builder.symbol = 'Future';
      builder.types.add(this);
    });
  }
}

Method generateDelegateMethod(MapEntry<dmmf.ModelAction, String> entity,
    dmmf.ModelMapping mapping, dmmf.DMMF document) {
  return Method((builder) {
    final field = findSchemaField(entity.value, document);

    builder.name = entity.key.name.toDartPropertyNameString();
    builder.returns = field.toModelDelegateReturnType(document).wrapperFuture();
    builder.modifier = MethodModifier.async;
    builder.optionalParameters.addAll(
      generateDelegateMethodParameters(field, entity.key, document),
    );
    builder.body =
        generateDelegateMethodBody(entity.key, field, mapping, document);
  });
}

Iterable<Parameter> generateDelegateMethodParameters(
    dmmf.OutputField field, dmmf.ModelAction action, dmmf.DMMF document) {
  final parameters = field.args.map((e) {
    return Parameter((builder) {
      builder.name = e.name.toDartPropertyNameString();
      builder.named = true;
      builder.type =
          generateInputFieldType(e.inputTypes, document, innerTypes: false)
              .switchNullable(!e.isRequired || e.isNullable);
      builder.required = e.isRequired;
    });
  }).toList();

  // Append select and include parameters.
  if (field.allowSelectAndInlcude(action)) {
    // Select
    parameters.add(Parameter((builder) {
      builder.name = 'select';
      builder.type =
          refer('${field.outputType.type.toDartClassNameString()}Select')
              .toNullable()
              .toPackage(Packages.generatedTypes);
    }));

    // Include
    parameters.add(Parameter((builder) {
      builder.name = 'include';
      builder.type =
          refer('${field.outputType.type.toDartClassNameString()}Include')
              .toNullable()
              .toPackage(Packages.generatedTypes);
    }));
  }

  return parameters;
}

Block generateDelegateMethodBody(dmmf.ModelAction action,
    dmmf.OutputField field, dmmf.ModelMapping mapping, dmmf.DMMF document) {
  return Block((builder) {
    final entries = field.args
        .map((e) => MapEntry(e.name, refer(e.name.toDartPropertyNameString())))
        .toList();

    if (field.allowSelectAndInlcude(action)) {
      entries.add(MapEntry('select', refer('select')));
      entries.add(MapEntry('include', refer('include')));
    }

    // Add args map.
    builder.statements.add(
      declareFinal('args')
          .assign(literalMap(Map.fromEntries(entries)))
          .statement,
    );

    // Json query
    builder.statements.add(declareFinal('query')
        .assign(
          refer('serializeJsonQuery')
              .toPackage(Packages.prismaRuntime)
              .call([], {
            'datamodel': refer('dmmf')
                .toPackage(Packages.generatedDmmf)
                .property('datamodel'),
            'action': refer('JsonQueryAction')
                .toPackage(Packages.prismaRuntime)
                .property(action.toJsonQueryAction().name),
            'modelName': literalString(mapping.model.toDartClassNameString()),
            'args': refer('args'),
          }),
        )
        .statement);
    final modelDelegate =
        refer('ModelDelegate').toPackage(Packages.prismaRuntime);

    final result = declareFinal('result');
    final request = modelDelegate
        .property(r'$getPrismaEngine')
        .call([refer('this')])
        .property('request')
        .call([
          refer('query')
        ], {
          'headers': modelDelegate
              .property(r'$getPrismaClientHeaders')
              .call([refer('this')]),
          'transaction': modelDelegate
              .property(r'$getPrismaClientTransaction')
              .call([refer('this')]),
        });

    builder.statements.add(result.assign(request.awaited).statement);

    final returnType = dmmf.TypeReference(
      isList: false,
      namespace: field.outputType.namespace,
      location: field.outputType.location,
      type: field.outputType.type,
    ).toDartReference(document, innerTypes: false);

    final returns = switch (field.outputType.isList) {
      false =>
        returnType.toNonNullable().property('fromJson').call([refer('result')]),
      _ => refer('result').asA(refer('Iterable')).property('map').call([
          Method((builder) {
            builder.requiredParameters.add(Parameter((builder) {
              builder.name = 'e';
            }));
            builder.body = returnType
                .toNonNullable()
                .property('fromJson')
                .call([refer('e')]).code;
            builder.lambda = true;
          }).closure,
        ]),
    };

    builder.statements.add(
      switch (field.nullable) {
        false => returns,
        _ =>
          refer('result').equalTo(literalNull).conditional(literalNull, returns)
      }
          .returned
          .statement,
    );
  });
}
