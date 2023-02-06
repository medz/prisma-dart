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
    writeLibrary();
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
