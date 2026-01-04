import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '../utils/analyzer_constants.dart';
import '../utils/config_utils.dart';

class ConfigRequiredReplaceFix extends ResolvedCorrectionProducer
    with ConfigUtils {
  static const FixKind _kind = FixKind(
    configFixIdRequiredReplace,
    DartFixKindPriority.standard,
    configFixMessageReplace,
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
