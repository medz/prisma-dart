import 'package:code_builder/code_builder.dart';
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/orm.dart' show languageKeywordEncode;

import 'generator_options.dart';
import 'utils/dart_style.dart';
import 'utils/scalar.dart';

String modelDelegateClassname(String model) =>
    '${dartClassnameFixer(model)}Delegate';

class ModelDelegateBuilder {
  final GeneratorOptions options;
  final LibraryBuilder library;

  const ModelDelegateBuilder(this.options, this.library);

  // Build model delegates.
  void build() {
    for (final dmmf.ModelMapping modelMapping
        in options.dmmf.mappings.modelOperations) {
      library.body.add(Class((ClassBuilder classBuilder) {
        // Delegate class name.
        classBuilder.name = modelDelegateClassname(modelMapping.model);

        // Engine field.
        classBuilder.fields.add(Field((FieldBuilder fieldBuilder) {
          fieldBuilder.name = '_engine';
          fieldBuilder.type = refer('Engine', 'package:orm/orm.dart');
          fieldBuilder.modifier = FieldModifier.final$;
        }));

        // Header field.
        classBuilder.fields.add(Field((FieldBuilder fieldBuilder) {
          fieldBuilder.name = '_headers';
          fieldBuilder.type =
              TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
            typeReferenceBuilder.symbol = 'PrismaNullable';
            typeReferenceBuilder.url = 'package:orm/orm.dart';
            typeReferenceBuilder.types.add(
              refer('QueryEngineRequestHeaders', 'package:orm/orm.dart'),
            );
          });
          fieldBuilder.modifier = FieldModifier.final$;
        }));

        // Constructor.
        classBuilder.constructors
            .add(Constructor((ConstructorBuilder constructorBuilder) {
          constructorBuilder.name = '_';
          constructorBuilder.constant = true;

          // Add engine parameter, is required.
          constructorBuilder.requiredParameters
              .add(Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = '_engine';
            parameterBuilder.toThis = true;
          }));

          // Add header parameter, is optional.
          constructorBuilder.optionalParameters
              .add(Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = '_headers';
            parameterBuilder.toThis = true;
          }));
        }));

        // Build methods.
        final Map<String, String> json = modelMapping.toJson().cast();
        for (final String operation in modelMapping.operations) {
          final String? gqlOperationName = json[operation];
          if (gqlOperationName == null) continue;

          classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
            methodBuilder.returns = _findReturnType(gqlOperationName);
            methodBuilder.name = operation;
            methodBuilder.modifier = MethodModifier.async;

            // Add named parameters.
            methodBuilder.optionalParameters
                .addAll(_findParameters(gqlOperationName));

            // Body of method.
            methodBuilder.body =
                _methodBodyBuilder(gqlOperationName, modelMapping.model);
          }));
        }
      }));
    }
  }

  /// Find arguments of the operation
  Iterable<Parameter> _findParameters(String name) {
    final dmmf.SchemaField field =
        gqlMethods.firstWhere((element) => element.name == name);

    return field.args.map(
      (dmmf.SchemaArg element) => Parameter(
        (ParameterBuilder parameterBuilder) {
          parameterBuilder.type = scalar(element.inputTypes.first,
              element.isNullable || !element.isRequired);

          if (element.inputTypes.length > 1) {
            parameterBuilder.type = buildParameterUnionType(name, element);
            print(parameterBuilder.type);
          }

          parameterBuilder.name = languageKeywordEncode(element.name);
          parameterBuilder.named = true;
          parameterBuilder.required = element.isRequired;
        },
      ),
    );
  }

  /// Build parameter union type.
  Reference buildParameterUnionType(String action, dmmf.SchemaArg arg) {
    final String classname =
        dartClassnameFixer(action) + dartClassnameFixer(arg.name);
    final Class classBuilder = Class((ClassBuilder classBuilder) {
      classBuilder.name = classname;
      classBuilder.annotations.add(refer('freezed'));
      classBuilder.implements
          .add(refer('JsonSerializable', 'package:orm/orm.dart'));
      classBuilder.mixins.add(refer('_\$$classname'));

      for (final dmmf.SchemaType type in arg.inputTypes) {
        classBuilder.constructors
            .add(Constructor((ConstructorBuilder constructorBuilder) {
          constructorBuilder.name =
              'with${dartClassnameFixer(type.type)}${type.isList ? 'List' : ''}';
          constructorBuilder.constant = true;
          constructorBuilder.factory = true;
          constructorBuilder.redirect = refer(
              '_$classname${dartClassnameFixer(constructorBuilder.name!)}');
          constructorBuilder.requiredParameters
              .add(Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = 'value';
            parameterBuilder.type = scalar(type, false);
          }));
        }));
      }

      // Add fromJson factory.
      // Add fromJson constructor.
      classBuilder.constructors.add(Constructor(
        (ConstructorBuilder builder) {
          builder.name = 'fromJson';
          builder.requiredParameters.add(Parameter(
            (ParameterBuilder builder) {
              builder.name = 'json';
              builder.type = Reference('Map<String, dynamic>');
            },
          ));

          builder.body = Code('_\$${classBuilder.name}FromJson(json)');
          builder.lambda = true;
          builder.factory = true;
        },
      ));
    });

    library.body.add(classBuilder);

    return refer(classname + ((arg.isNullable || !arg.isRequired) ? '?' : ''));
  }

  /// Find GraphQL operation return type.
  Reference _findReturnType(String name) {
    final dmmf.SchemaField field =
        gqlMethods.firstWhere((element) => element.name == name);

    return TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
      typeReferenceBuilder.symbol = 'Future';
      bool isNullable = field.isNullable ?? true;
      if (isOrThrowOperation(field.name)) {
        isNullable = false;
      }

      typeReferenceBuilder.types.add(scalar(field.outputType, isNullable));
    });
  }

  /// Operation is or throw.
  bool isOrThrowOperation(String name) {
    return name.toLowerCase().endsWith('OrThrow'.toLowerCase());
  }

  List<dmmf.SchemaField> get gqlMethods => mergedOutputObjectTypes
      .where((element) {
        return ['query', 'mutation'].contains(element.name.toLowerCase());
      })
      .expand((element) => element.fields)
      .toList();

  List<dmmf.OutputType> get mergedOutputObjectTypes => [
        ...options.dmmf.schema.outputObjectTypes.prisma,
        ...options.dmmf.schema.outputObjectTypes.model ?? [],
      ];

  /// Find GraphQL operation location.
  String _findOperationLocation(String name) {
    final Iterable<dmmf.OutputType> query = mergedOutputObjectTypes
        .where((element) => element.name.toLowerCase() == 'query');
    for (final dmmf.OutputType outputType in query) {
      for (final dmmf.SchemaField field in outputType.fields) {
        if (field.name == name) {
          return 'query';
        }
      }
    }

    final Iterable<dmmf.OutputType> mutation = mergedOutputObjectTypes
        .where((element) => element.name.toLowerCase() == 'mutation');
    for (final dmmf.OutputType outputType in mutation) {
      for (final dmmf.SchemaField field in outputType.fields) {
        if (field.name == name) {
          return 'mutation';
        }
      }
    }

    throw Exception('Cannot find operation location of $name');
  }

  /// Method body builder.
  Code _methodBodyBuilder(String name, String modelname) {
    final dmmf.SchemaField field =
        gqlMethods.firstWhere((element) => element.name == name);

    return Block((BlockBuilder blockBuilder) {
      final Expression args =
          refer('GraphQLArgs', 'package:orm/orm.dart').newInstance(
        [
          literalList(field.args.map((element) {
            return refer('GraphQLArg', 'package:orm/orm.dart').newInstance([
              literalString(element.name),
              refer(languageKeywordEncode(element.name))
            ], {
              'isRequired': literalBool(element.isRequired),
            });
          })),
        ],
      );
      final Expression fields =
          refer('GraphQLFields', 'package:orm/orm.dart').newInstance([
        refer('${dartClassnameFixer(modelname)}ScalarFieldEnum')
            .property('values')
            .property('map')
            .call([
              Method((MethodBuilder methodBuilder) {
                methodBuilder.requiredParameters
                    .add(Parameter((parameterBuilder) {
                  parameterBuilder.name = 'e';
                  parameterBuilder.type =
                      refer('${dartClassnameFixer(modelname)}ScalarFieldEnum');
                }));

                methodBuilder.body =
                    refer('GraphQLField', 'package:orm/orm.dart').newInstance(
                  [
                    refer('languageKeywordDecode', 'package:orm/orm.dart')
                        .call([
                      refer('e').property('name'),
                    ]),
                  ],
                ).code;

                methodBuilder.lambda = true;
              }).closure,
            ])
            .property('toList')
            .call([]),
      ]);

      final Expression method =
          refer('GraphQLField', 'package:orm/orm.dart').newInstance([
        literalString(name)
      ], {
        'args': args,
        'fields': fields,
      });

      final Expression rootFields =
          refer('GraphQLFields', 'package:orm/orm.dart').newInstance([
        literalList([method]),
      ]);

      // Build GraphQL SDL.
      final Expression sdl = declareFinal(
        'sdl',
        type: refer('String'),
      ).assign(
        refer('GraphQLField', 'package:orm/orm.dart')
            .newInstance([
              literalString(_findOperationLocation(name)),
            ], {
              'fields': rootFields,
            })
            .property('toSdl')
            .call([]),
      );

      blockBuilder.addExpression(sdl);

      // Build QueryEngineResult.
      final Expression result = declareFinal(
        'result',
        type: refer('QueryEngineResult', 'package:orm/orm.dart'),
      ).assign(
        refer('_engine').property('request').call([], {
          'query': refer('sdl'),
          'headers': refer('_headers'),
        }).awaited,
      );

      blockBuilder.addExpression(result);

      // Create return statement.
      final Expression data =
          refer('result').property('data').index(literalString(name));

      // If field output type is List
      if (field.outputType.isList) {
        final Expression listReturn = data
            .asA(TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
              typeReferenceBuilder.symbol = 'List';
              typeReferenceBuilder.isNullable = true;
            }))
            .property('whereType')
            .call([], {}, [refer('Map')])
            .property('map')
            .call([
              Method((MethodBuilder methodBuilder) {
                methodBuilder.requiredParameters
                    .add(Parameter((parameterBuilder) {
                  parameterBuilder.name = 'e';
                  parameterBuilder.type = refer('Map');
                }));

                methodBuilder.body = scalarForString(
                  dartClassnameFixer(field.outputType.type),
                  false,
                ).newInstanceNamed('fromJson', [
                  refer('e').property('cast').call([]),
                ]).code;

                methodBuilder.lambda = true;
              }).closure,
            ])
            .property('toList')
            .call([])
            .returned;
        blockBuilder.addExpression(listReturn);
        return;
      }

      // Raw return.
      if (scalarReferneces.keys.contains(field.outputType.type.toLowerCase())) {
        blockBuilder.addExpression(data.returned);
        return;
      }

      final Expression deserialize = scalarForString(
        dartClassnameFixer(field.outputType.type),
        false,
      ).newInstanceNamed('fromJson', [
        data.asA(refer('Map')).property('cast').call([]),
      ]);

      bool isNullable = field.isNullable ?? true;
      if (isOrThrowOperation(name)) {
        isNullable = false;
      }

      if (isNullable) {
        final Expression nullableReturn = data
            .equalTo(literalNull)
            .conditional(literalNull, deserialize)
            .returned;
        blockBuilder.addExpression(nullableReturn);
        return;
      }

      blockBuilder.addExpression(deserialize.returned);
    });
  }
}
