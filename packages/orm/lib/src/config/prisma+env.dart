// ignore_for_file: file_names

import 'package:rc/rc.dart';

import '../prisma_namespace.dart';
import 'prisma+config.dart';

extension Prisma$Environment on PrismaNamespace {
  bool get _skipDotiableKeys => envAsBoolean('prisma.env.skip_dotiable_keys');

  /// Returns environment KV parts.
  Map<String, String> get environment =>
      config.toEnvironmentMap(skipDotiableKeys: _skipDotiableKeys);

  /// Returns a environment value by [name].
  String? env(String name) => config.env(name);

  /// Returns bool env value.
  bool envAsBoolean(String name) {
    final value = config(name);
    return switch (value) {
      true || "on" || "true" || 1 || "1" => true,
      _ => false,
    };
  }
}
