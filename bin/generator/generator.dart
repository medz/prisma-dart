import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:code_builder/code_builder.dart' as code;
import 'package:crypto/crypto.dart' as crypto;
import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:path/path.dart' as path;
import 'package:orm/dmmf.dart' as dmmf;

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
    generatePrismaOutputTypes();
    generatePrismaAggregateFluent();
    generateDatasourcesClass();
    generatePrismaClient();
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
    library.directives.add(
        code.Directive.import('package:json_annotation/json_annotation.dart'));
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
        // library.directives.add(code.Directive.export(
        //   packages.orm,
        //   show: [element.name],
        // ));
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

    // Find list type
    final listTypes = types.where((e) => e.isList);
    if (listTypes.isNotEmpty) {
      return scalar(listTypes.first, !field.isRequired);
    }

    // find non scalar type
    final nonScalarTypes =
        types.where((e) => e.location != dmmf.FieldLocation.scalar);
    if (nonScalarTypes.isNotEmpty) {
      return scalar(nonScalarTypes.first, !field.isRequired);
    }

    return scalar(types.first, !field.isRequired);

    // TODO: Build union type
    // Build union type
    // final reference = code.TypeReference((code.TypeReferenceBuilder updates) {
    //   updates
    //     ..symbol = 'PrismaUnion${types.length}'
    //     ..url = packages.orm
    //     ..types.addAll(types.map((e) => scalar(e, false)));
    // });

    // return field.isRequired ? reference : reference.nullable;
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
      return _buildModelResultsCompiler(field);

      // If output is `*GroupByOutputType`, return the group by results.
    } else if (field.outputType.isList &&
        field.outputType.type.endsWith('GroupByOutputType')) {
      final type = _findPrismaOutputType(field.outputType.type);
      final fields = type.fields
          .where((element) =>
              element.outputType.location == dmmf.FieldLocation.scalar)
          .map((e) => e.name);

      return _buildModelResultsCompiler(field, fields: fields);

      // If output is `AffectedRowsOutput`, return the affected rows.
    } else if (field.outputType.type == 'AffectedRowsOutput' ||
        field.outputType.type.endsWith('CountOutputType')) {
      final type = _findPrismaOutputType(field.outputType.type);
      final fields = type.fields.map((e) => e.name);

      return _buildModelResultsCompiler(field, fields: fields);
    } else if (field.outputType.location == dmmf.FieldLocation.scalar) {
      return _buildModelScalarCompiler(field);
    } else if (field.outputType.location == dmmf.FieldLocation.enumTypes) {
      return _buildModelEnumCompiler(field);
    }
    return [
      code.refer(field.outputType.type.toDartClassname()).newInstance([
        code.refer('query'),
      ]).returned,
    ];
  }

  /// Build model enum compiler
  Iterable<code.Expression> _buildModelEnumCompiler(dmmf.SchemaField field) {
    final enumDecodeName =
        field.isNullable == true ? r'$enumDecodeNullable' : r'$enumDecode';
    final enumName = '_\$${field.outputType.type.toDartClassname()}EnumMap';
    final fn = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'value';
      }));

      updates.body = code.refer(enumDecodeName).call([
        code.refer(enumName),
        code.refer('value'),
      ]).code;
      updates.lambda = true;
    });

    final query = code
        .refer('query')
        .call([code.literalConstList([])])
        .property('then')
        .call([fn.closure]);

    return [query.returned];
  }

  /// Build model scalar compiler
  Iterable<code.Expression> _buildModelScalarCompiler(dmmf.SchemaField field) {
    final typeName = field.outputType.type.toLowerCase().trim();
    if (typeName == 'datetime' || typeName == 'date') {
      final fn = code.Method((updates) {
        updates.requiredParameters.add(code.Parameter((updates) {
          updates.name = 'value';
        }));

        final parse = code.refer('DateTime').property('parse').call([
          code.refer('value'),
        ]);

        updates.lambda = true;
        updates.body = parse.code;
        if (field.isNullable == true) {
          updates.body = code
              .refer('value')
              .isA(code.refer('String'))
              .conditional(parse, code.literalNull)
              .code;
        }
      });

      final query = code
          .refer('query')
          .call([code.literalConstList([])])
          .property('then')
          .call([fn.closure]);
      return [query.returned];
    }

    final type = scalar(field.outputType);
    final fn = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'value';
      }));

      updates.body = code.refer('value').asA(type).code;
      updates.lambda = true;
    });

    final query = code
        .refer('query')
        .call([code.literalConstList([])])
        .property('then')
        .call([fn.closure]);

    return [query.returned];
  }

  /// Find prisma output type
  dmmf.OutputType _findPrismaOutputType(String name) {
    final types = options.dmmf.schema.outputObjectTypes.prisma;

    return types.firstWhere((e) => e.name == name);
  }

  /// Is model fluent output type
  bool _isModelListOutputType(dmmf.SchemaType outputType) {
    final models = options.dmmf.schema.outputObjectTypes.model;
    return models?.any((e) => e.name == outputType.type) == true &&
        outputType.isList;
  }

  /// Build model results compiler
  Iterable<code.Expression> _buildModelResultsCompiler(
    dmmf.SchemaField field, {
    Iterable<String>? fields,
  }) {
    final expressions = <code.Expression>[];

    final modelScalarEnumName =
        _buildModelScalarFieldEnumName(field.outputType.type).toDartClassname();
    final modelScalarFields = code
        .refer(modelScalarEnumName)
        .property('values')
        .property('toGraphQLFields')
        .call([]);
    final localMapCompiler = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'e';
      }));
      updates.body = code
          .refer('GraphQLField', packages.graphql)
          .newInstance([code.refer('e')]).code;
      updates.lambda = true;
    }).closure;
    final localFields = code
        .literalConstList(fields?.toList() ?? [])
        .property('map')
        .call([localMapCompiler]);

    code.Expression fieldsExpression =
        (fields == null || fields.isEmpty) ? modelScalarFields : localFields;

    if (field.name.toLowerCase().startsWith('groupby')) {
      final enumMapCompiler = code.Method((updates) {
        updates.requiredParameters.add(code.Parameter((updates) {
          updates.name = 'e';
        }));
        updates.body =
            code.refer('GraphQLField', packages.graphql).newInstance([
          code
              .refer('e')
              .property('originalName')
              .ifNullThen(code.refer('e').property('name'))
        ]).code;
        updates.lambda = true;
      }).closure;
      fieldsExpression =
          code.refer('by').property('map').call([enumMapCompiler]);
    }

    expressions.add(code.declareFinal('fields').assign(fieldsExpression));

    code.Reference type = code.refer('Map');
    if (field.outputType.isList) {
      type = code.TypeReference((updates) {
        updates.symbol = 'Iterable';
        updates.types.add(type);
      });
    }

    // Build compiler expression
    final compiler = code.Method((updates) {
      updates.name = 'compiler';
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = field.name.toDartPropertyName();
        updates.type = type;
      }));

      final serializer = code
          .refer(field.outputType.type.toDartClassname())
          .newInstanceNamed('fromJson', [
        code.refer(field.name.toDartPropertyName()).property('cast').call([]),
      ]).code;
      updates.body = serializer;

      if (field.outputType.isList) {
        final compiler = code.Method((updates) {
          updates.requiredParameters.add(code.Parameter((updates) {
            updates.name = field.name.toDartPropertyName();
            updates.type = code.refer('Map');
          }));
          updates.lambda = true;
          updates.body = serializer;
        });
        updates.body = code
            .refer(field.name.toDartPropertyName())
            .property('map')
            .call([compiler.closure]).code;
      }

      updates.lambda = true;
    });

    expressions.add(compiler.closure);

    final then = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'json';
      }));
      updates.lambda = true;

      final call = field.outputType.isList
          ? code.refer('json').property('cast').call([])
          : code.refer('json');

      final compiler = code.refer('compiler').call([call]);
      final thrown = code.refer('Exception').newInstance([
        code.literalString('Unable to parse response'),
      ]).thrown;

      final other =
          _isOperationReturnTypeNullable(field) ? code.literalNull : thrown;
      final $type = field.outputType.isList ? code.refer('Iterable') : type;

      updates.body =
          code.refer('json').isA($type).conditional(compiler, other).code;
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
    final thrown = code.refer('Exception').newInstance([
      code.literalString('Not found ${field.outputType.type}'),
    ]).thrown;

    final then = code.Method((updates) {
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'json';
      }));

      updates.body = code
          .refer('json')
          .isA(code.refer('Map'))
          .conditional(serializer,
              _isOperationReturnTypeNullable(field) ? code.literalNull : thrown)
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
      if (field == null) continue;

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
      updates.body = code.Block((updates) => _modelFluentMethodBodyBuilder(
            updates,
            field,
          ));
    });
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

    if (_isAggregate(field.outputType.type)) {
      return type;
    }

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

