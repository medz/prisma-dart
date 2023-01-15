import 'package:spry/spry.dart';

import 'prisma_client.dart';

class _PrismaInjector {
  PrismaClient? prisma;

  Future<void> call(Context context, Next next) async {
    context[#prisma] = prisma ??= createPrismaClient();

    return next();
  }
}

final Middleware prisma = _PrismaInjector();

extension PrismaContextExtension on Context {
  PrismaClient get prisma => this[#prisma] as PrismaClient;
}
