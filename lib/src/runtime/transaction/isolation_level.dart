import '../prisma_enum.dart';

enum TransactionIsolationLevel implements PrismaEnum {
  readUncommitted("ReadUncommitted"),
  readCommitted("ReadCommitted"),
  repeatableRead("RepeatableRead"),
  snapshot("Snapshot"),
  serializable("Serializable");

  @override
  final String name;

  const TransactionIsolationLevel(this.name);
}