/// Prisma output type generator
extension PrismaOutputTypeGenerator on Generator {
  /// Json serializable prisma output types
  static final _jsonSerializablePrismaOutputTypes = [
    (String type) => type.endsWith('GroupByOutputType'),
    (String type) => type == 'AffectedRowsOutput',
    (String type) => type.endsWith('CountOutputType'),
  ];

  /// Generate prisma output types
  void generatePrismaOutputTypes() {
    final types = options.dmmf.schema.outputObjectTypes.prisma;
    final models = types.where((type) => _jsonSerializablePrismaOutputTypes
        .any((element) => element(type.name)));
    final filitedModels = models
        .map((e) => _withoutAggregateOutputTypeField(e))
        .map((e) => _rebuildGroupByOutputtypeFields(e));

    library.body.addAll(filitedModels.map((e) => _buildScalarModel(e)));
  }

  /// Rebuild group by output type fields
  dmmf.OutputType _rebuildGroupByOutputtypeFields(dmmf.OutputType output) {
    final fields = output.fields.map((e) => _rebuildGroupByOutputTypeField(e));

    return dmmf.OutputType(
      name: output.name,
      fields: fields.toList(),
    );
  }

  /// Rebuild group by output type field
  dmmf.SchemaField _rebuildGroupByOutputTypeField(dmmf.SchemaField field) {
    return dmmf.SchemaField(
      name: field.name,
      isNullable: true,
      outputType: field.outputType,
      args: field.args,
      deprecation: field.deprecation,
      documentation: field.documentation,
    );
  }

