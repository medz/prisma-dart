import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:code_builder/code_builder.dart' as code;
import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:path/path.dart' as path;
import 'package:prisma_dmmf/prisma_dmmf.dart' as dmmf;

import 'generator_options.dart';
import 'packages.dart' as packages;
import 'prisma_info.dart';
import 'scalars.dart';
import 'utils.dart';

class Generator {
  final PrismaInfo info;
  final int generatorId;
  final GeneratorOptions options;
  final code.LibraryBuilder library;

  Generator._internal({
    required this.info,
    required this.generatorId,
    required this.options,
    required this.library,
  });

  static Future<Generator> create({
    required PrismaInfo info,
    required code.LibraryBuilder library,
  }) async {
    final buffer = StringBuffer();
    final completer = Completer<Generator>();

    final subscription = stdin.transform(convert.utf8.decoder).listen((event) {
      buffer.write(event);
      // Try to parse event to JSON.
      //
      // If it fails, add it to the buffer and wait for the next event.
      try {
        final result = convert.json.decode(buffer.toString());
        buffer.clear();

        if (result['method'] == 'getManifest') {
          _onManifest(result['id']);
        } else if (result['method'] == 'generate') {
          File('dmmf.json')
              .writeAsStringSync(convert.json.encode(result['params']));
          final options = GeneratorOptions.fromJson(result['params']);
          final generator = Generator._internal(
            info: info,
            generatorId: result['id'],
            options: options,
            library: library,
          );

          completer.complete(generator);
        }
      } catch (_) {
        // noop
      }
    });

    final generator = await completer.future;
    await subscription.cancel();

    return generator;
  }

  static void _onManifest(int id) {
    final result = {
      'manifest': {
        "prettyName": "Prisma Dart Client",
        "defaultOutput": "../lib/prisma_client.dart",
        "requiresEngines": ["queryEngine"],
      }
    };
    final message = convert.json.encode({
      "jsonrpc": "2.0",
      'result': result,
      'id': id,
    });

    stderr.writeln(message);
  }

  Future<void> done() async {
    final message = convert.json.encode({
      "jsonrpc": "2.0",
      'result': null,
      'id': generatorId,
    });
    stderr.writeln(message);
  }

  void generate() {
    generateEnum();
    generateInputObjectTypes();
    generateScalarModels();
    generateModelFluent();
    generateModelDelegate();
    defineDirectives();
    writeLibrary();
  }
}

/// directives for the library
extension LibraryDirectives on Generator {
  /// Define the library directives
  void defineDirectives() {
    _imports();
    _parts();
  }

  /// Import packages
  void _imports() {
    library.directives.add(code.Directive.import(packages.jsonSerializable));
  }

  /// parts
  void _parts() {
    final basename = path.basename(_resolveOutputPath());
    final part = basename.endsWith('.dart')
        ? basename.substring(0, basename.length - 5)
        : basename;

    library.directives.add(code.Directive.part('$part.g.dart'));
  }
}

// Write the library to a file.
extension WriteLibrary on Generator {
  /// Dart emitter
  static final emitter = code.DartEmitter(
    allocator: code.Allocator.simplePrefixing(),
    orderDirectives: true,
    useNullSafetySyntax: true,
  );

  /// Dart formatter
  static final formatter = DartFormatter();

  /// Write library to file
  void writeLibrary() {
    final library = this.library.build();
    final original = library.accept(emitter);
    final formatted = formatter.format(original.toString());

    // Create output file.
    final output = File(_resolveOutputPath());
    if (!output.existsSync()) {
      output.createSync(recursive: true);
    }

    // Write to file.
    output.writeAsStringSync(formatted, mode: FileMode.write);
  }

  /// Resolve the output path
  String _resolveOutputPath() {
    if (options.generator.output?.value == null) {
      throw Exception('Output path is not defined.');
    }

    final filePath = options.generator.output!.value!;

    // If the path not is a dart file, add it.
    if (!filePath.endsWith('.dart')) {
      return path.join(filePath, 'prisma_client.dart');
    }

    return filePath;
  }
}

/// Enum generator
extension EnumGenerator on Generator {
  /// Ignore enum names
  static final Iterable<String> _ignoreEnumNames = [
    'TransactionIsolationLevel',
  ].map((e) => e.toLowerCase());

  void generateEnum() {
    _enumsBuilder(options.dmmf.schema.enumTypes.prisma);
    _enumsBuilder(options.dmmf.schema.enumTypes.model);
  }

