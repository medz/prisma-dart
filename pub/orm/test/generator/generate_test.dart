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
          generatedSource.contains("_context.model('CliOnlyUser')"),
          isTrue,
          reason: 'Expected CLI schema model in generated output.',
        );
        expect(
          generatedSource.contains("_context.model('ConfigOnlyUser')"),
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
        final relations = (user as Map<Object?, Object?>)['relations'];
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
            r'class\s+GeneratedOrmClient\s*\{[\s\S]*?late\s+final\s+GeneratedOrmDb\s+db\s*=\s*GeneratedOrmDb\(_context\);',
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
            r'class\s+GeneratedOrmDb\s*\{[\s\S]*?late\s+final\s+GeneratedOrmCollections\s+orm\s*=\s*GeneratedOrmCollections\(_context\);[\s\S]*?late\s+final\s+GeneratedOrmSql\s+sql\s*=\s*GeneratedOrmSql\(_context\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected GeneratedOrmDb to expose db.orm and db.sql namespaces.',
        );
        expect(
          RegExp(
            r'class\s+GeneratedOrmSql\s*\{[\s\S]*?late\s+final\s+OrmSqlApi\s+_api\s*=\s*_context\.sql;[\s\S]*?UserSql\s+user\s*=',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected GeneratedOrmSql to expose typed model sql delegates.',
        );
        expect(
          RegExp(
            r'class\s+GeneratedOrmCollections\s*\{[\s\S]*?_context\.model\(',
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
            r'\bFuture<List<UserData>>\s+all\s*\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.all() in generated source.',
        );
        expect(
          RegExp(
            r'\bFuture<UserData\?>\s+first\s*\(\s*\)',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserQuery.first() in generated source.',
        );
        expect(
          RegExp(r'\bclass UserSql\b').hasMatch(generatedSource),
          isTrue,
          reason: 'Expected generated source to include typed UserSql class.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?OrmSqlSelectBuilder\s+selectPlan\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose selectPlan builder.',
        );
        expect(
          RegExp(
            r'class\s+UserSql\s*\{[\s\S]*?Future<List<UserData>>\s+query\(',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected UserSql to expose typed query helper.',
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
            r'Future<UserData\?>\s+findUnique\(\{\s*required\s+UserWhereUniqueInput\s+where,',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected findUnique where parameter to use UserWhereUniqueInput.',
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
            r'Future<List<UserData>>\s+findMany\(\{\s*UserWhereInput\s+where\s*=\s*const\s+UserWhereInput\(\),',
          ).hasMatch(generatedSource),
          isTrue,
          reason: 'Expected non-unique findMany to keep UserWhereInput.',
        );
        expect(
          RegExp(
            r'Future<List<UserData>>\s+findMany\(\{[\s\S]*?List<UserDistinct>\s+distinct\s*=\s*const\s+<UserDistinct>\[\],',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected findMany to expose typed distinct parameter in generated delegate.',
        );
        expect(
          RegExp(
            r'Future<UserData\?>\s+findFirst\(\{[\s\S]*?List<UserDistinct>\s+distinct\s*=\s*const\s+<UserDistinct>\[\],',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected findFirst to expose typed distinct parameter in generated delegate.',
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
            r'class\s+UserQuery\s*\{[\s\S]*?UserQuery\s+distinct\(List<UserDistinct>\s+distinct\)',
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
            r'class\s+UserDelegate\s*\{[\s\S]*?final\s+runtimeHaving\s*=\s*typedHaving\.toJson\(\);',
          ).hasMatch(generatedSource),
          isTrue,
          reason:
              'Expected UserDelegate.groupBy(...) to resolve runtime having from typedHaving only.',
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
