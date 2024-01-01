// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../src/dart_style_fixer.dart';
import '../src/reference.dart';
import '../src/scalars.dart';
import '../src/utils/dmmf_schema_types.dart';
import 'client+common.dart';
import 'client+enum.dart';
import 'client.dart';

extension Client$Output on Client {
  Reference generateOutput(dmmf.TypeReference type) {
    final name = type.type.toDartClassNameString();
    if (namespaceTypeExists(name, type.namespace)) {
      return getNamespaceRefer(name, type.namespace);
    }

    final builder = getNamespaceLibraryBuilder(type.namespace);
    types[builder] = [...?types[builder], name];

    final output = findOutput(type);
    final value = Class((builder) {
      builder.name = name;

      // Fields
      for (final field in output.fields) {
        builder.fields.add(generateField(field));
      }

      builder.constructors.add(generateDefaultConstructor(output));
      builder.constructors.add(generateFromJsonConstructor(output));
    });

    builder.body.add(value);

    return getNamespaceRefer(name, type.namespace);
  }
}

extension on Client {
  dmmf.OutputType findOutput(dmmf.TypeReference type) {
    return options.dmmf.schema.outputTypes.pattern
        .firstWhere((element) => element.name == type.type);
  }

  Field generateField(dmmf.OutputField field) {
    return Field((builder) {
      builder.modifier = FieldModifier.final$;
      builder.name = field.name.toDartPropertyNameString();
      builder.type = generateFieldType(field.outputType).toNullable();
    });
  }

  Reference generateFieldType(dmmf.TypeReference type) {
    final value = switch (type.location) {
      dmmf.TypeLocation.outputObjectTypes => generateOutput(type),
      dmmf.TypeLocation.scalar => scalars[type.type] ?? refer(type.type),
      dmmf.TypeLocation.enumTypes => generateEnum(type),
      _ => throw Exception('Unknown type location: ${type.location}'),
    };

    if (type.isList) {
      return TypeReference((builder) {
        builder.symbol = 'Iterable';
        builder.types.add(value);
      });
    }

    return value;
  }

  Constructor generateDefaultConstructor(dmmf.OutputType type) {
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

  Constructor generateFromJsonConstructor(dmmf.OutputType type) {
    return Constructor((builder) {
      builder.name = 'fromJson';
      builder.factory = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'json';
        builder.type = refer('Map');
      }));

      final entries = type.fields.map((e) {
        final value = switch (e.outputType.location) {
          dmmf.TypeLocation.enumTypes => generateFromJsonEnumType(e),
          dmmf.TypeLocation.outputObjectTypes => generateFromJsonOutputType(e),
          _ => refer('json').index(literalString(e.name)),
        };

        return MapEntry(e.name.toDartPropertyNameString(), value);
      });

      builder.body = refer(type.name.toDartClassNameString())
          .newInstance([], Map.fromEntries(entries)).code;
    });
  }

  Expression generateFromJsonOutputType(dmmf.OutputField field) {
    final type = generateOutput(field.outputType);

    if (field.outputType.isList) {
      final parse = Method((builder) {
        builder.lambda = true;
        builder.requiredParameters.add(Parameter((builder) {
          builder.name = 'e';
        }));
        builder.body = type.newInstanceNamed('fromJson', [refer('e')]).code;
      });

      return refer('json')
          .index(literalString(field.name))
          .asA(refer('Iterable').toNullable())
          .nullSafeProperty('map')
          .call([parse.closure]);
    }

    final deserialize = type.newInstanceNamed('fromJson', [
      refer('json').index(literalString(field.name)),
    ]);

    return refer('json')
        .index(literalString(field.name))
        .isA(refer('Map'))
        .conditional(deserialize, literalNull);
  }

  Expression generateFromJsonEnumType(dmmf.OutputField field) {
    final test = Method((builder) {
      builder.lambda = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'e';
      }));
      builder.body = refer('e')
          .property('name')
          .equalTo(refer('json').index(literalString(field.name)))
          .code;
    });

    return generateEnum(field.outputType)
        .property('values')
        .property('where')
        .call([test.closure]).property('firstOrNull');
  }
}
