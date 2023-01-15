import 'package:orm/configure.dart';

/// Configure Prisma for production environment.
/// 
/// **NOTE**: The function name must be configurePrisma.
void configurePrisma(PrismaEnvironment environment) {
  environment['DATABASE_URL'] = r'postgres://postgres:postgres@localhost:5432/postgres?schema=public';
}
