import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

abstract class ConfigFix extends ResolvedCorrectionProducer {
  ConfigFix({required super.context});

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
    final provider = qualifier.isNotEmpty
        ? '${qualifier}DatabaseProvider.sqlite'
        : '.sqlite';
    return [
      'const config = ${qualifier}Config(',
      '${utils.oneIndent}$provider,',
      "${utils.oneIndent}output: '', // TODO: update output path",
      ');',
    ].join(eol);
  }

  Future<void> insertConfig(
    ChangeBuilder builder, {
    required int configDeclOffset,
  }) async {
    final eol = utils.endOfLine;
    final configImport = findConfigImport(unit);
    final prefix = configImport?.prefix?.name;
    final needsImport = configImport == null;

    final importOffset = importInsertOffset(unit);
    final configText = buildConfigText(prefix, eol);
    final importText = buildImportText(eol);

    await builder.addDartFileEdit(file, (builder) {
      if (needsImport && importOffset == configDeclOffset) {
        builder.addInsertion(importOffset, (builder) {
          builder.write(importText);
          builder.write(eol);
          builder.write(configText);
        });
        return;
      }

      if (needsImport) {
        builder.addInsertion(importOffset, (builder) {
          builder.write(importText);
        });
      }

      builder.addInsertion(configDeclOffset, (builder) {
        builder.write(configText);
      });
    });
  }

  Future<void> replaceConfig(
    ChangeBuilder builder, {
    required ConfigVariableInfo info,
  }) async {
    final eol = utils.endOfLine;
    final configImport = findConfigImport(unit);
    final prefix = configImport?.prefix?.name;
    final needsImport = configImport == null;

    final importOffset = importInsertOffset(unit);
    final configText = buildConfigText(prefix, eol);
    final importText = buildImportText(eol);

    final declaration = info.declaration;
    final replaceRange = SourceRange(declaration.offset, declaration.length);

    await builder.addDartFileEdit(file, (builder) {
      if (needsImport && importOffset == replaceRange.offset) {
        builder.addReplacement(replaceRange, (builder) {
          builder.write(importText);
          builder.write(eol);
          builder.write(configText);
        });
        return;
      }

      if (needsImport) {
        builder.addInsertion(importOffset, (builder) {
          builder.write(importText);
        });
      }

      builder.addReplacement(replaceRange, (builder) {
        builder.write(configText);
      });
    });
  }
}

class ConfigVariableInfo {
  final TopLevelVariableDeclaration declaration;
  final VariableDeclaration variable;

  ConfigVariableInfo(this.declaration, this.variable);

  bool get isSingle => declaration.variables.variables.length == 1;
}