  /// Build enums
  void _enumsBuilder(Iterable<dmmf.SchemaEnum>? enums) {
    if (enums == null || enums.isEmpty) {
      return;
    }

    for (final element in enums) {
      // If the enum name is in the ignore list, skip it.
      if (_ignoreEnumNames.contains(element.name.toLowerCase())) {
        library.directives.add(code.Directive.export(
          packages.orm,
          show: [element.name],
        ));
        continue;
      }

      // Add enum to library
      library.body.add(code.Enum((code.EnumBuilder updates) {
        final values = _enumValuesBuilder(element.values);
        updates
          ..name = element.name.toDartClassname()
          ..values.addAll(values)
          ..implements.add(code.refer('PrismaEnum', packages.orm));

        /// Add `originalName` field getter
        updates.methods.add(code.Method((updates) {
          updates
            ..name = 'originalName'
            ..returns = code.refer('String').nullable
            ..lambda = true
            ..body = code.literalNull.code
            ..annotations.add(code.refer('override'))
            ..type = code.MethodType.getter;
        }));

        if (values.any((element) => element.arguments.isNotEmpty)) {
          // Clean enum method
          updates.methods.clear();

          // Add `originalName` field.
          updates.fields.add(code.Field((updates) {
            updates
              ..name = 'originalName'
              ..type = code.refer('String').nullable
              ..modifier = code.FieldModifier.final$
              ..annotations.add(code.refer('override'));
          }));

          // Add constructor
          updates.constructors.add(code.Constructor((updates) {
            updates.constant = true;
            updates.optionalParameters.add(code.Parameter((updates) {
              updates
                ..name = 'originalName'
                ..toThis = true
                ..named = false
                ..required = false;
            }));
          }));
        }
      }));
    }
  }

  /// Build enum values
  Iterable<code.EnumValue> _enumValuesBuilder(Iterable<String> values) {
    return values.map((e) {
      return code.EnumValue((code.EnumValueBuilder updates) {
        updates.name = e.toDartPropertyName();

        if (updates.name != e) {
          // Add annotation
          updates.annotations.add(
            code.refer('JsonValue').newInstance([code.literalString(e)]),
          );

          // Add original name argument
          updates.arguments.add(code.literalString(e, raw: true));
        }
      });
    });
  }
}

/// Input object types generator
extension InputObjectTypesGenerator on Generator {
  /// Generate input object types
  void generateInputObjectTypes() {
    _builder(options.dmmf.schema.inputObjectTypes.model);
    _builder(options.dmmf.schema.inputObjectTypes.prisma);
  }

  /// input object types builder
  void _builder(Iterable<dmmf.InputType>? types) {
    // If there are no types, skip it.
    if (types == null || types.isEmpty) {
      return;
    }

    library.body.addAll(types.map((e) => _buildClass(e)));
  }

  /// Build class
  code.Class _buildClass(dmmf.InputType input) {
    final classname = input.name.toDartClassname();
    return code.Class((code.ClassBuilder updates) {
      updates
        ..name = classname
        ..annotations.add(code.refer('jsonSerializable', packages.orm))
        ..implements.add(code.refer('JsonSerializable', packages.orm))
        ..methods.add(_buildToJsonMethod(classname));

      // Build fields & add fields.
      final fields = input.fields.map((e) => _buildField(e));
      updates.fields.addAll(fields);

      // Build constructors
      updates.constructors.addAll([
        // Default constructor
        _buildDefaultConstructor(fields),
        // From json constructor
        _buildFromJsonConstructor(classname),
      ]);
    });
  }

  /// Build field
  code.Field _buildField(dmmf.SchemaArg field) {
    return code.Field((code.FieldBuilder updates) {
      updates
        ..name = field.name.toDartPropertyName()
        ..type = _buildFieldType(field)
        ..modifier = code.FieldModifier.final$;

      // Add document comment
      if (field.comment != null) {
        updates.docs.addAll(field.comment!
            .split('\r')
            .map((e) => e.split('\n'))
            .expand((e) => e)
            .map((e) => e.trim()));
      }

      // Add JsonKey annotation
      if (updates.name != field.name) {
        updates.annotations.add(code.refer('JsonKey').newInstance([], {
          'name': code.literalString(field.name, raw: true),
        }));
      }

      // Add deprecation annotation
      if (field.deprecation != null) {
        updates.annotations.add(code.refer('Deprecated').newInstance([
          code.literalString(field.deprecation!.reason),
        ]));
      }
    });
  }

