// ignore_for_file: non_constant_identifier_names

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;

enum Role implements _i1.PrismaEnum {
  user('user'),
  owner('owner');

  const Role(String value) : PRISMA_ENUM_VALUE = value;

  @override
  final String PRISMA_ENUM_VALUE;
}
