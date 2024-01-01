// ignore_for_file: file_names

import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;

import '../src/dart_style_fixer.dart';
import '../src/scalars.dart';
import '../utils/iterable.dart';
import 'client+common.dart';
import 'client.dart';

extension Client$Input$Where on Client {
  Reference generateWhereInput(
      dmmf.InputType input, dmmf.TypeNamespace namespace) {
    final name = input.name.toDartClassNameString();
    final builder = getNamespaceLibraryBuilder(namespace);
    final reference = refer(
      name,
      switch (namespace) {
        dmmf.TypeNamespace.model => 'model.dart',
        dmmf.TypeNamespace.prisma => 'prisma.dart',
      },
    );

    if (types[builder]?.contains(name) == true) {
      return reference;
    }

    types[builder] = [...?types[builder], name];

    final spec = Class((builder) {
      builder.name = input.name.toDartClassNameString();
      builder.implements.add(refer('Input', 'package:orm/orm.dart'));
      builder.constructors.addAll([
        _internalConstructor,
        _builderFactoryConstructor,
        generateGroupConstructor(input),
      ]);

      builder.fields.add(_recordsField);
      for (final field in input.fields) {
        if (field.name == 'AND' || field.name == 'OR' || field.name == 'NOT') {
          builder.constructors.add(
            generateMultitInputsConstructor(name, field.name, field),
          );
          continue;
        }

        builder.fields.add(generateStaticField(name, field));
      }
    });
    builder.body.add(spec);

    return reference;
  }
}

final _recordsField = Field((builder) {
  builder.name = '\$records';
  builder.modifier = FieldModifier.final$;
  builder.type = TypeReference((builder) {
    builder.symbol = 'Iterable';
    builder.types.add(RecordType((builder) {
      builder.positionalFieldTypes.addAll([
        TypeReference((builder) {
          builder.symbol = 'Iterable';
          builder.types.add(refer('String'));
        }),
        refer('Object'),
      ]);
    }));
  });
  builder.annotations.add(refer('override'));
});

final _internalConstructor = Constructor((builder) {
  builder.name = '_';
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = '\$records';
    builder.toThis = true;
  }));
  builder.constant = true;
});

final _builderFactoryConstructor = Constructor((builder) {
  builder.name = '_factory';
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = 'keys';
    builder.type = TypeReference((builder) {
      builder.symbol = 'Iterable';
      builder.types.add(refer('String'));
    });
  }));
  builder.requiredParameters.add(Parameter((builder) {
    builder.name = 'value';
  }));
  builder.initializers.add(
    refer('this').newInstanceNamed('_', [
      literalList([
        literalRecord([
          refer('keys'),
          refer('value'),
        ], {})
      ]),
    ]).code,
  );
});

extension on Client {
  Constructor generateGroupConstructor(dmmf.InputType input) {
    return Constructor((builder) {
      builder.name = '_group';
      builder.factory = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'records';
        builder.type = TypeReference((builder) {
          builder.symbol = 'Iterable';
          builder.types.add(refer(input.name.toDartClassNameString()));
        });
      }));

      builder.body = refer(input.name.toDartClassNameString()).newInstanceNamed(
        '_',
        [
          refer('records')
              .property('map')
              .call([
                Method((builder) {
                  builder.requiredParameters.add(Parameter((builder) {
                    builder.name = 'e';
                  }));

                  builder.body = refer('e').property('\$records').code;
                }).closure,
              ])
              .property('expand')
              .call([
                Method((builder) {
                  builder.requiredParameters.add(Parameter((builder) {
                    builder.name = 'e';
                  }));

                  builder.body = refer('e').code;
                }).closure,
              ]),
        ],
      ).code;
    });
  }

  Field generateStaticField(String name, dmmf.InputField field) {
    final inputBuilder = TypeReference((builder) {
      builder.symbol = 'InputBuilder';
      builder.url = 'package:orm/orm.dart';

      final (valueType, filterType) = generateValueTypes(field);
      builder.types.addAll([
        refer(name),
        valueType,
        refer('Null'), // TODO: implement input builder reference
        filterType,
        generateNullableType(field.inputTypes),
      ]);
    });

    return Field((builder) {
      builder.static = true;
      builder.modifier = FieldModifier.constant;
      builder.name = field.name.toDartPropertyNameString();
      builder.type = inputBuilder;
      builder.assignment = inputBuilder.newInstance([
        literalConstList([literalString(field.name)]),
        refer(name).property('_factory'),
      ]).code;
    });
  }

  (Reference type, Reference filter) generateValueTypes(dmmf.InputField field) {
    final scalar = field.inputTypes.firstWhereOrNull(
        (element) => element.location == dmmf.TypeLocation.scalar);
    if (scalar != null) {
      final type = scalars[scalar.type] ?? refer(scalar.type);
      if (scalar.isList) {
        return (
          TypeReference((builder) {
            builder.symbol = 'Iterable';
            builder.types.add(type);
          }),
          refer('Null'),
        );
      }

      final allowFilter = field.inputTypes
          .any((element) => element.type == '${scalar.type}Filter');
      final filter = switch (allowFilter) {
        true => refer('bool'),
        _ => refer('Null'),
      };

      return (type, filter);
    }

    final enum_ = field.inputTypes.firstWhereOrNull(
        (element) => element.location == dmmf.TypeLocation.enumTypes);
    if (enum_ != null) {
      final type = switch (enum_.namespace) {
        dmmf.TypeNamespace.model => refer(enum_.type, 'model.dart'),
        dmmf.TypeNamespace.prisma => refer(enum_.type, 'prisma.dart'),
        _ => refer(enum_.type),
      };
      if (enum_.isList) {
        return (
          TypeReference((builder) {
            builder.symbol = 'Iterable';
            builder.types.add(type);
          }),
          refer('Null'),
        );
      }

      final allowFilter = field.inputTypes
          .any((element) => element.type == 'Enum${enum_.type}Filter');
      final filter = switch (allowFilter) {
        true => refer('bool'),
        _ => refer('Null'),
      };

      return (type, filter);
    }

    // TODO
    return (refer('Object'), refer('Null'));
  }

  Reference generateNullableType(Iterable<dmmf.TypeReference> types) {
    final nulls = types.any((element) => element.type == 'Nulls');
    if (nulls) {
      return refer('bool');
    }

    return refer('Null');
  }

  Constructor generateMultitInputsConstructor(
      String className, String name, dmmf.InputField field) {
    return Constructor((builder) {
      builder.docs.add('// ignore: non_constant_identifier_names');
      builder.name = name;
      builder.factory = true;
      builder.requiredParameters.add(Parameter((builder) {
        builder.name = 'inputs';
        builder.type = TypeReference((builder) {
          builder.symbol = 'Iterable';
          builder.types.add(TypeReference((builder) {
            builder.symbol = 'Iterable';
            builder.types.add(refer(className));
          }));
        });
      }));

      builder.body = refer(className).newInstanceNamed('_', [
        literalList([
          literalRecord([
            literalList([literalString(name)]),
            refer('Input', 'package:orm/orm.dart')
                .property('deserializeMultiple')
                .call([
              refer('inputs').property('map').call([
                refer(className).property('_group'),
              ]),
            ]),
          ], {}),
        ]),
      ]).code;
    });
  }
}