  /// Build field type
  code.Reference _buildFieldType(dmmf.SchemaArg field) {
    final types = field.inputTypes;

    // If the types is a single type, return it.
    if (types.length == 1) {
      return scalar(field.inputTypes.first, !field.isRequired);
    }

    // Build union type
    final reference = code.TypeReference((code.TypeReferenceBuilder updates) {
      updates
        ..symbol = 'PrismaUnion${types.length}'
        ..url = packages.orm
        ..types.addAll(types.map((e) => scalar(e, false)));
    });

    return field.isRequired ? reference : reference.nullable;
  }

  /// Build to json method
  ///
  /// With the help of the [json_serializable] package, the `toJson` method is generated.
  code.Method _buildToJsonMethod(String classname) {
    return code.Method((code.MethodBuilder updates) {
      updates
        ..name = 'toJson'
        ..returns = code.refer('Map<String, dynamic>')
        ..annotations.add(code.refer('override'))
        ..body =
            code.refer('_\$${classname}ToJson').call([code.refer('this')]).code
        ..lambda = true;
    });
  }

  /// Build default constructor
  code.Constructor _buildDefaultConstructor(Iterable<code.Field> fields) {
    return code.Constructor((code.ConstructorBuilder updates) {
      updates.constant = true;
      updates.optionalParameters.addAll(fields.map((e) {
        return code.Parameter((code.ParameterBuilder updates) {
          updates
            ..name = e.name
            ..named = true
            ..toThis = true
            ..required = _resolveReferenceRequired(e.type);
        });
      }));
    });
  }

  /// Resolve the reference is required
  bool _resolveReferenceRequired(code.Reference? reference) {
    if (reference is code.TypeReference) {
      return !(reference.isNullable ?? false);
    }

    return true;
  }

  /// Build from json constructor
  code.Constructor _buildFromJsonConstructor(String classname) {
    return code.Constructor((code.ConstructorBuilder updates) {
      updates
        ..name = 'fromJson'
        ..factory = true
        ..requiredParameters
            .add(code.Parameter((code.ParameterBuilder updates) {
          updates
            ..name = 'json'
            ..type = code.refer('Map<String, dynamic>');
        }))
        ..body = code
            .refer('_\$${classname}FromJson')
            .call([code.refer('json')]).code
        ..lambda = true;
    });
  }
}

/// Generate scalar models
extension ScalarModulesGenerator on Generator {
  /// Generate scalar models
  void generateScalarModels() {
    final types = options.dmmf.schema.outputObjectTypes.model;
    if (types == null || types.isEmpty) {
      return;
    }
    final scalarModels = types.map((e) => _filterModelNonScalarFields(e));

    library.body.addAll(scalarModels.map((e) => _buildScalarModel(e)));
  }

  /// Build scalar model
  code.Class _buildScalarModel(dmmf.OutputType model) {
    final classname = model.name.toDartClassname();
    return code.Class((updates) {
      updates
        ..name = classname
        ..implements.add(code.refer('JsonSerializable', packages.orm))
        ..annotations.add(code.refer('jsonSerializable', packages.orm))
        ..methods.add(_buildToJsonMethod(classname));

      // Build class fields
      final fields = model.fields.map((e) => _buildField(e));
      updates.fields.addAll(fields);

      // Build default constructor
      updates.constructors.add(_buildDefaultConstructor(fields));

      // Build from json constructor
      updates.constructors.add(_buildFromJsonConstructor(classname));
    });
  }

  /// Build field
  code.Field _buildField(dmmf.SchemaField field) {
    return code.Field((code.FieldBuilder updates) {
      updates
        ..name = field.name.toDartPropertyName()
        ..type = scalar(field.outputType, field.isNullable == true)
        ..modifier = code.FieldModifier.final$;

      // Add document comment
      if (field.documentation != null) {
        updates.docs.addAll(field.documentation!
            .split('\r')
            .map((e) => e.split('\n'))
            .expand((e) => e)
            .map((e) => e.trim()));
      }

      // Add JsonKey annotation
      if (updates.name != field.name) {
        updates.annotations.add(code.refer('JsonKey').newInstance([], {
          'name': code.literalString(field.name, raw: true),
        }));
      }

      // Add deprecation annotation
      if (field.deprecation != null) {
        updates.annotations.add(code.refer('Deprecated').newInstance([
          code.literalString(field.deprecation!.reason),
        ]));
      }
    });
  }