  /// Without count aggregate output type field
  dmmf.OutputType _withoutAggregateOutputTypeField(dmmf.OutputType output) {
    final fields = output.fields.where(
        (element) => !element.outputType.type.endsWith('AggregateOutputType'));

    return dmmf.OutputType(
      name: output.name,
      fields: fields.toList(),
    );
  }
}

/// Prisma Aggregation fluent generator
extension PrismaAggregationFluentGenerate on Generator {
  /// Generate prisma aggregation fluent
  void generatePrismaAggregateFluent() {
    final types = options.dmmf.schema.outputObjectTypes.prisma
        .where((element) => _isAggregate(element.name));

    library.body.addAll(types.map((e) => _buildAggregateFluent(e)));
  }

  /// Is aggregate output type
  bool _isAggregate(String type) {
    return type.endsWith('AggregateOutputType') || type.startsWith('Aggregate');
  }

  /// Build aggregate fluent
  code.Class _buildAggregateFluent(dmmf.OutputType output) {
    Iterable<dmmf.SchemaField> fields = output.fields;
    if (output.name.startsWith('Aggregate')) {
      fields = fields.map((e) => dmmf.SchemaField(
            name: e.name,
            isNullable: false,
            outputType: e.outputType,
            args: e.args,
            deprecation: e.deprecation,
            documentation: e.documentation,
          ));
    }

    return code.Class((updates) {
      updates
        ..name = output.name.toDartClassname()
        ..fields.addAll(_buildAggregateFluentFields())
        ..constructors.add(_buildAggregateFluentConstructor())
        ..methods.addAll(fields.map((e) => _buildFluentMethod(e)));
    });
  }

  /// Build aggregate fluent fields
  Iterable<code.Field> _buildAggregateFluentFields() {
    return [
      code.Field((updates) {
        updates.name = r'$query';
        updates.type = code.refer('PrismaFluentQuery', packages.orm);
        updates.modifier = code.FieldModifier.final$;
      })
    ];
  }

