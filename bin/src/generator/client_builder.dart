import 'dart:convert';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/orm.dart' as runtime;
import 'package:path/path.dart';

import '../environment.dart';
import 'generator_options.dart';
import 'model_delegate_builder.dart';

class ClientBuilder {
  final GeneratorOptions options;
  final LibraryBuilder library;

  const ClientBuilder(this.options, this.library);

  /// Build prisma client
  void build() {
    library.body.add(Block((BlockBuilder blockBuilder) {
      blockBuilder.addExpression(createPrismaEnvironment());

      // Build dmmf block.
      blockBuilder.addExpression(
        declareFinal('dmmf', type: refer('Document', 'package:orm/dmmf.dart'))
            .assign(refer('Document', 'package:orm/dmmf.dart')
                .property('fromJson')
                .call([
          literalMap(options.dmmf.toJson(), refer('String'), refer('dynamic'))
        ])),
      );

      // Build schema block.
      blockBuilder.addExpression(
        declareFinal('schema', type: refer('String')).assign(
          refer('utf8', 'dart:convert').property('decode').call([
            refer('base64', 'dart:convert').property('decode').call([
              literalString(base64.encode(utf8.encode(options.schema)),
                  raw: true)
            ]),
          ]),
        ),
      );

      // Build query engine executable.
      if (!options.dataProxy) {
        blockBuilder.addExpression(
          declareConst('_executable', type: refer('String'))
              .assign(literalString(options.executable, raw: true)),
        );
      }
    }));

    // Build data source
    library.body.add(Class((ClassBuilder classBuilder) {
      classBuilder.name = 'Datasources';
      classBuilder.fields.addAll(options.datasources.map((element) {
        return Field((FieldBuilder fieldBuilder) {
          fieldBuilder.name = runtime.languageKeywordEncode(element.name);
          fieldBuilder.type = TypeReference((TypeReferenceBuilder builder) {
            builder.symbol = 'PrismaNullable';
            builder.url = 'package:orm/orm.dart';
            builder.types.add(refer('Datasource', 'package:orm/orm.dart'));
          });
          fieldBuilder.modifier = FieldModifier.final$;
        });
      }));
      classBuilder.constructors
          .add(Constructor((ConstructorBuilder constructorBuilder) {
        constructorBuilder.optionalParameters
            .addAll(options.datasources.map((element) {
          return Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = runtime.languageKeywordEncode(element.name);
            parameterBuilder.toThis = true;
            parameterBuilder.named = true;
            parameterBuilder.required = false;
          });
        }));
        classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
          methodBuilder.name = '_toOverwrites';
          methodBuilder.returns =
              TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
            typeReferenceBuilder.symbol = 'Map';
            typeReferenceBuilder.types.addAll([
              refer('String'),
              refer('Datasource', 'package:orm/orm.dart'),
            ]);
          });
          methodBuilder.body = Block((BlockBuilder blockBuilder) {
            blockBuilder.addExpression(declareFinal(r'$overwrites').assign(
              literalMap(
                options.datasources.asMap().map((key, value) {
                  return MapEntry(
                    value.name,
                    refer(runtime.languageKeywordEncode(value.name)),
                  );
                }),
                refer('String'),
                TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
                  typeReferenceBuilder.symbol = 'PrismaNullable';
                  typeReferenceBuilder.url = 'package:orm/orm.dart';
                  typeReferenceBuilder.types
                      .add(refer('Datasource', 'package:orm/orm.dart'));
                }),
              ).cascade('removeWhere').call([
                Method((MethodBuilder methodBuilder) {
                  methodBuilder.requiredParameters
                      .add(Parameter((ParameterBuilder parameterBuilder) {
                    parameterBuilder.name = '_';
                  }));
                  methodBuilder.requiredParameters
                      .add(Parameter((ParameterBuilder parameterBuilder) {
                    parameterBuilder.name = 'v';
                  }));
                  methodBuilder.body = refer('v').equalTo(literalNull).code;
                }).closure,
              ]),
            ));
            blockBuilder.addExpression(
              refer(r'$overwrites').property('cast').call([]).returned,
            );
          });
        }));
      }));
    }));

    // Build prisma client class
    library.body.add(Class((ClassBuilder classBuilder) {
      classBuilder.name = 'PrismaClient';

      // If [GeneratorPreviewFeatures.finalizer] is enabled, add finalizer
      // field.
      if (options.previewFeatures
          .contains(GeneratorPreviewFeatures.finalizer)) {
        classBuilder.fields.add(Field((FieldBuilder fieldBuilder) {
          fieldBuilder.name = '_finalizer';
          fieldBuilder.type = TypeReference((TypeReferenceBuilder builder) {
            builder.symbol = 'Finalizer';
            builder.types.add(refer('Engine', 'package:orm/orm.dart'));
          });
          fieldBuilder.static = true;
          fieldBuilder.modifier = FieldModifier.final$;
          fieldBuilder.assignment = fieldBuilder.type?.newInstance([
            Method((MethodBuilder methodBuilder) {
              methodBuilder.requiredParameters.add(
                Parameter((ParameterBuilder parameterBuilder) {
                  parameterBuilder.name = 'engine';
                  parameterBuilder.type =
                      refer('Engine', 'package:orm/orm.dart');
                  parameterBuilder.named = false;
                }),
              );
              methodBuilder.body =
                  refer('engine').property('stop').call([]).code;
            }).closure,
          ]).code;
        }));
      }

      // Engine field.
      classBuilder.fields.add(Field((FieldBuilder fieldBuilder) {
        fieldBuilder.name = '_engine';
        fieldBuilder.type = refer('Engine', 'package:orm/orm.dart');
        fieldBuilder.modifier = FieldModifier.final$;
      }));

      // headers field.
      classBuilder.fields.add(Field((FieldBuilder fieldBuilder) {
        fieldBuilder.name = '_headers';
        fieldBuilder.type = TypeReference((TypeReferenceBuilder builder) {
          builder.symbol = 'PrismaNullable';
          builder.url = 'package:orm/orm.dart';
          builder.types
              .add(refer('QueryEngineRequestHeaders', 'package:orm/orm.dart'));
        });
        fieldBuilder.modifier = FieldModifier.final$;
      }));

      // Create internal constructor.
      classBuilder.constructors
          .add(Constructor((ConstructorBuilder constructorBuilder) {
        constructorBuilder.name = '_';
        constructorBuilder.constant = true;

        // Add engine parameter.
        constructorBuilder.requiredParameters
            .add(Parameter((ParameterBuilder parameterBuilder) {
          parameterBuilder.name = '_engine';
          parameterBuilder.toThis = true;
        }));

        // Add headers parameter.
        constructorBuilder.optionalParameters
            .add(Parameter((ParameterBuilder parameterBuilder) {
          parameterBuilder.name = '_headers';
          parameterBuilder.toThis = true;
        }));
      }));

      // Create public constructor
      classBuilder.constructors
          .add(Constructor((ConstructorBuilder constructorBuilder) {
        constructorBuilder.name = null; // Default constructor.
        constructorBuilder.factory = true;

        // Add constructor datasources parameter.
        constructorBuilder.optionalParameters
            .add(Parameter((ParameterBuilder parameterBuilder) {
          parameterBuilder.name = 'datasources';
          parameterBuilder.named = true;
          parameterBuilder.type =
              TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
            typeReferenceBuilder.symbol = 'PrismaNullable';
            typeReferenceBuilder.url = 'package:orm/orm.dart';
            typeReferenceBuilder.types.add(refer('Datasources'));
          });
        }));

        // Add constructor log parameter.
        if (options.previewFeatures
            .contains(GeneratorPreviewFeatures.logging)) {
          constructorBuilder.optionalParameters
              .add(Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = 'log';
            parameterBuilder.named = true;
            parameterBuilder.type =
                TypeReference((TypeReferenceBuilder update) {
              update.symbol = 'Iterable';
              update.url = 'dart:core';
              update.types.add(
                refer('PrismaLogDefinition', 'package:orm/orm.dart'),
              );
            });

            parameterBuilder.defaultTo = literalConstList(
                    [], refer('PrismaLogDefinition', 'package:orm/orm.dart'))
                .code;
          }));
        }

        // Create public constructor body.
        constructorBuilder.body = Block((BlockBuilder blockBuilder) {
          // Create a engine.
          blockBuilder.addExpression(
            declareFinal(
              'engine',
              type: refer('Engine', 'package:orm/orm.dart'),
            ).assign(_createEngineInstance()),
          );

          // Create PrismaClient instance.
          blockBuilder.addExpression(
            declareFinal(
              'client',
              type: refer(classBuilder.name!),
            ).assign(
              refer(classBuilder.name!).newInstanceNamed('_', [
                refer('engine'),
                literalNull,
              ]),
            ),
          );

          if (options.previewFeatures
              .contains(GeneratorPreviewFeatures.finalizer)) {
            blockBuilder.addExpression(
              refer('_finalizer').property('attach').call([
                refer('client'),
                refer('engine'),
              ], {
                'detach': refer('client'),
              }),
            );
          }

          // Return a [this] instance.
          blockBuilder.addExpression(refer('client').returned);
        });
      }));

      // Create model delegates.
      for (final String modelname
          in options.dmmf.mappings.modelOperations.map((e) => e.model)) {
        classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
          methodBuilder.name =
              _firstLetterLowercase(runtime.languageKeywordEncode(modelname));
          methodBuilder.returns = refer(modelDelegateClassname(modelname));
          methodBuilder.type = MethodType.getter;
          methodBuilder.body =
              refer(modelDelegateClassname(modelname)).newInstanceNamed('_', [
            refer('_engine'),
            refer('_headers'),
          ]).code;
          methodBuilder.lambda = true;
        }));
      }

      // Create `$on` method.
      // Output:
      // void $on(
      //  Iterable<PrismaLogLevel> levels,
      //  PrismaLogHandler handler
      // ) => _engine.logEmitter.on(levels.toSet(), handler);
      if (options.previewFeatures.contains(GeneratorPreviewFeatures.logging)) {
        classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
          methodBuilder.name = r'$on';
          methodBuilder.requiredParameters.add(Parameter((ParameterBuilder b) {
            b.name = 'levels';
            b.type = TypeReference((TypeReferenceBuilder update) {
              update.symbol = 'Iterable';
              update.url = 'dart:core';
              update.types.add(
                refer('PrismaLogLevel', 'package:orm/orm.dart'),
              );
            });
          }));
          methodBuilder.requiredParameters.add(Parameter((ParameterBuilder b) {
            b.name = 'handler';
            b.type = refer('PrismaLogHandler', 'package:orm/orm.dart');
          }));
          methodBuilder.body =
              refer('_engine').property('logEmitter').property('on').call([
            refer('levels').property('toSet').call([]),
            refer('handler'),
          ]).code;
          methodBuilder.docs.add('''
/// The \$on() method allows you to subscribe to events.
/// 
/// All message use a [Exception] class wrapper.
/// 
/// Example:
/// ```dart
/// prisma.\$on([PrismaLogLevel.query], (e) {
///   if (e is PrismaQueryEvent) {
///     print(e.query);
///   }
/// });
/// ```''');
        }));
      }

      // Create `$connect` method.
      classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
        methodBuilder.name = r'$connect';
        methodBuilder.returns =
            TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
          typeReferenceBuilder.symbol = 'Future';
          typeReferenceBuilder.types.add(refer('void'));
        });
        methodBuilder.lambda = true;
        methodBuilder.body = refer('_engine').property('start').call([]).code;
        methodBuilder.docs.add('/// Connect to the database.');
      }));

      // Create `$disconnect` method.
      classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
        methodBuilder.name = r'$disconnect';
        methodBuilder.returns =
            TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
          typeReferenceBuilder.symbol = 'Future';
          typeReferenceBuilder.types.add(refer('void'));
        });
        methodBuilder.lambda = false;
        methodBuilder.docs.add('/// Disconnect from the database.');
        methodBuilder.modifier = MethodModifier.async;
        methodBuilder.body = Block((BlockBuilder blockBuilder) {
          blockBuilder.addExpression(
              refer('_engine').property('stop').call([]).awaited);

          if (options.previewFeatures
              .contains(GeneratorPreviewFeatures.finalizer)) {
            blockBuilder.addExpression(
                refer('_finalizer').property('detach').call([refer('this')]));
          }
        });
      }));

      // create `$transaction` method.
      if (!options.dataProxy) {
        classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
          // Generic type.
          final Reference genericType = refer('T');

          methodBuilder.types.add(genericType);
          methodBuilder.name = r'$transaction';
          methodBuilder.docs.addAll([
            '/// Interactive transactions.',
            '///',
            '/// Sometimes you need more control over what queries execute within a transaction. Interactive transactions are meant to provide you with an escape hatch.',
            '///',
            '/// **NOTE**: If you use interactive transactions, then you cannot use the [Data Proxy](https://prisma.pub/guides/preview-features#data-proxy) at the same time.',
            '///',
            '/// E.g:',
            '/// ```dart',
            '/// final prisma = PrismaClient();',
            '/// prisma.\$transaction((transaction) async {',
            '///   await transaction.user.create({ ... });',
            '///   await transaction.post.create({ ... });',
            '/// });',
            '/// ```',
          ]);
          methodBuilder.returns =
              TypeReference((TypeReferenceBuilder typeReferenceBuilder) {
            typeReferenceBuilder.symbol = 'Future';
            typeReferenceBuilder.types.add(genericType);
          });

          // Add required parameter.
          methodBuilder.requiredParameters
              .add(Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = 'fn';
            parameterBuilder.types.add(genericType);
            parameterBuilder.type =
                FunctionType((FunctionTypeBuilder functionTypeBuilder) {
              functionTypeBuilder.returnType = methodBuilder.returns;
              functionTypeBuilder.requiredParameters
                  .add(refer(classBuilder.name!));
            });
          }));

          // add optional parameter.
          methodBuilder.optionalParameters
              .add(Parameter((ParameterBuilder parameterBuilder) {
            parameterBuilder.name = 'options';
            parameterBuilder.type =
                refer('TransactionOptions?', 'package:orm/orm.dart');
          }));

          // The method is async.
          methodBuilder.modifier = MethodModifier.async;

          // Create method body.
          methodBuilder.body = Block((BlockBuilder blockBuilder) {
            blockBuilder.addExpression(CodeExpression(
              Code(r'if (_headers?.transactionId != null) return fn(this)'),
            ));
            // Create a transaction header.
            blockBuilder.addExpression(
              declareFinal(
                'headers',
                type: refer('TransactionHeaders', 'package:orm/orm.dart'),
              ).assign(
                refer('TransactionHeaders', 'package:orm/orm.dart')
                    .newInstance([]),
              ),
            );

            // Create a transaction.
            blockBuilder.addExpression(
              declareFinal(
                'info',
                type: refer('TransactionInfo', 'package:orm/orm.dart'),
              ).assign(
                refer('_engine').property('startTransaction').call([], {
                  'headers': refer('headers'),
                  'options': refer('options').ifNullThen(
                    refer('TransactionOptions', 'package:orm/orm.dart')
                        .newInstance([]),
                  ),
                }).awaited,
              ),
            );

            // Add a try catch block.
            blockBuilder.statements.add(Code(r'try {'));
            // blockBuilder.addExpression(CodeExpression(Code(r'try { null')));
            blockBuilder.addExpression(
              declareFinal('result', type: genericType).assign(
                refer('fn').call([
                  refer(classBuilder.name!).newInstanceNamed('_', [
                    refer('_engine'),
                    refer('QueryEngineRequestHeaders', 'package:orm/orm.dart')
                        .newInstance([], {
                      'transactionId': refer('info').property('id'),
                    }),
                  ]),
                ]).awaited,
              ),
            );
            blockBuilder.addExpression(
              refer('_engine').property('commitTransaction').call([], {
                'headers': refer('headers'),
                'info': refer('info'),
              }).awaited,
            );
            blockBuilder.addExpression(refer('result').returned);
            blockBuilder.statements.add(Code(r'} catch (e) {'));
            blockBuilder.addExpression(
              refer('_engine').property('rollbackTransaction').call([], {
                'headers': refer('headers'),
                'info': refer('info'),
              }).awaited,
            );
            blockBuilder.addExpression(refer('rethrow'));
            blockBuilder.statements.add(Code(r'}'));
          });
        }));
      }
    }));
  }

  // Create [PrismaEnvironment] future instance
  Expression createPrismaEnvironment() {
    final Reference prismaEnvironment = refer(
      'PrismaEnvironment',
      'package:orm/configure.dart',
    );
    final TypeReference future = TypeReference((TypeReferenceBuilder update) {
      update.symbol = 'Future';
      update.types.add(prismaEnvironment);
    });
    final Expression closure = Method((MethodBuilder update) {
      update.modifier = MethodModifier.async;
      update.returns = future;

      final Expression def = prismaEnvironment.newInstance([], {
        'includePlatformEnvironment': literalTrue,
      });
      update.body = def.code;

      final production = environment.production;
      if (production.existsSync()) {
        final String path = relative(relative(production.path),
            from: dirname(relative(options.output)));
        final Reference configurator =
            refer(environment.productionFunctionName, path);

        update.body = def.property('call').call([configurator]).code;
      }
    }).closure;

    return declareFinal('environment').assign(
      future.newInstance([closure]),
    );
  }

  /// Create engine instance.
  Expression _createEngineInstance() {
    // Create common named arguments.
    final Map<String, Expression> namedArguments = {
      'datasources': refer('datasources')
          .nullSafeProperty('_toOverwrites')
          .call([]).ifNullThen(literalMap({}, refer('String'),
              refer('Datasource', 'package:orm/orm.dart'))),
      'dmmf': refer('dmmf'),
      'schema': refer('schema'),
      'environment': refer('environment'),
    };

    // Add logEmitter.
    final logDefinitions =
        options.previewFeatures.contains(GeneratorPreviewFeatures.logging)
            ? refer('log')
            : literalConstList(
                [], refer('PrismaLogDefinition', 'package:orm/orm.dart'));
    namedArguments['logEmitter'] =
        refer('PrismaLogEmitter', 'package:orm/orm.dart')
            .newInstance([logDefinitions]);

    if (options.dataProxy) {
      return _createDataProxyEngineInstance(namedArguments);
    }

    return _createBinaryEngineInstance(namedArguments);
  }

  /// Create binary engine instance.
  Expression _createBinaryEngineInstance(
      Map<String, Expression> namedArguments) {
    return refer('BinaryEngine', 'package:orm/orm.dart').newInstance([], {
      ...namedArguments,
      'executable': refer('_executable'),
    });
  }

  /// Create data proxy engine instance.
  Expression _createDataProxyEngineInstance(
      Map<String, Expression> namedArguments) {
    final Iterable<Expression> datasources =
        options.datasources.map((DataSource datasource) {
      return refer('Datasource', 'package:orm/orm.dart').newInstance([], {
        'url': datasource.url.fromEnvVar == null
            ? literalNull
            : literalString(datasource.url.fromEnvVar!),
      });
    });

    return refer('DataProxyEngine', 'package:orm/orm.dart').newInstance([], {
      ...namedArguments,
      'intenalDatasources': literalList(datasources),
    });
  }
}

/// First letter of [name] is lowercased.
String _firstLetterLowercase(String name) {
  return '${name[0].toLowerCase()}${name.substring(1)}';
}
