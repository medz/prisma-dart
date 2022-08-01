/// Prisma binary type.
enum BinaryType {
  queryEngine('query-engine'),
  migrationEngine('migration-engine'),
  introspectionEngine('introspection-engine'),
  prismaFmt('prisma-fmt'),
  ;

  final String value;
  const BinaryType(this.value);
}
