/// Prisma JSON protocol model action.
enum ModelAction {
  /// Find unique.
  findUnique('findUnique'),

  /// Find Unique or throw.
  findUniqueOrThrow('findUniqueOrThrow'),

  /// Find first.
  findFirst('findFirst'),

  /// find first or throw.
  findFirstOrThrow('findFirstOrThrow'),

  /// Find many.
  findMany('findMany'),

  /// Count.
  count('aggregate'),

  /// Create.
  create('createOne'),

  /// Create many.
  createMany('createMany'),

  /// Update.
  update('updateOne'),

  /// Update many.
  updateMany('updateMany'),

  /// Upsert.
  upsert('upsertOne'),

  /// Delete.
  delete('deleteOne'),

  /// Delete many.
  deleteMany('deleteMany'),

  /// Execute raw.
  executeRaw('executeRaw'),

  /// Query raw.
  queryRaw('queryRaw'),

  /// Aggregate.
  aggregate('aggregate'),

  /// Group by.
  groupBy('groupBy'),

  /// Run command raw.
  runCommandRaw('runCommandRaw'),

  /// Find raw.
  findRaw('findRaw'),

  /// Aggregate raw.
  aggregateRaw('aggregateRaw'),

  //------------------------------------------------------------
  // for beauty
  ;
  //------------------------------------------------------------

  /// Creates a new [ModelAction] static instance.
  const ModelAction(this.value);

  /// The action value.
  final String value;

  /// Returns the [ModelAction] from the [value] of enum name.
  static ModelAction from(String name) {
    return ModelAction.values.firstWhere((element) => element.name == name);
  }
}
