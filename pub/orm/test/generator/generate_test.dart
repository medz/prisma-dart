import 'dart:convert';
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

      test('cli options override config, schema, and output paths', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'schema_override');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final run = await _runGenerate(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
          generateArgs: <String>[
            '--config',
            'config/override.config.dart',
            '--schema=schema/from_cli.dart',
            '--output',
            'generated/from_cli.g.dart',
          ],
        );

        expect(run.exitCode, 0, reason: run.debugOutput);

        final cliOutput = File(
          _path(<String>[fixtureDir.path, 'generated', 'from_cli.g.dart']),
        );
        expect(
          cliOutput.existsSync(),
          isTrue,
          reason:
              'Expected CLI output at ${cliOutput.path}.\n${run.debugOutput}',
        );

        final configOutput = File(
          _path(<String>[fixtureDir.path, 'generated', 'from_config.g.dart']),
        );
        expect(
          configOutput.existsSync(),
          isFalse,
          reason:
              'Did not expect config output when --output override is provided.',
        );

        final generatedSource = cliOutput.readAsStringSync();
        expect(
          generatedSource.contains("_orm.model('CliOnlyUser')"),
          isTrue,
          reason: 'Expected CLI schema model in generated output.',
        );
        expect(
          generatedSource.contains("_orm.model('ConfigOnlyUser')"),
          isFalse,
          reason: 'Did not expect config schema model after --schema override.',
        );
      });

      test('contract emit writes default artifact path', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'default_output');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final run = await _runContractEmit(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
        );

        expect(run.exitCode, 0, reason: run.debugOutput);

        final output = File(
          _path(<String>[fixtureDir.path, 'orm.contract.json']),
        );
        expect(
          output.existsSync(),
          isTrue,
          reason: 'Expected default contract output.\n${run.debugOutput}',
        );

        final decoded = jsonDecode(output.readAsStringSync());
        expect(decoded is Map<String, Object?>, isTrue);
        final contract = decoded as Map<String, Object?>;
        expect(contract.containsKey('hash'), isTrue);
        expect(contract['target'], 'generic');

        final capabilities = contract['capabilities'];
        expect(capabilities is Map<Object?, Object?>, isTrue);
        final capabilityMap = capabilities as Map<Object?, Object?>;
        expect(capabilityMap.containsKey('includeSingleQuery'), isTrue);
        expect(capabilityMap['includeSingleQuery'], isFalse);
        expect(capabilityMap.containsKey('mutationReturning'), isTrue);
        expect(capabilityMap['mutationReturning'], isTrue);

        final aliases = contract['aliases'];
        expect(aliases is Map<Object?, Object?>, isTrue);
        final aliasMap = aliases as Map<Object?, Object?>;
        expect(aliasMap['user'], 'User');
        expect(aliasMap['users'], 'User');

        final models = contract['models'] as Map<Object?, Object?>;
        expect(models.containsKey('User'), isTrue);
        final user = models['User'];
        expect(user is Map<Object?, Object?>, isTrue);
        final userMap = user as Map<Object?, Object?>;
        expect(userMap['idFields'], <Object?>['id']);
        final relations = userMap['relations'];
        expect(relations is Map<Object?, Object?>, isTrue);
        expect((relations as Map<Object?, Object?>).isEmpty, isTrue);
      });

      test('contract emit maps provider to target and capabilities', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'default_output');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final configFile = File(
          _path(<String>[fixtureDir.path, 'orm.config.dart']),
        );
        configFile.writeAsStringSync('''
class Config {
  final String? output;
  final String? schema;
  final String? provider;

  const Config({this.output, this.schema, this.provider});
}

const config = Config(provider: 'sqlite');
''');

        final run = await _runContractEmit(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
        );

        expect(run.exitCode, 0, reason: run.debugOutput);

        final output = File(
          _path(<String>[fixtureDir.path, 'orm.contract.json']),
        );
        final contract =
            jsonDecode(output.readAsStringSync()) as Map<Object?, Object?>;
        expect(contract['target'], 'sql-family');

        final capabilities = contract['capabilities'] as Map<Object?, Object?>;
        expect(capabilities['includeSingleQuery'], isFalse);
        expect(capabilities['mutationReturning'], isFalse);
      });

      test(
        'contract emit infers relation metadata from schema fields',
        () async {
          final fixtureDir = _copyFixture(fixturesRoot, 'relation_output');
          addTearDown(() => fixtureDir.deleteSync(recursive: true));

          final run = await _runContractEmit(
            entryPath: generatorEntry.path,
            workingDirectory: fixtureDir.path,
          );

          expect(run.exitCode, 0, reason: run.debugOutput);

          final output = File(
            _path(<String>[fixtureDir.path, 'orm.contract.json']),
          );
          final contract =
              jsonDecode(output.readAsStringSync()) as Map<Object?, Object?>;
          final models = contract['models'] as Map<Object?, Object?>;

          final userModel = models['User'] as Map<Object?, Object?>;
          final userRelations = userModel['relations'] as Map<Object?, Object?>;
          final posts = userRelations['posts'] as Map<Object?, Object?>;
          expect(posts['relatedModel'], 'Post');
          expect(posts['cardinality'], 'many');
          expect(posts['sourceFields'], <Object?>['id']);
          expect(posts['targetFields'], <Object?>['userId']);

          final postModel = models['Post'] as Map<Object?, Object?>;
          final postRelations = postModel['relations'] as Map<Object?, Object?>;
          final author = postRelations['author'] as Map<Object?, Object?>;
          expect(author['relatedModel'], 'User');
          expect(author['cardinality'], 'one');
          expect(author['sourceFields'], <Object?>['userId']);
          expect(author['targetFields'], <Object?>['id']);
        },
      );

      test(
        'contract emit keeps hash stable when scalar field declaration order changes',
        () async {
          final fixtureDir = _copyFixture(fixturesRoot, 'default_output');
          addTearDown(() => fixtureDir.deleteSync(recursive: true));

          final firstRun = await _runContractEmit(
            entryPath: generatorEntry.path,
            workingDirectory: fixtureDir.path,
          );
          expect(firstRun.exitCode, 0, reason: firstRun.debugOutput);

          final contractFile = File(
            _path(<String>[fixtureDir.path, 'orm.contract.json']),
          );
          final firstContract =
              jsonDecode(contractFile.readAsStringSync())
                  as Map<Object?, Object?>;
          final firstHash = firstContract['hash'];

          final schemaFile = File(
            _path(<String>[fixtureDir.path, 'orm.schema.dart']),
          );
          schemaFile.writeAsStringSync('''
class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

@model
typedef User = ({DateTime createdAt, String email, int id});
''');

          final secondRun = await _runContractEmit(
            entryPath: generatorEntry.path,
            workingDirectory: fixtureDir.path,
          );
          expect(secondRun.exitCode, 0, reason: secondRun.debugOutput);

          final secondContract =
              jsonDecode(contractFile.readAsStringSync())
                  as Map<Object?, Object?>;
          expect(secondContract['hash'], firstHash);
          expect(secondContract['markerStorageHash'], firstHash);
        },
      );

      test(
        'contract emit applies relation annotation overrides when valid',
        () async {
          final fixtureDir = _copyFixture(fixturesRoot, 'relation_output');
          addTearDown(() => fixtureDir.deleteSync(recursive: true));

          final schemaFile = File(
            _path(<String>[fixtureDir.path, 'orm.schema.dart']),
          );
          schemaFile.writeAsStringSync('''
class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

class Relation {
  final Set<String>? fields;
  final Set<String>? references;
  final String? name;

  const Relation({this.fields, this.references, this.name});
}

@model
typedef User = ({String id, String email, List<Post> posts});

@model
typedef Post = ({
  String id,
  String userId,
  String title,
  @Relation(fields: {'userId'}, references: {'id'}, name: 'postAuthor')
  User? author
});
''');

          final run = await _runContractEmit(
            entryPath: generatorEntry.path,
            workingDirectory: fixtureDir.path,
          );
          expect(run.exitCode, 0, reason: run.debugOutput);

          final output = File(
            _path(<String>[fixtureDir.path, 'orm.contract.json']),
          );
          final contract =
              jsonDecode(output.readAsStringSync()) as Map<Object?, Object?>;
          final models = contract['models'] as Map<Object?, Object?>;
          final postModel = models['Post'] as Map<Object?, Object?>;
          final postRelations = postModel['relations'] as Map<Object?, Object?>;
          final author = postRelations['author'] as Map<Object?, Object?>;
          expect(author['name'], 'postAuthor');
          expect(author['sourceFields'], <Object?>['userId']);
          expect(author['targetFields'], <Object?>['id']);
        },
      );

      test(
        'contract emit ignores invalid relation annotation and falls back to inference',
        () async {
          final fixtureDir = _copyFixture(fixturesRoot, 'relation_output');
          addTearDown(() => fixtureDir.deleteSync(recursive: true));

          final schemaFile = File(
            _path(<String>[fixtureDir.path, 'orm.schema.dart']),
          );
          schemaFile.writeAsStringSync('''
class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

class Relation {
  final Set<String>? fields;
  final Set<String>? references;
  final String? name;

  const Relation({this.fields, this.references, this.name});
}

@model
typedef User = ({String id, String email, List<Post> posts});

@model
typedef Post = ({
  String id,
  String userId,
  String title,
  @Relation(fields: {'missingField'}, references: {'id'})
  User? author
});
''');

          final run = await _runContractEmit(
            entryPath: generatorEntry.path,
            workingDirectory: fixtureDir.path,
          );
          expect(run.exitCode, 0, reason: run.debugOutput);

          final output = File(
            _path(<String>[fixtureDir.path, 'orm.contract.json']),
          );
          final contract =
              jsonDecode(output.readAsStringSync()) as Map<Object?, Object?>;
          final models = contract['models'] as Map<Object?, Object?>;
          final postModel = models['Post'] as Map<Object?, Object?>;
          final postRelations = postModel['relations'] as Map<Object?, Object?>;
          final author = postRelations['author'] as Map<Object?, Object?>;
          expect(author['name'], 'author');
          expect(author['sourceFields'], <Object?>['userId']);
          expect(author['targetFields'], <Object?>['id']);
        },
      );

      test('contract emit supports --output override path', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'default_output');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final run = await _runContractEmit(
          entryPath: generatorEntry.path,
          workingDirectory: fixtureDir.path,
          emitArgs: <String>['--output', 'generated/contract.custom.json'],
        );

        expect(run.exitCode, 0, reason: run.debugOutput);

        final output = File(
          _path(<String>[fixtureDir.path, 'generated', 'contract.custom.json']),
        );
        expect(
          output.existsSync(),
          isTrue,
          reason: 'Expected overridden contract output.\n${run.debugOutput}',
        );
      });

      test('generated code contains typed delegate and typed input/data markers', () async {
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
            r'class\s+GeneratedOrmClient\s*\{[\s\S]*?late\s+final\s+GeneratedOrmDb\s+db\s*=\s*GeneratedOrmDb\(_context\.db\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected GeneratedOrmClient to expose db entrypoint.',
        );
        expect(
          generatedSource.contains('db.orm.user;'),
          isFalse,
          reason:
              'Expected GeneratedOrmClient to remove direct model delegate getters.',
        );
        expect(
          RegExp(
            r'class\s+GeneratedOrmCollections\s*\{[\s\S]*?UserDelegate\s+User\s*=',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected GeneratedOrmCollections to expose exact model-name delegate getters.',
        );
        expect(
          RegExp(
            r'class\s+GeneratedOrmDb\s*\{[\s\S]*?late\s+final\s+GeneratedOrmCollections\s+orm\s*=\s*GeneratedOrmCollections\(_db\.orm\);[\s\S]*?late\s+final\s+GeneratedOrmSql\s+sql\s*=\s*GeneratedOrmSql\(_db\.sql\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected GeneratedOrmDb to expose db.orm and db.sql namespaces.',
        );
        expect(
          RegExp(
            r'class\s+GeneratedOrmSql\s*\{[\s\S]*?final\s+OrmSqlApi\s+_api;[\s\S]*?UserSql\s+User\s*=',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected GeneratedOrmSql to expose exact model-name sql delegates.',
        );
        expect(
          RegExp(
            r'class\s+GeneratedOrmCollections\s*\{[\s\S]*?_orm\.model\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected GeneratedOrmCollections to materialize typed delegates.',
        );

        expect(
          RegExp(
            r'\b(User[A-Za-z0-9_]*(Input|Data)|UserRow)\b',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Missing typed input/data marker in generated source.',
        );
        expect(
          RegExp(r'\bclass UserQuery\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Missing chain query class UserQuery in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?\bUserQuery\s+query\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserDelegate.query(...) in generated source.',
        );
        expect(
          RegExp(r'\bUserQuery\s+where\(').hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.where(...) in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+where\(\s*UserWhereInput\s+where,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.where(...) to expose merge flag with default true.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+where\([\s\S]*?_where\.andWith\(where\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.where(...) merge path to combine with _where.andWith(where).',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+where\([\s\S]*?return\s+UserQuery\._\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.where(...) chaining to stay immutable by returning a new query object.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?UserQuery\s+whereWith\(\s*UserWhereInput\s+Function\(\s*UserWhereInput\s+where\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.whereWith(...) to expose typed callback authoring helper.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+whereWith\(\s*UserWhereInput\s+Function\(\s*UserWhereInput\s+where\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.whereWith(...) to expose typed callback authoring helper.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+whereWith\([\s\S]*?return\s+where\(next,\s*merge:\s*merge\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.whereWith(...) to route through where(..., merge: merge).',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?UserQuery\s+selectWith\(\s*UserSelect\s+Function\(\s*UserSelect\s+select\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*false,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.selectWith(...) to expose typed select callback authoring helper.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+select\(\s*UserSelect\?\s+select,\s*\{\s*bool\s+merge\s*=\s*false,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.select(...) to expose merge flag for typed select state.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+selectWith\(\s*UserSelect\s+Function\(\s*UserSelect\s+select\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*false,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.selectWith(...) to expose typed select callback authoring helper.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+selectWith\([\s\S]*?return\s+select\(next,\s*merge:\s*merge\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.selectWith(...) to route through select(..., merge: merge).',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+include\(\s*UserInclude\?\s+include,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.include(...) to expose merge flag with default true.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+include\([\s\S]*?_include\?\.merge\(include\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.include(...) merge path to use _include?.merge(include).',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+include\([\s\S]*?return\s+UserQuery\._\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.include(...) chaining to stay immutable by returning a new query object.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+includeWith\(\s*UserInclude\s+Function\(\s*UserInclude\s+include\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.includeWith(...) to expose typed include callback with merge flag.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+includeWith\([\s\S]*?(?:return\s+include\(\s*build\([\s\S]*?\)\s*,\s*merge:\s*merge\s*\);|final\s+\w+\s*=\s*build\([\s\S]*?\);[\s\S]*?return\s+include\(\s*\w+\s*,\s*merge:\s*merge\s*\);)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.includeWith(...) to route through include(..., merge: merge).',
        );
        expect(
          RegExp(
            r'class\s+UserInclude\s*\{[\s\S]*?UserInclude\s+includeWith\(\s*UserInclude\s+Function\(\s*UserInclude\s+include\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserInclude.includeWith(...) to expose typed include callback helper.',
        );
        expect(
          RegExp(
            r'class\s+UserInclude\s*\{[\s\S]*?Map<String,\s*IncludeSpec>\s+toIncludeMap\(\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected model include class to expose include map conversion for convenience chaining pipeline.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?OrmReadQuerySpec\s+_readSpec\(\)[\s\S]*?Future<OrmPreparedReadQuery>\s+_prepareRead\(\)[\s\S]*?Future<List<UserData>>\s+all\(\)\s+async\s*\{[\s\S]*?\(await\s+_prepareRead\(\)\)\.all\(\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery read execution to compile typed state through read specs and prepared read objects.',
        );
        expect(
          generatedSource.contains('ModelQuery _runtimeQuery('),
          isFalse,
          reason:
              'Expected generated query surface to stop materializing runtime ModelQuery bridge methods.',
        );
        expect(
          generatedSource.contains('_delegate._delegate.query('),
          isFalse,
          reason:
              'Expected generated query surface to stop re-entering dynamic query authoring.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+unbounded\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.unbounded() in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?UserQuery\s+cursor\(\s*UserCursorInput\s+cursor\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.cursor(...) to use typed cursor input.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?UserQuery\s+page\(\{\s*required\s+int\s+size,\s*UserCursorInput\?\s+after,\s*UserCursorInput\?\s+before,',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserDelegate.page(...) to use typed cursor inputs.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+cursor\(\s*UserCursorInput\s+cursor\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.cursor(...) to use typed cursor input.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+page\(\{\s*required\s+int\s+size,\s*UserCursorInput\?\s+after,\s*UserCursorInput\?\s+before,',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.page(...) to use typed cursor inputs.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<OrmPlan>\s+toPlan\(\{',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserDelegate.toPlan(...) in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<OrmPlan>\s+toPlan\(\s*\)\s+async[\s\S]*?\(await\s+_prepareRead\(\)\)\.plan',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.toPlan() to compile typed state through prepared read planning.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<JsonMap>\s+inspectPlan\(\s*\)\s+async[\s\S]*?\(await\s+_prepareRead\(\)\)\.inspectPlan\(\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.inspectPlan() to compile typed state through prepared read inspection.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData\?>\s+oneOrNull\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.oneOrNull() in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<JsonMap>\s+explain\(\s*\)\s+async[\s\S]*?\(await\s+_prepareRead\(\)\)\.explain\(\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.explain() to compile typed state through prepared read explain.',
        );
        expect(
          RegExp(
            r'\bFuture<List<UserData>>\s+all\s*\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.all() in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<OrmPageResult<UserData>>\s+pageResult\(\s*\)\s+async[\s\S]*?\(await\s+_prepareRead\(\)\)\.pageResult\(\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.pageResult() to expose structured page envelope mapping through prepared reads.',
        );
        expect(
          RegExp(
            r'\bFuture<UserData\?>\s+firstOrNull\s*\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.firstOrNull() in generated source.',
        );
        expect(
          RegExp(r'\bclass UserSql\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Expected generated source to include typed UserSql class.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?OrmPlan\s+toPlan\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose typed toPlan helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<List<UserData>>\s+all\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose typed all helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Stream<UserData>\s+stream\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose typed stream helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<UserData\?>\s+firstOrNull\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose typed firstOrNull helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<UserData\?>\s+insert\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose typed insert helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<OrmSqlMutationResult>\s+insertResult\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose insertResult helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<OrmSqlMutationResult>\s+updateResult\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose updateResult helper.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<OrmSqlMutationResult>\s+deleteResult\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose deleteResult helper.',
        );
        expect(
          RegExp(r'\bclass UserWhereUniqueInput\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Missing typed where unique input class in generated source.',
        );
        expect(
          RegExp(r'\bclass UserCursorInput\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Missing typed cursor input class in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserWhereUniqueInput\s*\{[\s\S]*?final\s+int\?\s+id;',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserWhereUniqueInput to expose scalar unique id.',
        );
        expect(
          RegExp(
            r"class\s+UserWhereUniqueInput\s*\{[\s\S]*?_readInt\(_readWhereUniqueEquals\(json\['id'\]\)\)",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserWhereUniqueInput.fromJson to accept scalar or equals map input.',
        );
        expect(
          RegExp(
            r"class\s+UserWhereUniqueInput\s*\{[\s\S]*?if\s*\(id\s*!=\s*null\)\s*'id':\s*id!",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserWhereUniqueInput.toJson to emit runtime-compatible scalar where value.',
        );
        expect(
          RegExp(
            r'Object\?\s+_readWhereUniqueEquals\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include where unique equals compatibility helper.',
        );
        expect(
          RegExp(
            r'class\s+UserCursorInput\s*\{[\s\S]*?final\s+int\?\s+id;[\s\S]*?final\s+String\?\s+email;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserCursorInput to include scalar cursor fields needed for ordered pagination.',
        );
        expect(
          RegExp(
            r"class\s+UserCursorInput\s*\{[\s\S]*?if\s*\(id\s*!=\s*null\)\s*'id':\s*id![\s\S]*?if\s*\(email\s*!=\s*null\)\s*'email':\s*email!",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserCursorInput.toJson to emit scalar cursor boundary values.',
        );
        expect(
          RegExp(
            r'Future<UserData\?>\s+oneOrNull\(\{\s*required\s+UserWhereUniqueInput\s+where,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected oneOrNull where parameter to use UserWhereUniqueInput.',
        );
        expect(
          RegExp(
            r'Future<UserData\?>\s+update\(\{\s*required\s+UserWhereUniqueInput\s+where,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected update where parameter to use UserWhereUniqueInput.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<int>\s+updateMany\(\{\s*UserWhereInput\s+where\s*=\s*const\s+UserWhereInput\(\),\s*required\s+UserUpdateInput\s+data,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.updateMany(...) placeholder to expose typed where and data input.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<int>\s+updateMany\(\{\s*required\s+UserUpdateInput\s+data\}\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.updateMany(...) placeholder to expose typed update data input.',
        );
        expect(
          RegExp(r'\bclass UserNestedCreateInput\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed nested create input wrapper.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData>\s+createNested\(\{\s*required\s+UserCreateInput\s+data,\s*UserNestedCreateInput\s+create\s*=\s*const\s+UserNestedCreateInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.createNested(...) to expose typed nested create input.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData>\s+create\(\{\s*required\s+UserCreateInput\s+data',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.create(...) to exist.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData>\s+createNested\(\{\s*required\s+UserCreateInput\s+data,\s*UserNestedCreateInput\s+create\s*=\s*const\s+UserNestedCreateInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.createNested(...) to exist.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData\?>\s+updateNested\(\{\s*UserWhereInput\s+where\s*=\s*const\s+UserWhereInput\(\),\s*required\s+UserUpdateInput\s+data,\s*UserNestedCreateInput\s+create\s*=\s*const\s+UserNestedCreateInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.updateNested(...) to expose typed nested create input.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData\?>\s+updateNested\(\{\s*required\s+UserUpdateInput\s+data,\s*UserNestedCreateInput\s+create\s*=\s*const\s+UserNestedCreateInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.updateNested(...) to expose typed nested create input.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData\?>\s+update\(\{\s*required\s+UserUpdateInput\s+data',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.update(...) to exist.',
        );
        expect(
          RegExp(
            r'Future<UserData\?>\s+delete\(\{\s*required\s+UserWhereUniqueInput\s+where,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected delete where parameter to use UserWhereUniqueInput.',
        );
        expect(
          RegExp(
            r'Future<UserData>\s+upsert\(\{\s*required\s+UserWhereUniqueInput\s+where,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected upsert where parameter to use UserWhereUniqueInput.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData\?>\s+delete\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.delete() to exist.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<UserData>\s+upsert\(\{\s*required\s+UserCreateInput\s+create,\s*required\s+UserUpdateInput\s+update,',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.upsert(...) to exist.',
        );
        expect(
          RegExp(
            r'Future<List<UserData>>\s+all\(\{\s*UserWhereInput\s+where\s*=\s*const\s+UserWhereInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected non-unique all to keep UserWhereInput.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<List<UserData>>\s+all\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where,[\s\S]*?distinct:\s*distinct,[\s\S]*?\)\.all\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate all(...) to route through typed query instead of rebuilding runtime read arguments.',
        );
        expect(
          RegExp(
            r'Future<List<UserData>>\s+all\(\{[\s\S]*?List<UserDistinct>\s+distinct\s*=\s*const\s+<UserDistinct>\[\],',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected all to expose typed distinct parameter in generated delegate.',
        );
        expect(
          RegExp(
            r'Future<UserData\?>\s+firstOrNull\(\{[\s\S]*?List<UserDistinct>\s+distinct\s*=\s*const\s+<UserDistinct>\[\],',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected firstOrNull to expose typed distinct parameter in generated delegate.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData\?>\s+firstOrNull\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where,[\s\S]*?distinct:\s*distinct,[\s\S]*?\)\.firstOrNull\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate firstOrNull(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserWhereUniqueInput\s*\{[\s\S]*?UserWhereInput\s+toWhereInput\(\)\s*\{[\s\S]*?return\s+UserWhereInput\.fromJson\(toJson\(\)\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected unique input to expose typed toWhereInput() conversion for read delegate reuse.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData\?>\s+oneOrNull\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where\.toWhereInput\(\),[\s\S]*?\)\.oneOrNull\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate oneOrNull(...) to route through typed query using unique-to-where conversion.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Stream<UserData>\s+stream\(\{[\s\S]*?return\s+query\([\s\S]*?distinct:\s*distinct,[\s\S]*?\)\.stream\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate stream(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<List<UserData>>\s+createMany\(\{[\s\S]*?return\s+query\([\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.createMany\(data:\s*data\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate createMany(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData>\s+create\(\{[\s\S]*?return\s+query\([\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.create\(data:\s*data\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate create(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData>\s+createNested\(\{[\s\S]*?return\s+query\([\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.createNested\(data:\s*data,\s*create:\s*create\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate createNested(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData\?>\s+updateNested\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where,[\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.updateNested\(data:\s*data,\s*create:\s*create\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate updateNested(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<int>\s+updateMany\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where,[\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.updateMany\(data:\s*data\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate updateMany(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData\?>\s+update\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where\.toWhereInput\(\),[\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.update\(data:\s*data\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate update(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<int>\s+deleteMany\(\{[\s\S]*?return\s+query\(where:\s*where\)\.deleteMany\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate deleteMany(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData\?>\s+delete\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where\.toWhereInput\(\),[\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.delete\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate delete(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserData>\s+upsert\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where\.toWhereInput\(\),[\s\S]*?select:\s*select,[\s\S]*?include:\s*include,[\s\S]*?\)\.upsert\(create:\s*create,\s*update:\s*update\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate upsert(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<int>\s+count\(\{[\s\S]*?return\s+query\(where:\s*where\)\.count\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate count(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<bool>\s+exists\(\{[\s\S]*?return\s+query\(where:\s*where\)\.exists\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate exists(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<UserAggregateResult>\s+aggregate\(\{[\s\S]*?return\s+query\(where:\s*where\)\.aggregate\([\s\S]*?count:\s*count,[\s\S]*?avg:\s*avg,[\s\S]*?\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate aggregate(...) to route through typed query.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<List<UserGroupByResult>>\s+groupBy\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where,[\s\S]*?skip:\s*skip,[\s\S]*?take:\s*take,[\s\S]*?\)\.groupBy\([\s\S]*?groupByOrderBy:\s*groupByOrderBy,[\s\S]*?typedHaving:\s*typedHaving,[\s\S]*?\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate groupBy(...) to route through typed query.',
        );
        expect(
          generatedSource.contains('Future<List<UserData>> findMany('),
          isFalse,
          reason:
              'Expected generated typed delegate source to not expose findMany signature.',
        );
        expect(
          generatedSource.contains('Future<UserData?> findFirst('),
          isFalse,
          reason:
              'Expected generated typed delegate source to not expose findFirst signature.',
        );
        expect(
          generatedSource.contains('Future<UserData?> findUnique('),
          isFalse,
          reason:
              'Expected generated typed delegate source to not expose findUnique signature.',
        );
        expect(
          generatedSource.contains('Future<UserData?> first()'),
          isFalse,
          reason:
              'Expected generated typed query source to not expose first() signature.',
        );
        expect(
          generatedSource.contains('OrmSqlSelectBuilder selectPlan('),
          isFalse,
          reason:
              'Expected generated typed sql source to not expose selectPlan signature.',
        );
        expect(
          generatedSource.contains('Future<List<UserData>> query('),
          isFalse,
          reason:
              'Expected generated typed sql source to not expose query() signature.',
        );
        expect(
          RegExp(
            r'Stream<UserData>\s+stream\(\{[\s\S]*?List<UserDistinct>\s+distinct\s*=\s*const\s+<UserDistinct>\[\],',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected stream to expose typed distinct parameter in generated delegate.',
        );
        expect(
          RegExp(r'\bclass UserDistinct\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Missing typed distinct DSL class in generated source.',
        );
        expect(
          RegExp(
            r'class\s+UserDistinct\s*\{[\s\S]*?static\s+const\s+UserDistinct\s+id\s*=\s*UserDistinct\._\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDistinct class to expose static scalar field members.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+distinct\(\s*List<UserDistinct>\s+distinct,\s*\{\s*bool\s+append\s*=\s*false,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.distinct(...) to support typed distinct chaining.',
        );
        expect(
          RegExp(
            r'Future<UserAggregateResult>\s+aggregate\(\{',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate/query to expose aggregate helper.',
        );
        expect(
          RegExp(r'\bclass UserAggregateResult\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include aggregate result wrapper.',
        );
        expect(
          RegExp(
            r'\bclass UserAggregateCountBucket\b',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed aggregate count bucket.',
        );
        expect(
          RegExp(r'\bclass UserAggregateMinBucket\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed aggregate min bucket.',
        );
        expect(
          RegExp(r'\bclass UserAggregateMaxBucket\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed aggregate max bucket.',
        );
        expect(
          RegExp(r'\bclass UserAggregateSumBucket\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed aggregate sum bucket.',
        );
        expect(
          RegExp(r'\bclass UserAggregateAvgBucket\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed aggregate avg bucket.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateResult\s*\{[\s\S]*?UserAggregateCountBucket\s+get\s+count',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserAggregateResult to expose typed count bucket getter.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateResult\s*\{[\s\S]*?UserAggregateMinBucket\s+get\s+min',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserAggregateResult to expose typed min bucket getter.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateResult\s*\{[\s\S]*?UserAggregateMaxBucket\s+get\s+max',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserAggregateResult to expose typed max bucket getter.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateResult\s*\{[\s\S]*?UserAggregateSumBucket\s+get\s+sum',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserAggregateResult to expose typed sum bucket getter.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateResult\s*\{[\s\S]*?UserAggregateAvgBucket\s+get\s+avg',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserAggregateResult to expose typed avg bucket getter.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateResult\s*\{[\s\S]*?final\s+Map<String,\s*Object\?>\s+value;',
          ).hasMatch(generatedSource),
          isFalse,
          reason:
              'Expected UserAggregateResult to avoid exposing public map payload.',
        );
        expect(
          RegExp(
            r'class\s+UserAggregateCountBucket\s*\{[\s\S]*?field\(UserDistinct\s+field\)',
          ).hasMatch(generatedSource),
          isFalse,
          reason:
              'Expected typed aggregate buckets to avoid dynamic field(...) map-style accessor.',
        );
        expect(
          RegExp(
            r'Future<List<UserGroupByResult>>\s+groupBy\(\{\s*required\s+List<UserDistinct>\s+by,[\s\S]*?UserGroupByHaving\s+typedHaving\s*=\s*const\s+UserGroupByHaving\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated delegate/query to expose typed groupBy helper.',
        );
        expect(
          RegExp(r'\bclass UserGroupByResult\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed groupBy result wrapper.',
        );
        expect(
          RegExp(
            r'class\s+UserGroupByResult\s*\{[\s\S]*?int\?\s+get\s+id\s*=>',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserGroupByResult to expose typed getter for scalar id.',
        );
        expect(
          RegExp(
            r'class\s+UserGroupByResult\s*\{[\s\S]*?String\?\s+get\s+email\s*=>',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserGroupByResult to expose typed getter for scalar email.',
        );
        expect(
          RegExp(
            r'class\s+UserGroupByResult\s*\{[\s\S]*?Object\?\s+field\(UserDistinct\s+field\)',
          ).hasMatch(generatedSource),
          isFalse,
          reason:
              'Expected UserGroupByResult to avoid dynamic field(...) map-style accessor.',
        );
        expect(
          RegExp(
            r'class\s+UserGroupByResult\s*\{[\s\S]*?final\s+Map<String,\s*Object\?>\s+value;',
          ).hasMatch(generatedSource),
          isFalse,
          reason:
              'Expected UserGroupByResult to avoid exposing public map payload.',
        );
        expect(
          generatedSource.contains(
            'UserWhereInput having = const UserWhereInput()',
          ),
          isFalse,
          reason:
              'Expected generated groupBy surfaces to remove row-level having parameter.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<List<UserGroupByResult>>\s+groupBy\(\{[\s\S]*?UserGroupByHaving\s+typedHaving\s*=\s*const\s+UserGroupByHaving\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.groupBy(...) to expose typedHaving parameter.',
        );
        expect(
          RegExp(
            r'class\s+UserDelegate\s*\{[\s\S]*?Future<List<UserGroupByResult>>\s+groupBy\(\{[\s\S]*?return\s+query\([\s\S]*?where:\s*where,[\s\S]*?skip:\s*skip,[\s\S]*?take:\s*take,[\s\S]*?\)\.groupBy\([\s\S]*?groupByOrderBy:\s*groupByOrderBy,[\s\S]*?typedHaving:\s*typedHaving,[\s\S]*?\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.groupBy(...) to route typed groupBy execution through query.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<List<UserGroupByResult>>\s+groupBy\(\{[\s\S]*?UserGroupByHaving\s+typedHaving\s*=\s*const\s+UserGroupByHaving\(\),[\s\S]*?List<UserGroupByOrderBy>\s+groupByOrderBy\s*=\s*const\s+<UserGroupByOrderBy>\[\],[\s\S]*?typedHaving:\s*typedHaving,[\s\S]*?groupByOrderBy:\s*groupByOrderBy,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.groupBy(...) to expose and forward typed groupBy helpers.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<List<UserGroupByResult>>\s+groupBy\(\{[\s\S]*?orderBy:\s*_orderBy,',
          ).hasMatch(generatedSource),
          isFalse,
          reason:
              'Expected UserQuery.groupBy(...) to stop forwarding query orderBy state.',
        );
        expect(
          RegExp(
            r'UserQuery\s+query\(\{\s*UserWhereInput\s+where\s*=\s*const\s+UserWhereInput\(\),\s*int\?\s+skip,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.query(...) to keep only row-level where (no having parameter).',
        );
        expect(
          RegExp(
            r'\bclass UserGroupByHavingCondition\b',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed groupBy having condition helper.',
        );
        expect(
          RegExp(r'\bclass UserGroupByHaving\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed groupBy having helper.',
        );
        expect(
          RegExp(r'\bclass UserGroupByOrderBy\b').hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected generated source to include typed groupBy orderBy helper.',
        );
        expect(
          RegExp(
            r'Future<List<UserData>>\s+createMany\(\{\s*required\s+List<UserCreateInput>\s+data,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.createMany(...) to accept typed input list.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<List<UserData>>\s+createMany\(\{\s*required\s+List<UserCreateInput>\s+data\}\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.createMany(...) to exist with typed input list.',
        );
        expect(
          RegExp(
            r'Future<int>\s+deleteMany\(\{\s*UserWhereInput\s+where\s*=\s*const\s+UserWhereInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.deleteMany(...) to accept typed where input.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?Future<int>\s+deleteMany\s*\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.deleteMany() to exist.',
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
          RegExp(
            r'class\s+UserInclude\s*\{[\s\S]*?UserInclude\s+merge\(\s*UserInclude\s+other\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected model include class to generate merge helper.',
        );
        expect(
          RegExp(r'\bclass StringWhereFilter\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Missing string where filter class in generated source.',
        );
        expect(
          RegExp(
            r"class\s+StringWhereFilter\s*\{[\s\S]*?value\['in'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected StringWhereFilter to contain in operator marker.',
        );
        expect(
          RegExp(
            r"class\s+StringWhereFilter\s*\{[\s\S]*?value\['not'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected StringWhereFilter to contain not operator marker.',
        );
        expect(
          RegExp(
            r"class\s+StringWhereFilter\s*\{[\s\S]*?value\['gt'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected StringWhereFilter to contain gt operator marker.',
        );
        expect(
          RegExp(
            r"class\s+StringWhereFilter\s*\{[\s\S]*?value\['contains'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected StringWhereFilter to contain contains operator marker.',
        );
        expect(
          RegExp(
            r"class\s+StringWhereFilter\s*\{[\s\S]*?value\['startsWith'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected StringWhereFilter to contain startsWith operator marker.',
        );
        expect(
          RegExp(
            r"class\s+StringWhereFilter\s*\{[\s\S]*?value\['endsWith'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected StringWhereFilter to contain endsWith operator marker.',
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
          RegExp(
            r"class\s+UserWhereInput\s*\{[\s\S]*?\['AND'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserWhereInput to include AND logical field marker.',
        );
        expect(
          RegExp(
            r"class\s+UserWhereInput\s*\{[\s\S]*?\['OR'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserWhereInput to include OR logical field marker.',
        );
        expect(
          RegExp(
            r"class\s+UserWhereInput\s*\{[\s\S]*?\['NOT'\]",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserWhereInput to include NOT logical field marker.',
        );
        expect(
          RegExp(
            r'class\s+UserWhereInput\s*\{[\s\S]*?UserWhereInput\s+andWith\(\s*UserWhereInput\s+other\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserWhereInput to generate andWith merge helper.',
        );
        expect(
          generatedSource.contains('List<UserOrderBy> orderBy'),
          isTrue,
          reason: 'Expected typed delegate signature to use UserOrderBy.',
        );
      });

      test('generates relation where some/every/none and is/isNot filter classes', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'relation_output');
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
          reason: 'Expected generated Dart files to assert relation where DSL.',
        );

        final generatedSource = generatedDartFiles
            .map((file) => file.readAsStringSync())
            .join('\n');

        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+merge\(\s*UserPostsInclude\s+other\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected relation include class to generate merge helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+where\(\s*PostWhereInput\s+where,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose chainable where(...) helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+skip\(\s*int\?\s+skip\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose chainable skip(...) helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+take\(\s*int\?\s+take\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose chainable take(...) helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+orderBy\(\s*List<PostOrderBy>\s+orderBy,\s*\{\s*bool\s+append\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose chainable orderBy(...) helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+select\(\s*PostSelect\?\s+select,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose chainable select(...) helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+include\(\s*PostInclude\?\s+include,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose chainable include(...) helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+includeWith\(\s*PostInclude\s+Function\(\s*PostInclude\s+include\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include class to expose includeWith(...) callback helper.',
        );
        expect(
          RegExp(
            r'class\s+PostAuthorInclude\s*\{[\s\S]*?PostAuthorInclude\s+includeWith\(\s*UserInclude\s+Function\(\s*UserInclude\s+include\s*\)\s+build,\s*\{\s*bool\s+merge\s*=\s*true,?\s*\}\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected to-one relation include class to expose includeWith(...) callback helper.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+where\([\s\S]*?return\s+UserPostsInclude\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include where(...) chaining to stay immutable by returning a new relation include object.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsInclude\s*\{[\s\S]*?UserPostsInclude\s+include\([\s\S]*?return\s+UserPostsInclude\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation include include(...) chaining to stay immutable by returning a new relation include object.',
        );
        expect(
          RegExp(
            r'class\s+UserInclude\s*\{[\s\S]*?UserInclude\s+includePosts\(\[\s*UserPostsInclude\s+Function\(\s*UserPostsInclude\s+\w+\s*\)\?\s+\w+\s*\]\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected model include class to expose includePosts([configure]) convenience helper.',
        );
        expect(
          RegExp(
            r'class\s+PostInclude\s*\{[\s\S]*?PostInclude\s+includeAuthor\(\[\s*PostAuthorInclude\s+Function\(\s*PostAuthorInclude\s+\w+\s*\)\?\s+\w+\s*\]\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected model include class to expose includeAuthor([configure]) convenience helper.',
        );
        expect(
          RegExp(
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+includePosts\(\[\s*UserPostsInclude\s+Function\(\s*UserPostsInclude\s+\w+\s*\)\?\s+\w+\s*\]\s*\)\s*\{[\s\S]*?return\s+include\(\s*UserInclude\(\s*posts:',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserQuery.includePosts([configure]) to route through include(...) with UserInclude(posts: ...).',
        );
        expect(
          RegExp(
            r'class\s+PostQuery\s*\{[\s\S]*?PostQuery\s+includeAuthor\(\[\s*PostAuthorInclude\s+Function\(\s*PostAuthorInclude\s+\w+\s*\)\?\s+\w+\s*\]\s*\)\s*\{[\s\S]*?return\s+include\(\s*PostInclude\(\s*author:',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected PostQuery.includeAuthor([configure]) to route through include(...) with PostInclude(author: ...).',
        );
        expect(
          RegExp(
            r'\bclass UserPostsRelationWhereFilter\b',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected relation where filter class for User.posts.',
        );
        expect(
          RegExp(
            r'class\s+UserPostsRelationWhereFilter\s*\{[\s\S]*?final\s+PostWhereInput\?\s+some;[\s\S]*?final\s+PostWhereInput\?\s+every;[\s\S]*?final\s+PostWhereInput\?\s+none;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation where filter to expose some/every/none typed operands.',
        );
        expect(
          RegExp(
            r'class\s+UserWhereInput\s*\{[\s\S]*?final\s+UserPostsRelationWhereFilter\?\s+posts;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserWhereInput relation field to use relation where filter class.',
        );
        expect(
          RegExp(
            r'\bclass PostAuthorRelationWhereFilter\b',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected relation where filter class for Post.author.',
        );
        expect(
          RegExp(
            r'class\s+PostAuthorRelationWhereFilter\s*\{[\s\S]*?final\s+UserWhereInput\?\s+is_;[\s\S]*?final\s+UserWhereInput\?\s+isNot;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected to-one relation filter to expose is/isNot typed operands.',
        );
        expect(
          RegExp(
            r'class\s+PostWhereInput\s*\{[\s\S]*?final\s+PostAuthorRelationWhereFilter\?\s+author;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected PostWhereInput relation field to use to-one relation where filter class.',
        );
        expect(
          RegExp(
            r"if\s*\(posts\s*!=\s*null\s*&&\s*!posts!\.isEmpty\)\s*'posts':\s*posts!\.toJsonValue\(\)",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected relation where filter serialization to skip empty filter.',
        );
        expect(
          RegExp(
            r"if\s*\(author\s*!=\s*null\s*&&\s*!author!\.isEmpty\)\s*'author':\s*author!\.toJsonValue\(\)",
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected to-one relation where serialization to skip empty filter.',
        );
        expect(
          RegExp(
            r'class\s+PostAuthorRelationWhereFilter\s*\{[\s\S]*?final\s+bool\s+isNull;[\s\S]*?final\s+bool\s+isNotNull;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected to-one relation filter to support is:null and isNot:null.',
        );
      });

      test('generates typed self-relation include and relation filter surfaces', () async {
        final fixtureDir = _copyFixture(fixturesRoot, 'default_output');
        addTearDown(() => fixtureDir.deleteSync(recursive: true));

        final schemaFile = File(
          _path(<String>[fixtureDir.path, 'orm.schema.dart']),
        );
        schemaFile.writeAsStringSync('''
class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

class Relation {
  final Set<String>? fields;
  final Set<String>? references;
  final String? name;

  const Relation({this.fields, this.references, this.name});
}

@model
typedef User = ({
  String id,
  String email,
  String? invitedById,
  @Relation(fields: {'invitedById'}, references: {'id'})
  User? invitedBy,
  @Relation(references: {'invitedById'})
  List<User> invitedUsers
});
''');

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
          reason: 'Expected generated Dart files to assert self-relation DSL.',
        );

        final generatedSource = generatedDartFiles
            .map((file) => file.readAsStringSync())
            .join('\n');

        expect(
          generatedSource.contains('class UserInvitedUsersInclude'),
          isTrue,
          reason:
              'Expected self to-many include class to generate for invitedUsers.',
        );
        expect(
          generatedSource.contains('class UserInvitedByInclude'),
          isTrue,
          reason:
              'Expected self to-one include class to generate for invitedBy.',
        );
        expect(
          generatedSource.contains('includeInvitedUsers('),
          isTrue,
          reason: 'Expected typed helpers for self to-many include relation.',
        );
        expect(
          generatedSource.contains('includeInvitedBy('),
          isTrue,
          reason: 'Expected typed helpers for self to-one include relation.',
        );
        expect(
          generatedSource.contains(
            "static const UserDistinct invitedById = UserDistinct._('invitedById');",
          ),
          isTrue,
          reason:
              'Expected camelCase scalar identifiers to preserve field casing in generated constants.',
        );
        expect(
          RegExp(
            r'static\s+UserOrderBy\s+invitedById\(\{SortOrder\s+order\s*=\s*SortOrder\.asc\}\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected camelCase scalar identifiers to preserve field casing in generated orderBy helpers.',
        );
        expect(
          RegExp(
            r'class\s+UserWhereInput\s*\{[\s\S]*?final\s+StringWhereFilter\?\s+invitedById;[\s\S]*?final\s+UserInvitedByRelationWhereFilter\?\s+invitedBy;[\s\S]*?final\s+UserInvitedUsersRelationWhereFilter\?\s+invitedUsers;',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected self-relation where fields and camelCase scalar fields to remain typed.',
        );
      });

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
  List<String> generateArgs = const <String>[],
}) async {
  final args = <String>[entryPath, 'generate', ...generateArgs];
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

Future<_GenerateRun> _runContractEmit({
  required String entryPath,
  required String workingDirectory,
  List<String> emitArgs = const <String>[],
}) async {
  final args = <String>[entryPath, 'contract', 'emit', ...emitArgs];
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
