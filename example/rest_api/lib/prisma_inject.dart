import 'package:spry/spry.dart';

import 'prisma_client.dart';

class _PrismaInjector {
  PrismaClient? prisma;

  Future<void> call(Context context, MiddlewareNext next) async {
    context[#prisma] = prisma ??= PrismaClient();

    return next();
  }
}

final Middleware prisma = _PrismaInjector();

extension PrismaContextExtension on Context {
  PrismaClient get prisma => this[#prisma] as PrismaClient;
}
