import 'dart:io';

import 'package:prisma_cli/prisma_cli.dart';

Future<void> main(List<String> args) async {
  final PrismaCLI cli = PrismaCLI();

  exitCode = await cli.run(args);
}
