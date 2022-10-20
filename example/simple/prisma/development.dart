import 'package:orm/configure.dart';

/// Prisma development environment configurator.
void configurator(PrismaDevelopment development) {
  development.override('DATABASE_URL', 'file:./db.sqlite');

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
