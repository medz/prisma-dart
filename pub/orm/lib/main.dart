import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

class AnalysisPlugin extends Plugin {
  @override
  String get name => 'orm';

  @override
  Future<void> register(PluginRegistry registry) async {
    // TODO: implement register
  }
}

final plugin = AnalysisPlugin();
