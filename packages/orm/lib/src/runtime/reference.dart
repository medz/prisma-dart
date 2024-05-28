import 'prisma_enum.dart';

abstract interface class Reference<T> implements PrismaEnum {
  @override
  String get name;

  String get model;
}
