import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '_config_utils.dart';

class ConfigRequiredReplaceFix extends ResolvedCorrectionProducer
    with ConfigUtils {
  static const _kind = FixKind(
    'orm.fix.config_required_replace',
    DartFixKindPriority.standard,
    "Replace ORM config: const config = Config(...)",
  );

  ConfigRequiredReplaceFix({required super.context});

  @override
  CorrectionApplicability get applicability => .singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final info = findConfigVariable(unit);
    if (info == null) {
      return;
    }

    if (!info.isSingle || info.declaration.metadata.isNotEmpty) {
      return;
    }

    await _replaceConfig(builder, info: info);
  }

  Future<void> _replaceConfig(
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
