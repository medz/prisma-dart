import 'package:analyzer/dart/ast/ast.dart';

import 'analyzer_constants.dart';

ImportDirective? findOrmConfigImport(CompilationUnit unit) {
  for (final directive in unit.directives) {
    if (directive is! ImportDirective) {
      continue;
    }
    final uri = directive.uri.stringValue;
    if (uri == ormConfigImportUri) {
      return directive;
    }
  }
  return null;
}

bool hasLocalConfigDeclaration(CompilationUnit unit) {
  for (final declaration in unit.declarations) {
    if (declaration is FunctionDeclaration) {
      continue;
    }
    if (declaration is NamedCompilationUnitMember &&
        declaration.name.lexeme == configClassName) {
      return true;
    }
  }
  return false;
}

bool isConfigVariable(VariableDeclaration variable) {
  return variable.name.lexeme == configVariableName;
}
