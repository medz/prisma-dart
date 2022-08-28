/// Prisma binary engine type.
enum BinaryEngineType {
  query('query-engine'),
  migration('migration-engine'),
  format('prisma-fmt'),
  ;

  final String value;
  const BinaryEngineType(this.value);
}