  /// Build aggregate fluent constructor
  code.Constructor _buildAggregateFluentConstructor() {
    return code.Constructor((updates) {
      updates.requiredParameters.add(
        code.Parameter((updates) {
          updates.name = r'$query';
          updates.toThis = true;
        }),
      );
      updates.constant = true;
    });
  }
}

/// Datasources class generator
extension DatasourcesClassGenerator on Generator {
  /// Generate datasources class
  void generateDatasourcesClass() {
    final datasources = options.datasources;

    library.body.add(_buildDatasourcesClass(datasources));
  }

  /// Build datasources class
  code.Class _buildDatasourcesClass(Iterable<Datasource> datasources) {
    return code.Class((updates) {
      updates
        ..name = 'Datasources'
        ..fields.addAll(_buildDatasourcesFields(datasources))
        ..constructors.add(_buildDatasourcesConstructor(datasources))
        ..methods.add(_buildDatasourcesToJsonMethod())
        ..implements.add(code.refer('JsonSerializable', packages.orm));
      updates.annotations.add(code.refer('JsonSerializable').newInstance([], {
        'createFactory': code.literalFalse,
        'createToJson': code.literalTrue,
        'includeIfNull': code.literalFalse,
      }));
    });
  }

  /// Build datasources fields
  Iterable<code.Field> _buildDatasourcesFields(
      Iterable<Datasource> datasources) {
    return datasources.map((e) => code.Field((updates) {
          updates
            ..name = e.name
            ..type = code.refer('String').nullable
            ..modifier = code.FieldModifier.final$;
        }));
  }

  /// Build datasources constructor
  code.Constructor _buildDatasourcesConstructor(
      Iterable<Datasource> datasources) {
    return code.Constructor((updates) {
      updates.optionalParameters.addAll(
        datasources.map((e) => code.Parameter((updates) {
              updates.name = e.name;
              updates.toThis = true;
              updates.required = false;
              updates.named = true;

              if (e.url.value != null) {
                updates.defaultTo =
                    code.literalString(e.url.value!, raw: true).code;
              }
            })),
      );
      updates.constant = true;
    });
  }

  /// Build datasources to json method
  code.Method _buildDatasourcesToJsonMethod() {
    return code.Method((updates) {
      updates.name = 'toJson';
      updates.returns = code.refer('Map<String, dynamic>');
      updates.body =
          code.refer('_\$DatasourcesToJson').call([code.refer('this')]).code;
      updates.lambda = true;
      updates.annotations.add(code.refer('override'));
    });
  }
}

/// Prisma client generator
extension PrismaClientGenerator on Generator {
  static const String className = 'PrismaClient';

  /// Generate prisma client
  void generatePrismaClient() {
    library.body.add(code.Class((updates) {
      updates.name = className;
      updates.extend = code.TypeReference((updates) {
        updates.symbol = 'BasePrismaClient';
        updates.url = packages.orm;
        updates.types.add(code.refer(className));
      });
      updates.fields.addAll(_buildPrismaClientFields());
      updates.constructors.addAll(_buildPrismaClientConstructors());
      updates.methods.add(_buildPrismaClientCopyWithMethod());
      updates.methods.addAll(_buildPrismaClientModelDelegates());
    }));
  }

  /// Build prisma client Model delegates
  Iterable<code.Method> _buildPrismaClientModelDelegates() {
    final models = options.dmmf.mappings.modelOperations.map((e) => e.model);
    return models.map((e) => _buildPrismaClientModelDelegate(e));
  }

  /// Build prisma client Model delegate
  code.Method _buildPrismaClientModelDelegate(String model) {
    return code.Method((updates) {
      final type = code.TypeReference((updates) {
        updates.symbol = 'ModelDelegate';
        updates.url = packages.orm;
        updates.types.add(code.refer(model.toDartClassname()));
      });

      updates.name = model.toDartPropertyName();
      updates.returns = type;
      updates.type = code.MethodType.getter;

      updates.body = type.newInstance([
        code.refer('_engine')
      ], {
        'headers': code.refer('_headers'),
        'transaction': code.refer('_transaction'),
      }).code;
      updates.lambda = true;
    });
  }

