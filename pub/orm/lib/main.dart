import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

class AnalysisServerPlugin extends Plugin {
  @override
  String get name => 'orm';

  @override
  Future<void> register(PluginRegistry registry) async {}
}

final plugin = AnalysisServerPlugin();
