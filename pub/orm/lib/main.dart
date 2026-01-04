import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'src/analyzer/fixes/relation_reference_fix.dart';
import 'src/analyzer/rules/relation_references_rule.dart';

class AnalysisServerPlugin extends Plugin {
  @override
  String get name => 'orm';

  @override
  Future<void> register(PluginRegistry registry) async {
    registry.registerWarningRule(RelationReferencesRule());
    for (var i = 0; i < maxRelationReferenceFixes; i++) {
      registry.registerFixForRule(
        RelationReferencesRule.unknownField,
        ({required context}) =>
            ReplaceWithRelationReferenceFix(
              context: context,
              candidateIndex: i,
            ),
      );
    }
  }
}

final plugin = AnalysisServerPlugin();