  /// Build prisma client copy with method
  code.Method _buildPrismaClientCopyWithMethod() {
    return code.Method((updates) {
      updates.name = 'copyWith';
      updates.returns = code.refer(className);
      updates.annotations.add(code.refer('override'));
      updates.optionalParameters.add(code.Parameter((updates) {
        updates.name = 'headers';
        updates.named = true;
        updates.type = code
            .refer('QueryEngineRequestHeaders', packages.engineCore)
            .nullable;
      }));
      updates.optionalParameters.add(code.Parameter((updates) {
        updates.name = 'transaction';
        updates.named = true;
        updates.type =
            code.refer('TransactionInfo', packages.engineCore).nullable;
      }));
      updates.body = code.refer(className).newInstanceNamed('_internal', [
        code.refer('_engine'),
      ], {
        'headers': code.refer('headers').ifNullThen(code.refer('_headers')),
        'transaction':
            code.refer('transaction').ifNullThen(code.refer('_transaction')),
      }).code;
      updates.lambda = true;
    });
  }

  /// Build prisma client fields
  Iterable<code.Field> _buildPrismaClientFields() {
    return [
      // Build `_engine` field
      code.Field((updates) {
        updates
          ..name = '_engine'
          ..type = code.refer('Engine', packages.engineCore)
          ..modifier = code.FieldModifier.final$;
      }),
      // build `_headers` field
      code.Field((updates) {
        updates
          ..name = '_headers'
          ..type = code
              .refer('QueryEngineRequestHeaders', packages.engineCore)
              .nullable
          ..modifier = code.FieldModifier.final$;
      }),
      // build `_transaction` field
      code.Field((updates) {
        updates
          ..name = '_transaction'
          ..type = code.refer('TransactionInfo', packages.engineCore).nullable
          ..modifier = code.FieldModifier.final$;
      }),
    ];
  }

  /// Build prisma client constructors
  Iterable<code.Constructor> _buildPrismaClientConstructors() {
    return [
      _buildPrismaClientInternalConstructor(),
      _buildPrismaClientDefaultConstructor(),
    ];
  }

  /// Build prisma client Internal constructor
  code.Constructor _buildPrismaClientInternalConstructor() {
    return code.Constructor((updates) {
      updates.name = '_internal';
      updates.requiredParameters.add(code.Parameter((updates) {
        updates.name = 'engine';
        updates.toThis = false;
        updates.type = code.refer('Engine', packages.engineCore);
      }));
      updates.optionalParameters.add(code.Parameter((updates) {
        updates.name = 'headers';
        updates.named = true;
        updates.toThis = false;
        updates.type = code
            .refer('QueryEngineRequestHeaders', packages.engineCore)
            .nullable;
      }));
      updates.optionalParameters.add(code.Parameter((updates) {
        updates.name = 'transaction';
        updates.named = true;
        updates.toThis = false;
        updates.type =
            code.refer('TransactionInfo', packages.engineCore).nullable;
      }));

      updates.initializers
          .add(code.refer('_engine').assign(code.refer('engine')).code);
      updates.initializers
          .add(code.refer('_headers').assign(code.refer('headers')).code);
      updates.initializers.add(
          code.refer('_transaction').assign(code.refer('transaction')).code);
      updates.initializers.add(code.refer('super').call(
        [
          code.refer('engine'),
        ],
        {
          'headers': code.refer('headers'),
          'transaction': code.refer('transaction'),
        },
      ).code);
    });
  }

  /// Build prisma client default constructor
  code.Constructor _buildPrismaClientDefaultConstructor() {
    return code.Constructor((updates) {
      updates.factory = true;
      updates.optionalParameters
          .addAll(_buildPrismaClientDefaultConstructorParams());
      updates.body = _buildPrismaClientDefaultConstructorBody();
    });
  }

