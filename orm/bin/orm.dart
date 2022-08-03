import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:prisma_cli/prisma_cli.dart';

void main(List<String> args) async {
  final PrismaCLI cli = PrismaCLI();

  exitCode = await cli.run(args);
}
