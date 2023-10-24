import 'prisma_enum.dart';

base class NullTypes extends PrismaEnum {
  const NullTypes(super.value);
}

final class DbNull extends NullTypes {
  const DbNull() : super('DbNull');
}

final class JsonNull extends NullTypes {
  const JsonNull() : super('JsonNull');
}

final class AnyNull extends NullTypes {
  const AnyNull() : super('AnyNull');
}
