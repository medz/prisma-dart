import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../dart_style_fixer.dart';
import '../reference.dart';
import '../scalars.dart';
import '../utils/dmmf_schema_types.dart';

extension on dmmf.OutputType {
  bool get isQuery => name == 'Query';
  bool get isMutation => name == 'Mutation';
}

Iterable<Class> generateOutputTypes(dmmf.DMMF document) sync* {
  for (final output in document.schema.outputTypes.pattern) {
    if (output.isQuery || output.isMutation) continue;

    yield generateOutputType(output, document);
  }
}

Class generateOutputType(dmmf.OutputType type, dmmf.DMMF document) {
  return Class((builder) {
    builder.name = type.name.toDartClassNameString();
    builder.fields.addAll(generateOutputTypeFields(type, document));
    builder.constructors.add(generateOutputConstructor(type, document));
    builder.constructors.add(generateOutputFromJsonConstructor(type, document));
  });
}

final jsonParameter = Parameter((builder) {
  builder.name = 'json';
  builder.type = refer('Map');
});

Constructor generateOutputFromJsonConstructor(
    dmmf.OutputType type, dmmf.DMMF document) {
  return Constructor((builder) {
    builder.factory = true;
    builder.name = 'fromJson';
    builder.requiredParameters.add(jsonParameter);

    final entries = type.fields.map((e) {
      final value = switch (e.outputType.location) {
        dmmf.TypeLocation.enumTypes => e.outputType
              .toDartReference(document, innerTypes: true)
              .property('values')
              .property('where')
              .call([
            Method((builder) {
              builder.lambda = true;
              builder.requiredParameters.add(Parameter((builder) {
                builder.name = 'e';
              }));
              builder.body = refer('e')
                  .property('toPrismaEnumName')
                  .call([])
                  .equalTo(refer('json').index(literalString(e.name)))
                  .code;
            }).closure
          ]).property('firstOrNull'),
        dmmf.TypeLocation.outputObjectTypes => switch (e.outputType.isList) {
            false => refer('json')
                .index(literalString(e.name))
                .equalTo(literalNull)
                .conditional(
                  literalNull,
                  e.outputType
                      .toDartReference(document, innerTypes: true)
                      .property('fromJson')
                      .call(
                    [
                      refer('json')
                          .index(literalString(e.name))
                          .asA(refer('Map')),
                    ],
                  ),
                ),
            true => refer('json')
                  .index(literalString(e.name))
                  .asA(refer('Iterable').toNullable())
                  .nullSafeProperty('map')
                  .call([
                Method((builder) {
                  builder.lambda = true;
                  builder.requiredParameters.add(Parameter((builder) {
                    builder.name = 'e';
                  }));

                  final type = dmmf.TypeReference(
                      isList: false,
                      type: e.outputType.type,
                      location: e.outputType.location,
                      namespace: e.outputType.namespace);
                  builder.body = type
                      .toDartReference(document, innerTypes: true)
                      .property('fromJson')
                      .call([
                    refer('e').asA(refer('Map')),
                  ]).code;
                }).closure
              ])
          },
        _ => refer('json').index(literalString(e.name)),
      };

      return MapEntry(e.name.toDartPropertyNameString(), value);
    });

    builder.body = refer(type.name.toDartClassNameString())
        .newInstance([], Map.fromEntries(entries)).code;
  });
}

Constructor generateOutputConstructor(
    dmmf.OutputType type, dmmf.DMMF document) {
  return Constructor((builder) {
    builder.constant = true;

    final parameters = type.fields.map((e) {
      return Parameter((builder) {
        builder.name = e.name.toDartPropertyNameString();
        builder.toThis = true;
        builder.named = true;
      });
    });

    builder.optionalParameters.addAll(parameters);
  });
}

Iterable<Field> generateOutputTypeFields(
    dmmf.OutputType type, dmmf.DMMF document) sync* {
  for (final field in type.fields) {
    yield generateOutputTypeField(field, document);
  }
}

Field generateOutputTypeField(dmmf.OutputField field, dmmf.DMMF document) {
  return Field((builder) {
    builder.name = field.name.toDartPropertyNameString();
    builder.type = field.outputType
        .toDartReference(document, innerTypes: true)
        .toNullable();
    if (field.outputType.type == 'Json') {
      builder.type = refer('dynamic');
    }

    builder.modifier = FieldModifier.final$;
  });
}
