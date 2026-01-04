import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import '../utils/analyzer_constants.dart';
import '../utils/config_ast_utils.dart';

class ConfigRequiredRule extends AnalysisRule {
  static const LintCode code = LintCode(
    configRequiredRuleName,
    "Missing required '$configFixSnippet' in $ormConfigFileName.",
    correctionMessage:
        "Add a top-level '$configFixSnippet' to $ormConfigFileName.",
    severity: DiagnosticSeverity.ERROR,
  );

  ConfigRequiredRule()
    : super(
        name: configRequiredRuleName,
        description:
            'Ensures orm.config.dart defines a top-level const Config.',
      );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addCompilationUnit(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final AnalysisRule rule;
  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final currentUnit = context.currentUnit;
    final packageRoot = context.package?.root;
    if (currentUnit == null || packageRoot == null) {
      return;
    }

    final configFile = packageRoot.getChildAssumingFile(ormConfigFileName);
    if (currentUnit.file.path != configFile.path) {
      return;
    }

    if (!_hasRequiredConfig(node)) {
      rule.reportAtNode(node);
    }
  }

  bool _hasRequiredConfig(CompilationUnit unit) {
    final configImport = findOrmConfigImport(unit);
    final hasLocalConfig = hasLocalConfigDeclaration(unit);
    for (final declaration in unit.declarations) {
      if (declaration is! TopLevelVariableDeclaration) {
        continue;
      }

      final variables = declaration.variables;
      if (!variables.isConst) {
        continue;
      }

      for (final variable in variables.variables) {
        if (!isConfigVariable(variable)) {
          continue;
        }

        final initializer = variable.initializer;
        if (initializer is InstanceCreationExpression &&
            _isOrmConfigInitializer(
              initializer,
              configImport,
              hasLocalConfig,
            )) {
          return true;
        }
      }
    }
    return false;
  }

  bool _isOrmConfigInitializer(
    InstanceCreationExpression initializer,
    ImportDirective? configImport,
    bool hasLocalConfig,
  ) {
    if (initializer.constructorName.type.name.lexeme != configClassName) {
      return false;
    }

    final ctorElement = initializer.constructorName.element;
    final classElement = ctorElement?.enclosingElement;
    final library = classElement?.library;
    final libraryUri = library?.firstFragment.source.uri;
    if (libraryUri != null) {
      return libraryUri.toString() == ormConfigImportUri;
    }

    if (configImport == null) {
      return false;
    }

    final importPrefix = configImport.prefix?.name;
    final usagePrefix =
        initializer.constructorName.type.importPrefix?.name.lexeme;

    if (importPrefix != null) {
      return usagePrefix == importPrefix;
    }

    if (usagePrefix != null) {
      return false;
    }

    return !hasLocalConfig;
  }
}