  /// Filter model non scalar fields
  dmmf.OutputType _filterModelNonScalarFields(dmmf.OutputType model) {
    return dmmf.OutputType(
      name: model.name,
      fields: model.fields
          .where((e) => _isModelScalarField(model.name, e.name))
          .toList(),
    );
  }

  /// Chech model scalar field
  bool _isModelScalarField(String model, String field) {
    final enumName = _buildModelScalarFieldEnumName(model).toLowerCase();
    final enums = options.dmmf.schema.enumTypes.prisma;
    final scalarEnum = enums.firstWhere(
      (e) => e.name.toLowerCase() == enumName,
      orElse: () => throw Exception('Enum $enumName not found'),
    );

    return scalarEnum.values.any((e) => e.toLowerCase() == field.toLowerCase());
  }

  /// Build model scalar field enum name
  String _buildModelScalarFieldEnumName(String model) =>
      '${model}ScalarFieldEnum';
}

/// Model fluent generator
extension ModelFluentGenerator on Generator {
  /// Generate model fluent
  void generateModelFluent() {
    final models = options.dmmf.schema.outputObjectTypes.model;
    if (models != null) {
      library.body.addAll(models.map((e) => _buildModelFluent(e)));
    }
  }

  /// Build model fluent
  code.Class _buildModelFluent(dmmf.OutputType model) {
    final fields = model.fields
        .where((element) => !_isModelScalarField(model.name, element.name));

    return code.Class((updates) {
      updates.name = _buildModelFluentName(model.name);
      updates.methods.addAll(fields.map((e) => _buildFluentMethod(e)));
      updates.extend = code.TypeReference((updates) {
        updates.symbol = 'PrismaFluent';
        updates.url = packages.orm;
        updates.types.add(code.refer('T'));
      });
      updates.types.add(code.refer('T'));

      // Build default constructor
      updates.constructors.add(code.Constructor((updates) {
        updates.constant = true;

        // `original` parameter
        updates.requiredParameters.addAll([
          code.Parameter((updates) {
            updates.name = 'original';
            updates.toSuper = true;
          }),
        ]);

        // `$query` parameter
        updates.requiredParameters.addAll([
          code.Parameter((updates) {
            updates.name = r'$query';
            updates.toSuper = true;
          }),
        ]);
      }));
    });
  }

  /// Build fluent method
  code.Method _buildFluentMethod(dmmf.SchemaField field) {
    return code.Method((updates) {
      updates.name = field.name.toDartPropertyName();
      updates.returns = _modelDelegateMethodReturnTypeBuilder(field);
      updates.optionalParameters
          .addAll(field.args.map((e) => _buildOperationParameter(e)));
      updates.body = code.Block(
          (updates) => _modelFluentMethodBodyBuilder(updates, field));
    });
  }

  /// Model Fluent method body builder
  void _modelFluentMethodBodyBuilder(
      code.BlockBuilder updates, dmmf.SchemaField field) {
    final args =
        field.args.map((e) => code.refer('GraphQLArg', packages.graphql).call([
              code.literalString(e.name, raw: true),
              code.refer(e.name.toDartPropertyName()),
            ]));
    if (args.isNotEmpty) {
      updates.addExpression(
          code.declareFinal('args').assign(code.literalList(args)));
    }

    final query = code
        .refer('PrismaFluent', packages.orm)
        .property('queryBuilder')
        .call([], {
      'query': code.Method((updates) {
        updates.requiredParameters.add(code.Parameter((updates) {
          updates.name = 'fields';
        }));

        final namedArguments = {
          'fields': code.refer('fields'),
        };
        if (args.isNotEmpty) {
          namedArguments['args'] = code.refer('args');
        }

        updates.body = code.refer(r'$query').call([
          code.literalList([
            code.refer('GraphQLField', packages.graphql).call(
                [code.literalString(field.name, raw: true)], namedArguments),
          ])
        ]).code;

        updates.lambda = true;
      }).closure,
      'key': code.literalString(field.name, raw: true),
    });
    updates.addExpression(code.declareFinal('query').assign(query));

    _buildModelCompiler(field)
        .forEach((element) => updates.addExpression(element));
  }

