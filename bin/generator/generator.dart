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
        updates
          ..name = element.name.toDartClassname()
          ..values.addAll(_enumValuesBuilder(element.values));
      }));
    }
  }

  /// Build enum values
  Iterable<code.EnumValue> _enumValuesBuilder(Iterable<String> values) {
    return values.map((e) {
      return code.EnumValue((code.EnumValueBuilder updates) {
        updates.name = e.toDartPropertyName();

        if (updates.name != e) {
          updates.annotations.add(
            code.refer('JsonValue').newInstance([code.literalString(e)]),
          );
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
    final enumName = '${model}ScalarFieldEnum'.toLowerCase();
    final enums = options.dmmf.schema.enumTypes.prisma;
    final scalarEnum = enums.firstWhere(
      (e) => e.name.toLowerCase() == enumName,
      orElse: () => throw Exception('Enum $enumName not found'),
    );

    return scalarEnum.values.any((e) => e.toLowerCase() == field.toLowerCase());
  }
}
