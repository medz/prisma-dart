// Create a [RuntimeConfiguration] with dotenv.
import 'dart:io';

import 'package:rc/rc.dart';

import '../environment.dart';
import '../configure.dart' as internal;
import 'finder.dart';

/// Create a [RuntimeConfiguration] with `prismarc` and `dotenv`.
RuntimeConfiguration get _prismarc {
  /// Create a [RuntimeConfiguration] with `dotenv`.
  final RuntimeConfiguration dotenv =
      prismaConifgurationResult.dotenv?.isNotEmpty == true
          ? RuntimeConfiguration.from(
              prismaConifgurationResult.dotenv!,
              includeEnvironment: true,
            )
          : RuntimeConfiguration(contents: "");

  /// Create a [RuntimeConfiguration] with `prismarc`.
  final RuntimeConfiguration prismarc =
      prismaConifgurationResult.prismarc?.isNotEmpty == true
          ? RuntimeConfiguration.from(
              prismaConifgurationResult.prismarc!,
              includeEnvironment: true,
            )
          : RuntimeConfiguration(contents: "");

  /// Create a [RuntimeConfiguration] container
  final RuntimeConfiguration container = RuntimeConfiguration(
    contents: "",
    environment: Platform.environment,
  );

  // Merge [dotenv] to [container].
  for (final MapEntry<String, dynamic> item in dotenv.all.entries) {
    container.context.configuration[item.key] = item.value;
  }

  // Merge [prismarc] to [container].
  for (final MapEntry<String, dynamic> item in prismarc.all.entries) {
    container.context.configuration[item.key] = item.value;
  }

  return container;
}

/// Create a new [Environment] from [RuntimeConfiguration].
final Environment environment = Environment(_prismarc);

/// Prisma schema path
String get schema => prismaConifgurationResult.schema ?? internal.schema;
