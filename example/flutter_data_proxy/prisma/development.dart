import 'package:orm/configure.dart';

/// Prisma development environment configurator.
void configurator(PrismaDevelopment development) {
  development.override('DATABASE_URL',
      r'postgres://<User-Password>@ancient-bush-179952.us-east-2.aws.neon.tech/neondb');
  development.override('PRISMA_GENERATE_DATAPROXY', 'true');

  // You can override environment variable example:
  // development.override('DEBUG', 'true');

  // You can remove environment variable example:
  // development.remove('DEBUG');
}

/// Configure Prisma for development environment.
///
/// **NOTE**: Prisma development must is a executable.
///
/// The `main` function is a Dart executable file entrypoint.
void main() => PrismaDevelopment.server(configurator);