  /// Build prisma client default constructor params
  Iterable<code.Parameter> _buildPrismaClientDefaultConstructorParams() {
    return [
      // Build `datasources` param
      code.Parameter((updates) {
        updates.name = 'datasources';
        updates.named = true;
        updates.type = code.refer('Datasources').nullable;
      }),
      // Build `stdout` param
      code.Parameter((updates) {
        updates.name = 'stdout';
        updates.named = true;
        updates.type = code.TypeReference((updates) {
          updates.symbol = 'Iterable';
          updates.types.add(code.refer('Event', packages.logger));
        }).nullable;
      }),
      // Build `event` param
      code.Parameter((updates) {
        updates.name = 'event';
        updates.named = true;
        updates.type = code.TypeReference((updates) {
          updates.symbol = 'Iterable';
          updates.types.add(code.refer('Event', packages.logger));
        }).nullable;
      }),
    ];
  }

  /// Build prisma client default constructor body
  code.Block _buildPrismaClientDefaultConstructorBody() {
    return code.Block((updates) {
      updates.addExpression(_buildLoggerVariable());
      updates.addExpression(_buildEngineVariable());
      updates.addExpression(_buildPrismaClientReturn());
    });
  }

  /// Build logger variable
  code.Expression _buildLoggerVariable() {
    final logger = code.refer('Logger', packages.logger).newInstance([], {
      'stdout': code.refer('stdout'),
      'event': code.refer('event'),
    });

    return code.declareFinal('logger').assign(logger);
  }

  /// Build engine variable
  code.Expression _buildEngineVariable() {
    final engine =
        options.dataProxy ? _buildDataProxyEngine() : _buildBinaryEngine();

    return code.declareFinal('engine').assign(engine);
  }

  /// Build binary engine
  code.Expression _buildBinaryEngine() {
    return code.refer('BinaryEngine', packages.binaryEngine).newInstance([], {
      'logger': code.refer('logger'),
      'schema': _buildBase64EncodedSchema(),
      'datasources': _buildDatasourcesToJson(),
      'executable': _findBinaryEngineExecutable(),
    });
  }

  /// Build base64 encoded schema
  code.Expression _buildBase64EncodedSchema() {
    final schema = options.datamodel;
    final encoded = convert.base64.encode(convert.utf8.encode(schema));

    return code.literalString(encoded, raw: true);
  }

  /// Build datasources to json
  code.Expression _buildDatasourcesToJson() {
    return code
        .refer('datasources')
        .nullSafeProperty('toJson')
        .call([])
        .property('cast')
        .call([])
        .ifNullThen(code.literalConstMap({}));
  }

  /// Find binary engine executable
  code.Expression _findBinaryEngineExecutable() {
    final executable = options.binaryPaths['queryEngine']?[info.platform];
    if (executable == null) {
      throw Exception(
          'Could not find query engine for platform ${info.platform}');
    }

    return code.literalString(executable, raw: true);
  }

  /// Build prisma client return
  code.Expression _buildPrismaClientReturn() {
    return code
        .refer(className)
        .newInstanceNamed('_internal', [code.refer('engine')]).returned;
  }

  /// Build data proxy engine
  code.Expression _buildDataProxyEngine() {
    return code
        .refer('DataProxyEngine', packages.dataProxyengine)
        .newInstance([], {
      'logger': code.refer('logger'),
      'schema': _buildBase64EncodedSchema(),
      'hash': _buildSchameHash(),
      'version': code.literalString(info.version),
      'endpoint': _buildDataProxyEndpoint(),
    });
  }

  /// Build schema hash
  code.Expression _buildSchameHash() {
    final schema = options.datamodel;
    final encoded = convert.base64.encode(convert.utf8.encode(schema));
    final digest = crypto.sha256.convert(convert.utf8.encode(encoded));

    return code.literalString(digest.toString(), raw: true);
  }

  /// Build data proxy endpoint
  code.Expression _buildDataProxyEndpoint() {
    final datasource = options.datasources.first;

    final other = datasource.url.value != null
        ? code.literalString(datasource.url.value!, raw: true)
        : code.refer('String').property('fromEnvironment').call([
            code.literalString(datasource.url.fromEnvVar!, raw: true),
          ]);

    final param = code
        .refer('datasources')
        .nullSafeProperty(datasource.name)
        .ifNullThen(other);

    return code.refer('Uri').property('parse').call([param]);
  }
}
