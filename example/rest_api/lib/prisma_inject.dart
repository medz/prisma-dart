import 'package:orm/logger.dart';
import 'package:spry/spry.dart';

import 'const.dart';
import 'prisma_client.dart';

class _PrismaInjector {
  PrismaClient? prisma;

  Future<void> call(Context context, Next next) async {
    context[#prisma] = prisma ??= PrismaClient(
      stdout: Event.values,
      datasources: Datasources(db: databaseUri),
    );

    return next();
  }
}

final Middleware prisma = _PrismaInjector();

extension PrismaContextExtension on Context {
  PrismaClient get prisma => this[#prisma] as PrismaClient;
}
