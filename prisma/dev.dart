import 'package:orm/configure.dart';

void main() {
  final DevelopmentEnvironmentPrinter printer = DevelopmentEnvironmentPrinter();

  printer.prisma(PrismaEnvironment.NO_COLOR, 111);
  printer.other('key', 'value');
  printer.prisma(PrismaEnvironment.PRISMA_CLIENT_ENGINE_TYPE, 222);
}
