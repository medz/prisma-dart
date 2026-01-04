import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'src/analyzer/fixes/config_required_fix.dart';
import 'src/analyzer/fixes/config_required_replace_fix.dart';
import 'src/analyzer/rules/config_required_rule.dart';

class AnalysisPlugin extends Plugin {
  @override
  String get name => 'orm';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(ConfigRequiredRule());
    registry.registerFixForRule(ConfigRequiredRule.code, ConfigRequiredFix.new);
    registry.registerFixForRule(
      ConfigRequiredRule.code,
      ConfigRequiredReplaceFix.new,
    );
  }
}

final plugin = AnalysisPlugin();
