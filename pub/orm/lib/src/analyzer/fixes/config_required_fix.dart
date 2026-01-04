import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '_config_utils.dart';

class ConfigRequiredFix extends ResolvedCorrectionProducer with ConfigUtils {
  static const _kind = FixKind(
    'orm.fix.config_required',
    DartFixKindPriority.standard,
    "Define ORM config: const config = Config(...)",
  );

  ConfigRequiredFix({required super.context});

  @override
  CorrectionApplicability get applicability => .singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (findConfigVariable(unit) != null) {
      return;
    }

    await _insertConfig(builder);
  }

  Future<void> _insertConfig(ChangeBuilder builder) async {
    final eol = utils.endOfLine;
    final configImport = findConfigImport(unit);
    final prefix = configImport?.prefix?.name;
    final needsImport = configImport == null;

    final importOffset = importInsertOffset(unit);
    final configDeclOffset = configInsertOffset(unit);
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
}
