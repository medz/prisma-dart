import 'package:args/command_runner.dart';

/// The Prisma CLI executable name.
const String _executableName = r'dart run orm';

/// Prisma CLI description.
const String _description =
    ' ◭ Prisma CLI 🚀\nPrisma is a modern DB toolkit to query, migrate and model your database.\n More info: https://github.com/odroe/prisma';

/// Prisma CLI
class PrismaCLI {
  late final CommandRunner<int> _runner;

  /// Create a new Prisma CLI instance.
  PrismaCLI() {
    _runner = CommandRunner<int>(_executableName, _description);
  }

  /// Run Prisma CLI.
  Future<int> run(List<String> args) async => (await _runner.run(args)) ?? 0;
}
