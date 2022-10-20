/// Prisma query engine type.
enum QueryEngineType {
  /// Binary engine.
  binary,

  /// Library engine.
  library;

  @override
  String toString() => name;

  /// Lookup the query engine type.
  static QueryEngineType lookup(String name) {
    return QueryEngineType.values.firstWhere(
      (e) => e.name.toLowerCase().trim() == name.toLowerCase().trim(),
      orElse: () => QueryEngineType.binary,
    );
  }
}
