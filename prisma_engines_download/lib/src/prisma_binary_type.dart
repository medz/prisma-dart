enum PrismaBinaryType {
  queryEngine('query-engine'),
  migrationEngine('migration-engine'),
  introspectionEngine('introspection-engine'),
  prismaFmt('prisma-fmt'),
  ;

  final String value;

  const PrismaBinaryType(this.value);
}
