import 'dart:io';

import 'package:test/test.dart';

void main() {
  final packageRoot = _resolvePackageRoot();
  final generatorEntry = File(_path(<String>[packageRoot, 'bin', 'orm.dart']));
  final fixturesRoot = Directory(
    _path(<String>[packageRoot, 'test', 'generator', 'fixtures']),
  );

  group(
    'generate command',
    skip: !generatorEntry.existsSync()
        ? 'Generator public entry not found at ${generatorEntry.path}.'
        : false,
    () {
      test('uses default path when output is empty', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'default_output');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final run = await _runGenerate(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
        );

        expect(run.exitCode, 0, reason: run.debugOutput);

        final defaultOutput = File(
          _path(<String>[fixtureDir.path, 'lib', 'orm_client.g.dart']),
        );
        expect(
          defaultOutput.existsSync(),
          isTrue,
          reason:
              'Expected default output at ${defaultOutput.path}.\n${run.debugOutput}',
        );
      });

      test('uses config.output path for generated files', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'config_output');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final run = await _runGenerate(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
        );

        expect(run.exitCode, 0, reason: run.debugOutput);

        final outputFile = File(
          _path(<String>[fixtureDir.path, 'generated', 'typed_client.g.dart']),
        );
        expect(
          outputFile.existsSync(),
          isTrue,
          reason:
              'Expected generated output at ${outputFile.path}.\n${run.debugOutput}',
        );
      });

      test(
        'generated code contains typed delegate and typed input/data markers',
        () async {
          final fixtureDir = _copyFixture(fixturesRoot, 'config_output');
          addTearDown(() => fixtureDir.deleteSync(recursive: true));

          final run = await _runGenerate(
            entryPath: generatorEntry.path,
            workingDirectory: fixtureDir.path,
          );

          expect(run.exitCode, 0, reason: run.debugOutput);

          var generatedDartFiles = _findDartFiles(
            Directory(_path(<String>[fixtureDir.path, 'generated'])),
          );
          if (generatedDartFiles.isEmpty) {
            generatedDartFiles = _findDartFiles(
              Directory(_path(<String>[fixtureDir.path, 'lib'])),
            );
          }

          expect(
            generatedDartFiles,
            isNotEmpty,
            reason: 'Expected generated Dart files to assert content.',
          );

          final generatedSource = generatedDartFiles
              .map((file) => file.readAsStringSync())
              .join('\n');

          expect(
            RegExp(
              r'\b(UserDelegate|UserModelDelegateExtension)\b',
            ).hasMatch(generatedSource),
            isTrue,
            reason: 'Missing typed delegate marker in generated source.',
          );

          expect(
            RegExp(
              r'\b(User[A-Za-z0-9_]*(Input|Data)|UserRow)\b',
            ).hasMatch(generatedSource),
            isTrue,
            reason: 'Missing typed input/data marker in generated source.',
          );

          expect(
            RegExp(r'\bclass UserOrderBy\b').hasMatch(generatedSource),
            isTrue,
            reason: 'Missing typed orderBy DSL class in generated source.',
          );
          expect(
            RegExp(r'\bclass UserSelect\b').hasMatch(generatedSource),
            isTrue,
            reason: 'Missing typed select DSL class in generated source.',
          );
          expect(
            RegExp(r'\bclass UserInclude\b').hasMatch(generatedSource),
            isTrue,
            reason: 'Missing typed include DSL class in generated source.',
          );
          expect(
            RegExp(r'\bclass StringWhereFilter\b').hasMatch(generatedSource),
            isTrue,
            reason: 'Missing string where filter class in generated source.',
          );
          expect(
            RegExp(r'\bclass IntWhereFilter\b').hasMatch(generatedSource),
            isTrue,
            reason: 'Missing int where filter class in generated source.',
          );
          expect(
            RegExp(
              r'class\s+UserWhereInput\s*\{[\s\S]*?final\s+IntWhereFilter\?\s+id;[\s\S]*?final\s+StringWhereFilter\?\s+email;',
            ).hasMatch(generatedSource),
            isTrue,
            reason:
                'Expected UserWhereInput fields to use typed where filter classes.',
          );
          expect(
            generatedSource.contains('List<UserOrderBy> orderBy'),
            isTrue,
            reason: 'Expected typed delegate signature to use UserOrderBy.',
          );
        },
      );

      test('prints actionable error message for invalid config', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'missing_config');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final run = await _runGenerate(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
        );

        expect(run.exitCode, isNot(0), reason: run.debugOutput);
        final combined = run.combinedOutput.toLowerCase();
        expect(
          _containsAny(combined, <String>[
            'config',
            'output',
            'schema',
            'generator',
            'missing',
            'option',
          ]),
          isTrue,
          reason: 'Expected helpful error keywords.\n${run.debugOutput}',
        );
      });
    },
  );
}

String _resolvePackageRoot() {
  final current = Directory.current.path;
  final nested = _path(<String>[current, 'pub', 'orm']);

  if (File(_path(<String>[current, 'pubspec.yaml'])).existsSync() &&
      Directory(_path(<String>[current, 'test'])).existsSync()) {
    return current;
  }

  return nested;
}

Directory _copyFixture(Directory fixturesRoot, String name) {
  final source = Directory(_path(<String>[fixturesRoot.path, name]));
  if (!source.existsSync()) {
    throw StateError('Missing fixture directory: ${source.path}');
  }

  final target = Directory.systemTemp.createTempSync('orm_generate_${name}_');
  for (final entity in source.listSync(recursive: true, followLinks: false)) {
    final relative = entity.path.substring(source.path.length + 1);
    final destinationPath = _path(<String>[target.path, relative]);
    if (entity is Directory) {
      Directory(destinationPath).createSync(recursive: true);
      continue;
    }
    if (entity is File) {
      final destination = File(destinationPath);
      destination.parent.createSync(recursive: true);
      entity.copySync(destination.path);
    }
  }

  return target;
}

Future<_GenerateRun> _runGenerate({
  required String entryPath,
  required String workingDirectory,
}) async {
  final args = <String>[entryPath, 'generate'];
  final result = await Process.run(
    'dart',
    args,
    workingDirectory: workingDirectory,
  );
  return _GenerateRun(
    args: args,
    exitCode: result.exitCode,
    stdout: '${result.stdout}',
    stderr: '${result.stderr}',
  );
}

bool _containsAny(String text, List<String> markers) {
  for (final marker in markers) {
    if (text.contains(marker)) {
      return true;
    }
  }
  return false;
}

List<File> _findDartFiles(Directory directory) {
  if (!directory.existsSync()) {
    return const <File>[];
  }
  return directory
      .listSync(recursive: true, followLinks: false)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();
}

String _path(List<String> parts) => parts.join(Platform.pathSeparator);

final class _GenerateRun {
  final List<String> args;
  final int exitCode;
  final String stdout;
  final String stderr;

  const _GenerateRun({
    required this.args,
    required this.exitCode,
    required this.stdout,
    required this.stderr,
  });

  String get combinedOutput => '$stdout\n$stderr';

  String get debugOutput {
    final buffer = StringBuffer();
    buffer.writeln('args: dart ${args.join(' ')}');
    buffer.writeln('exitCode: $exitCode');
    buffer.writeln('stdout:');
    buffer.writeln(stdout.trim());
    buffer.writeln('stderr:');
    buffer.writeln(stderr.trim());
    return buffer.toString().trimRight();
  }
}
