import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

class ConfigRequiredFix extends ResolvedCorrectionProducer {
  static const FixKind _kind = FixKind(
    'orm.fix.config_required',
    DartFixKindPriority.standard,
    "Define ORM config: const config = Config(...)",
  );

  ConfigRequiredFix({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (_hasConfigVariable(unit)) {
      return;
    }

    final eol = utils.endOfLine;
    final configImport = _findConfigImport(unit);
    final prefix = configImport?.prefix?.name;
    final needsImport = configImport == null;

    final configInsertOffset = _configInsertOffset(unit);
    final importInsertOffset = _importInsertOffset(unit);
    final configText = _buildConfigText(prefix, eol);
    final importText = _buildImportText(eol);

    await builder.addDartFileEdit(file, (builder) {
      if (needsImport && importInsertOffset == configInsertOffset) {
        builder.addInsertion(importInsertOffset, (builder) {
          builder.write(importText);
          builder.write(eol);
          builder.write(configText);
        });
        return;
      }

      if (needsImport) {
        builder.addInsertion(importInsertOffset, (builder) {
          builder.write(importText);
        });
      }

      builder.addInsertion(configInsertOffset, (builder) {
        if (configInsertOffset != 0 && needsImport == false) {
          builder.write(eol);
        }
        builder.write(configText);
      });
    });
  }

  ImportDirective? _findConfigImport(CompilationUnit unit) {
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

  bool _hasConfigVariable(CompilationUnit unit) {
    for (final declaration in unit.declarations) {
      if (declaration is! TopLevelVariableDeclaration) {
        continue;
      }
      for (final variable in declaration.variables.variables) {
        if (variable.name.lexeme == 'config') {
          return true;
        }
      }
    }
    return false;
  }

  int _configInsertOffset(CompilationUnit unit) {
    if (unit.directives.isEmpty) {
      return 0;
    }
    return utils.getLineNext(unit.directives.last.end);
  }

  int _importInsertOffset(CompilationUnit unit) {
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

  String _buildImportText(String eol) =>
      "import 'package:orm/config.dart';$eol";

  String _buildConfigText(String? prefix, String eol) {
    final qualifier = (prefix == null || prefix.isEmpty) ? '' : '$prefix.';
    return [
      'const config = ${qualifier}Config(',
      '${utils.oneIndent}provider: $qualifier${qualifier.isNotEmpty ? 'DatabaseProvider' : ''}.sqlite,',
      "${utils.oneIndent}output: '', // TODO: update output path",
      ');',
      '',
    ].join(eol);
  }
}
