import 'package:orm/configure.dart';

/// Configure Prisma for production environment.
///
/// **NOTE**: The function name must be configurePrisma.
void configurePrisma(PrismaEnvironment environment) {
  environment['DATABASE_URL'] =
      r'prisma://aws-us-east-1.prisma-data.com/?api_key=<You api key>';
}
