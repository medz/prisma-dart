/// Prisma binary engine type.
enum BinaryEngineType {
  query('query-engine'),
  migration('migration-engine'),
  introspection('introspection-engine'),
  format('prisma-fmt'),
  ;

  final String value;
  const BinaryEngineType(this.value);
}
