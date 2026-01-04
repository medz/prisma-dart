import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '../utils/analyzer_constants.dart';
import '../utils/config_utils.dart';

class ConfigRequiredFix extends ResolvedCorrectionProducer with ConfigUtils {
  static const FixKind _kind = FixKind(
    configFixIdRequired,
    DartFixKindPriority.standard,
    configFixMessageDefine,
  );

  ConfigRequiredFix({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (findConfigVariable(unit) != null) {
      return;
    }

    await insertConfig(builder, configDeclOffset: configInsertOffset(unit));
  }
}
