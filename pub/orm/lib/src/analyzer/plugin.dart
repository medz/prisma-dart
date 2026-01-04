import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart' as asp;
import 'package:analysis_server_plugin/registry.dart';
import 'package:meta/meta.dart';

abstract class Plugin extends asp.Plugin {
  @override
  @nonVirtual
  String get name => 'orm';

  @override
  @mustCallSuper
  FutureOr<void> register(PluginRegistry registry) {}

  @override
  @mustCallSuper
  FutureOr<void> start() {}

  @override
  @mustCallSuper
  FutureOr<void> shutDown() {}
}
