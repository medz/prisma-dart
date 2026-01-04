import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

import 'analyzer_constants.dart';
import 'config_ast_utils.dart';

mixin ConfigUtils on ResolvedCorrectionProducer {
  ImportDirective? findConfigImport(CompilationUnit unit) {
    return findOrmConfigImport(unit);
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

  String buildImportText(String eol) => "import '$ormConfigImportUri';$eol";

  String buildConfigText(String? prefix, String eol) {
    final qualifier = (prefix == null || prefix.isEmpty) ? '' : '$prefix.';
    final provider = qualifier.isEmpty
        ? '.sqlite'
        : '${qualifier}DatabaseProvider.sqlite';
    return [
      'const $configVariableName = $qualifier$configClassName(',
      '${utils.oneIndent}provider: $provider,',
      "${utils.oneIndent}output: '', // TODO: update output path",
      ');',
      '',
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
