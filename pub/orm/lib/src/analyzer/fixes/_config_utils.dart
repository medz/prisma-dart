import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';

mixin ConfigUtils on ResolvedCorrectionProducer {
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

  ConfigVariableInfo? findConfigVariable(CompilationUnit unit) {
    for (final declaration in unit.declarations) {
      if (declaration is! TopLevelVariableDeclaration) {
        continue;
      }
      for (final variable in declaration.variables.variables) {
        if (variable.name.lexeme == 'config') {
          return .new(declaration, variable);
        }
      }
    }
    return null;
  }

  int configInsertOffset(CompilationUnit unit) {
    if (unit.directives.isEmpty) {
      return 0;
    }
    return utils.getLineNext(unit.directives.last.end);
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
    return utils.getLineNext(anchor.end);
  }

  String buildImportText(String eol) => "import 'package:orm/config.dart';$eol";

  String buildConfigText(String? prefix, String eol) {
    final qualifier = (prefix == null || prefix.isEmpty) ? '' : '$prefix.';
    final provider = qualifier.isEmpty
        ? '.sqlite'
        : '${qualifier}DatabaseProvider.sqlite';
    return [
      'const config = ${qualifier}Config(',
      '${utils.oneIndent}provider: $provider,',
      "${utils.oneIndent}output: '', // TODO: update output path",
      ');',
      '',
    ].join(eol);
  }
}

class ConfigVariableInfo {
  final TopLevelVariableDeclaration declaration;
  final VariableDeclaration variable;

  ConfigVariableInfo(this.declaration, this.variable);

  bool get isSingle => declaration.variables.variables.length == 1;
}
