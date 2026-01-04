import 'package:analysis_server_plugin/registry.dart';

import '../../analyzer/plugin.dart';

mixin SchemaAnalyzerPlugin on Plugin {
  @override
  Future<void> register(PluginRegistry registry) async {
    await super.register(registry);
    // TODO: implement register
  }
}
