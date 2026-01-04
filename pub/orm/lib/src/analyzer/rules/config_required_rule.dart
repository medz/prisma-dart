import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

class ConfigRequiredRule extends AnalysisRule {
  static const LintCode code = LintCode(
    'orm_config_required',
    "Missing required 'const config = Config(...);' in orm.config.dart.",
    correctionMessage:
        "Add a top-level 'const config = Config(...);' to orm.config.dart.",
  );

  ConfigRequiredRule()
    : super(
        name: 'orm_config_required',
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

    final configFile = packageRoot.getChildAssumingFile('orm.config.dart');
    if (currentUnit.file.path != configFile.path) {
      return;
    }

    if (!_hasRequiredConfig(node)) {
      rule.reportAtNode(node);
    }
  }

  bool _hasRequiredConfig(CompilationUnit unit) {
    for (final declaration in unit.declarations) {
      if (declaration is! TopLevelVariableDeclaration) {
        continue;
      }

      final variables = declaration.variables;
      if (!variables.isConst) {
        continue;
      }

      for (final variable in variables.variables) {
        if (variable.name.lexeme != 'config') {
          continue;
        }

        final initializer = variable.initializer;
        if (initializer is InstanceCreationExpression &&
            initializer.constructorName.type.name.lexeme == 'Config') {
          return true;
        }
      }
    }
    return false;
  }
}
