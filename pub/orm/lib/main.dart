import 'dart:async';

import 'package:analysis_server_plugin/registry.dart';
import 'package:orm/src/schema/analyzer/plugin.dart';

import 'src/analyzer/plugin.dart';

mixin A on Plugin {
  @override
  Future<void> register(PluginRegistry registry) async {
    await super.register(registry);
  }
}

class AnalysisPlugin extends Plugin with SchemaAnalyzerPlugin, A {
  @override
  Future<void> register(PluginRegistry registry) async {
    await super.register(registry);
    // TODO: implement register
  }
}

final plugin = AnalysisPlugin();
