import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '_config_fix.dart';

class ConfigRequiredReplaceFix extends ConfigFix {
  static const FixKind _kind = FixKind(
    'orm.fix.config_required_replace',
    DartFixKindPriority.standard,
    "Replace ORM config: const config = Config(...)",
  );

  ConfigRequiredReplaceFix({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

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

    await replaceConfig(builder, info: info);
  }
}