  /// Build model compiler
  Iterable<code.Expression> _buildModelCompiler(dmmf.SchemaField field) {
    // If the output type is a model, return a model fluent.
    if (_isModelFluentOutputType(field.outputType)) {
      return _buildModelFluentCompiler(field);

      // If output is a list, return the list results.
    } else if (_isModelListOutputType(field.outputType)) {
      return _buildModelListResultsCompiler(field);
    }

    return [
      code.refer(field.outputType.type.toDartClassname()).newInstance([
        code.refer('query'),
      ]).returned,
    ];
  }

  /// Is model fluent output type
  bool _isModelListOutputType(dmmf.SchemaType outputType) {
    final models = options.dmmf.schema.outputObjectTypes.model;
    return models?.any((e) => e.name == outputType.type) == true &&
        outputType.isList;
  }

  /// Build model list results compiler
  Iterable<code.Expression> _buildModelListResultsCompiler(
      dmmf.SchemaField field) {
    final expressions = <code.Expression>[];
    final modelScalarEnumName =
        _buildModelScalarFieldEnumName(field.outputType.type).toDartClassname();

    expressions.add(code.declareFinal('fields').assign(
          code
              .refer(modelScalarEnumName)
              .property('values')
              .property('toGraphQLFields')
              .call([]),
        ));

    // Build compiler expression
    final compiler = code.Method((updates) {
      updates.name = 'compiler';
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = field.name.toDartPropertyName();
        updates.type = code.TypeReference((updates) {
          updates.symbol = 'Iterable';
          updates.types.add(code.refer('Map'));
        });
      }));

      final compiler = code.Method((updates) {
        updates.requiredParameters.add(code.Parameter((updates) {
          updates.name = 'post';
          updates.type = code.refer('Map');
        }));
        updates.lambda = true;
        updates.body = code
            .refer(field.outputType.type.toDartClassname())
            .newInstanceNamed('fromJson', [
          code.refer('post').property('cast').call([]),
        ]).code;
      });

      updates.body = code
          .refer(field.name.toDartPropertyName())
          .property('map')
          .call([compiler.closure]).code;
      updates.lambda = true;
    });
    expressions.add(compiler.closure);

    final then = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'json';
      }));
      updates.lambda = true;

      final compiler = code.refer('compiler').call([code.refer('json')]);
      final thrown = code.refer('Exception').newInstance([
        code.literalString('Unable to parse response'),
      ]);
      final type = code.TypeReference((updates) {
        updates.symbol = 'Iterable';
        updates.types.add(code.refer('Map'));
      });

      updates.body = code
          .refer('json')
          .isA(type)
          .conditional(
              compiler, field.isNullable == true ? code.literalNull : thrown)
          .code;
    });

    final returns = code
        .refer('query')
        .call([code.refer('fields')])
        .property('then')
        .call([then.closure]);
    expressions.add(returns.returned);

    return expressions;
  }

  /// Build model fluent compiler
  Iterable<code.Expression> _buildModelFluentCompiler(dmmf.SchemaField field) {
    final expressions = <code.Expression>[];

    final modelScalarEnumName =
        _buildModelScalarFieldEnumName(field.outputType.type).toDartClassname();
    final fields = code
        .refer(modelScalarEnumName)
        .property('values')
        .property('toGraphQLFields')
        .call([]);
    final query = code.refer('query').call([fields]);
    final json = code.refer('json').property('cast').call([], {}, [
      code.refer('String'),
      code.refer('dynamic'),
    ]);
    final serializer = code
        .refer(field.outputType.type.toDartClassname())
        .property('fromJson')
        .call([json]);
    final thrown = code.refer('Exception').call([
      code.literalString('Not found ${field.outputType.type}'),
    ]).thrown;

    final then = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'json';
      }));

      updates.body = code
          .refer('json')
          .isA(code.refer('Map'))
          .conditional(
              serializer, field.isNullable == true ? code.literalNull : thrown)
          .code;
      updates.lambda = true;
    });
    final future = query.property('then').call([then.closure]);

    expressions.add(code.declareFinal('future').assign(future));

    final returnType = _modelDelegateMethodReturnTypeBuilder(field);
    expressions.add(returnType.newInstance([
      code.refer('future'),
      code.refer('query'),
    ]).returned);

    return expressions;
  }

  /// Build model fluent name
  String _buildModelFluentName(String model) {
    return '${model}Fluent'.toDartClassname();
  }
}

/// Model delegate generator
extension ModelDelegateGenerator on Generator {
  /// Generate model delegate
  void generateModelDelegate() {
    final modelOperations = options.dmmf.mappings.modelOperations;
    library.body.addAll(modelOperations.map((e) => _buildModelDelegate(e)));
  }

