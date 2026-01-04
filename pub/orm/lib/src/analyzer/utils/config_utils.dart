import 'package:analyzer/dart/ast/ast.dart';

ImportDirective? findConfigImport(CompilationUnit unit) {
  for (final directive in unit.directives) {
    if (directive is! ImportDirective) {
      continue;
    }
    final uri = directive.uri.stringValue;
    if (uri == 'package:orm/config.dart') {
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
        declaration.name.lexeme == 'Config') {
      return true;
    }
  }
  return false;
}

bool isConfigVariable(VariableDeclaration variable) {
  return variable.name.lexeme == 'config';
}

ConfigVariableInfo? findConfigVariable(CompilationUnit unit) {
  for (final declaration in unit.declarations) {
    if (declaration is! TopLevelVariableDeclaration) {
      continue;
    }
    for (final variable in declaration.variables.variables) {
      if (isConfigVariable(variable)) {
        return ConfigVariableInfo(declaration, variable);
      }
    }
  }
  return null;
}

int configInsertOffset(CompilationUnit unit) {
  if (unit.directives.isEmpty) {
    return 0;
  }
  return _nextLineOffset(unit, unit.directives.last.end);
}

int importInsertOffset(CompilationUnit unit) {
  ImportDirective? lastImport;
  LibraryDirective? libraryDirective;
  for (final directive in unit.directives) {
    if (directive is LibraryDirective) {
      libraryDirective = directive;
    } else if (directive is ImportDirective) {
      lastImport = directive;
    }
  }

  final anchor = lastImport ?? libraryDirective;
  if (anchor == null) {
    return 0;
  }
  return _nextLineOffset(unit, anchor.end);
}

String buildImportText(String eol) => "import 'package:orm/config.dart';$eol";

String buildConfigText(
  String? prefix,
  String eol, {
  required String indent,
}) {
  final qualifier = (prefix == null || prefix.isEmpty) ? '' : '$prefix.';
  final provider =
      qualifier.isEmpty ? '.sqlite' : '${qualifier}DatabaseProvider.sqlite';
  return [
    'const config = $qualifier' 'Config(',
    '${indent}provider: $provider,',
    "${indent}output: '', // TODO: update output path",
    ');',
    '',
  ].join(eol);
}

int _nextLineOffset(CompilationUnit unit, int offset) {
  final lineInfo = unit.lineInfo;
  final lineNumber = lineInfo.getLocation(offset).lineNumber;
  if (lineNumber >= lineInfo.lineCount) {
    return unit.end;
  }
  return lineInfo.getOffsetOfLine(lineNumber);
}

class ConfigVariableInfo {
  final TopLevelVariableDeclaration declaration;
  final VariableDeclaration variable;

  ConfigVariableInfo(this.declaration, this.variable);

  bool get isSingle => declaration.variables.variables.length == 1;
}
