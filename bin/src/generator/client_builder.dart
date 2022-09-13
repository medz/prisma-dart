import 'package:code_builder/code_builder.dart';
import 'package:orm/orm.dart' as runtime;

import 'generator_options.dart';
import 'model_delegate_builder.dart';

class ClientBuilder {
  final GeneratorOptions options;
  final LibraryBuilder library;

  const ClientBuilder(this.options, this.library);

  /// Build prisma client
  void build() {
    library.body.add(Block((BlockBuilder blockBuilder) {
      // Build dmmf block.
      blockBuilder.addExpression(
        refer('Document', 'package:orm/dmmf.dart')
            .property('fromJson')
            .call([literalMap(options.dmmf.toJson())]).assignFinal(
          'dmmf',
          refer('Document', 'package:orm/dmmf.dart'),
        ),
      );

      // Build schema block.
      blockBuilder.addExpression(
        literalString(options.schema).assignConst('schema', refer('String')),
      );

      // Build query engine executable.
      if (!options.dataProxy) {
        blockBuilder.addExpression(
          literalString(options.executable, raw: true)
              .assignConst('_executable', refer('String')),
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
            blockBuilder.addExpression(
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
              ]).assignFinal(r'$overwrites'),
            );
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

        // Add constructor parameter.
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

        // Create public constructor body.
        constructorBuilder.body = Block((BlockBuilder blockBuilder) {
          // Create a engine.
          blockBuilder.addExpression(_createEngineInstance()
              .assignFinal('engine', refer('Engine', 'package:orm/orm.dart')));

          // Return a [this] instance.
          blockBuilder
              .addExpression(refer(classBuilder.name!).newInstanceNamed('_', [
            refer('engine'),
            literalNull,
          ]).returned);
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
        methodBuilder.lambda = true;
        methodBuilder.body = refer('_engine').property('stop').call([]).code;
        methodBuilder.docs.add('/// Disconnect from the database.');
      }));

      // create `$transaction` method.
      classBuilder.methods.add(Method((MethodBuilder methodBuilder) {
        // Generic type.
        final Reference genericType = refer('T');

        methodBuilder.types.add(genericType);
        methodBuilder.name = r'$transaction';
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
              refer('TransactionHeaders', 'package:orm/orm.dart')
                  .newInstance([]).assignFinal('headers',
                      refer('TransactionHeaders', 'package:orm/orm.dart')));
          // Create a transaction.
          blockBuilder.addExpression(
            refer('_engine')
                .property('startTransaction')
                .call([], {
                  'headers': refer('headers'),
                })
                .awaited
                .assignFinal(
                    'info', refer('TransactionInfo', 'package:orm/orm.dart')),
          );

          // Add a try catch block.
          blockBuilder.statements.add(Code(r'try {'));
          // blockBuilder.addExpression(CodeExpression(Code(r'try { null')));
          blockBuilder.addExpression(
            refer('fn')
                .call([
                  refer(classBuilder.name!).newInstanceNamed('_', [
                    refer('_engine'),
                    refer('QueryEngineRequestHeaders', 'package:orm/orm.dart')
                        .newInstance([], {
                      'transactionId': refer('info').property('id'),
                    }),
                  ]),
                ])
                .awaited
                .assignFinal('result', genericType),
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
    }));
  }

  /// Create engine instance.
  Expression _createEngineInstance() {
    if (options.dataProxy) {
      // TODO: Implement data proxy.
    }

    return _createBinaryEngineInstance();
  }

  /// Create binary engine instance.
  Expression _createBinaryEngineInstance() {
    return refer('BinaryEngine', 'package:orm/orm.dart').newInstance([], {
      'datasources': refer('datasources')
          .nullSafeProperty('_toOverwrites')
          .call([]).ifNullThen(literalMap({}, refer('String'),
              refer('Datasource', 'package:orm/orm.dart'))),
      'dmmf': refer('dmmf'),
      'schema': refer('schema'),
      'executable': refer('_executable'),
      'environment':
          refer('environment', 'package:orm/configure.dart').property('all'),
    });
  }
}

/// First letter of [name] is lowercased.
String _firstLetterLowercase(String name) {
  return '${name[0].toLowerCase()}${name.substring(1)}';
}