  /// Build model delegate
  code.Extension _buildModelDelegate(dmmf.ModelMapping mapping) {
    return code.Extension((e) => _modelDelegateClassBuilder(e, mapping));
  }

  /// Model delegate extension builder
  void _modelDelegateClassBuilder(
      code.ExtensionBuilder updates, dmmf.ModelMapping mapping) {
    updates.name = _generateModelDelegateName(mapping.model);
    updates.on = code.TypeReference((updates) {
      updates.symbol = 'ModelDelegate';
      updates.url = packages.orm;
      updates.types.add(code.refer(mapping.model.toDartClassname()));
    });

    final json = mapping.toJson().cast<String, String?>();
    for (final operation in mapping.operations) {
      final gqlOperation = json[operation];

      if (gqlOperation == null) continue;

      final field = _findQueryOrMutationField(gqlOperation);
      if (field == null ||
          !_isReturnScalarModelOperation(field, mapping.model)) {
        continue;
      }

      updates.methods.add(_modelDelegateMethodBuilder(
        operation,
        field,
      ));
    }
  }

  /// Model delegate method builder
  code.Method _modelDelegateMethodBuilder(
      String operation, dmmf.SchemaField field) {
    return code.Method((updates) {
      updates.name = operation.toDartPropertyName();
      updates.returns = _modelDelegateMethodReturnTypeBuilder(field);
      updates.optionalParameters
          .addAll(field.args.map((e) => _buildOperationParameter(e)));
      updates.body = code.Block((updates) => _modelDelegateMethodBodyBuilder(
            updates,
            field,
          ));
    });
  }

  /// Model delegate method body builder
  void _modelDelegateMethodBodyBuilder(
      code.BlockBuilder updates, dmmf.SchemaField field) {
    // Build args
    final args =
        field.args.map((e) => code.refer('GraphQLArg', packages.graphql).call([
              code.literalString(e.name, raw: true),
              code.refer(e.name.toDartPropertyName()),
            ]));
    updates.addExpression(
        code.declareFinal('args').assign(code.literalList(args)));

    // build fields update function
  }

  /// Build operation parameter
  code.Parameter _buildOperationParameter(dmmf.SchemaArg arg) {
    return code.Parameter((updates) {
      updates.name = arg.name.toDartPropertyName();
      updates.type = _buildFieldType(arg);
      updates.named = true;
      updates.required = arg.isRequired == true;
    });
  }

  /// Model delegate method return type builder
  code.Reference _modelDelegateMethodReturnTypeBuilder(dmmf.SchemaField field) {
    final type =
        scalar(field.outputType, _isOperationReturnTypeNullable(field));

    return code.TypeReference((updates) {
      updates
        ..symbol = 'Future'
        ..types.add(type);

      if (_isModelFluentOutputType(field.outputType)) {
        updates.symbol = _buildModelFluentName(field.outputType.type);
      }
    });
  }

  /// Is model fluent output type
  bool _isModelFluentOutputType(dmmf.SchemaType outputType) {
    final models = options.dmmf.schema.outputObjectTypes.model;

    return models?.any((e) => e.name == outputType.type) == true &&
        !outputType.isList;
  }

  /// Return type is nullable.
  bool _isOperationReturnTypeNullable(dmmf.SchemaField field) {
    // If ends with `OrThrow` then return type is not nullable
    if (field.name.toLowerCase().endsWith('orthrow')) return false;

    return field.isNullable == true;
  }

  /// Is return scalar model operation
  bool _isReturnScalarModelOperation(dmmf.SchemaField? field, String model) {
    return field?.outputType.type == model;
  }

  /// Find query or mutation field
  dmmf.SchemaField? _findQueryOrMutationField(String operation) {
    final types = options.dmmf.schema.outputObjectTypes.prisma;
    final fields = types
        .where((element) =>
            element.name.toLowerCase() == 'query' ||
            element.name.toLowerCase() == 'mutation')
        .expand((e) => e.fields);

    return fields.firstWhereOrNull((e) => e.name == operation);
  }

  /// Generate model delegate name
  String _generateModelDelegateName(String model) =>
      '${model}ModelDelegateExtension'.toDartClassname();
}

/// Iterable extensions
extension _IterableExtensions<T> on Iterable<T> {
  /// First where or null
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }

    return null;
  }
}
