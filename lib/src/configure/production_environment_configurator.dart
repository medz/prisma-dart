import 'dart:async';

import 'environment.dart';

/// Production environment configurator.
typedef ProductionEnvironmentConfigurator = FutureOr<void> Function(
    PrismaEnvironment environment);
