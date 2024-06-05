import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dotenv/dotenv.dart' show DotEnv;

import '_env.shared.dart' as shared;

class _IOEnvironmentImpl implements shared.Environment {
  final shared.Environment env;
  final DotEnv dotenv;

  const _IOEnvironmentImpl(this.env, this.dotenv);

  @override
  void add(Map<String, String> other) => env.add(other);

  @override
  String? call(String name) => env(name) ?? dotenv[name];
}

shared.Environment createEnvironment() {
  final env = shared.createEnvironment();
  env.add(Platform.environment);

  final dotenv = DotEnv(includePlatformEnvironment: false, quiet: true);
  dotenv.load(_envFiles());

  return _IOEnvironmentImpl(env, dotenv);
}

Iterable<String> _envFiles() sync* {
  final dirs = [
    Directory.current.path,
    path.dirname(Platform.script.toFilePath(windows: Platform.isWindows)),
  ];
  for (final dir in dirs) {
    yield path.join(dir, '.env');
    yield path.join(dir, 'prisma', '.env');
  }
}
