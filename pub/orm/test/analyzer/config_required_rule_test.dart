// ignore_for_file: non_constant_identifier_names

import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:orm/src/analyzer/rules/config_required_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@reflectiveTest
class ConfigRequiredRuleTest extends AnalysisRuleTest {
  @override
  String get analysisRule => 'orm_config_required';

  @override
  void setUp() {
    Registry.ruleRegistry.registerWarningRule(ConfigRequiredRule());
    super.setUp();
    newPubspecYamlFile(testPackageRootPath, 'name: orm\n');
    newFile(join(testPackageRootPath, 'lib', 'config.dart'), r'''
enum DatabaseProvider { sqlite }

class Config {
  final DatabaseProvider provider;
  final String output;

  const Config({required this.provider, required this.output});
}
''');
  }

  Future<void> _assertMissingConfig(String content) async {
    final path = join(testPackageRootPath, 'orm.config.dart');
    newFile(path, content);
    await assertDiagnosticsInFile(path, [lint(0, content.length)]);
  }

  Future<void> _assertValidConfig(String content) async {
    final path = join(testPackageRootPath, 'orm.config.dart');
    newFile(path, content);
    await assertNoDiagnosticsInFile(path);
  }

  void test_missingConfig() async {
    await _assertMissingConfig(r'''
import 'package:orm/config.dart';
''');
  }

  void test_validConfig() async {
    await _assertValidConfig(r'''
import 'package:orm/config.dart';

const config = Config(
  provider: DatabaseProvider.sqlite,
  output: '',
);
''');
  }

  void test_prefixedImport() async {
    await _assertValidConfig(r'''
import 'package:orm/config.dart' as orm;

const config = orm.Config(
  provider: orm.DatabaseProvider.sqlite,
  output: '',
);
''');
  }

  void test_localConfigClass() async {
    await _assertMissingConfig(r'''
class Config {
  const Config();
}

const config = Config();
''');
  }

  void test_notConst() async {
    await _assertMissingConfig(r'''
import 'package:orm/config.dart';

final config = Config(
  provider: DatabaseProvider.sqlite,
  output: '',
);
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ConfigRequiredRuleTest);
  });
}
