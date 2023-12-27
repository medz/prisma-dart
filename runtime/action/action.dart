import 'dart:async';

/// Model from JSON factory.
typedef ModelFactory<T, R> = R Function(T data);

/// Model CURD action.
///
/// - [Unserialized]: The result of the action is not serialized data type.
/// - [Model]: The result of the action serialized to model type.
/// - [Where]: Automatically generate a where builder, If type set to [Null]
///   then the where builder will be disabled.
class Action<

    /// Unserialized data type
    Unserialized,

    /// Model data type
    Model,

    /// Where builder type, If type set to [Null] then the where builder will be
    /// disabled, Otherwise the [Where] is extends from [Input] class enable
    /// where builder.
    Where,

    /// Order by builder type, If type set to [Null] then the order by builder
    /// will be disabled, Otherwise the [OrderBy] is extends from [Input] class
    /// enable order by builder.
    OrderBy,

    /// cursor builder type, If type set to [Null] then the cursor builder
    /// will be disabled, Otherwise the [Cursor] is extends from [Input] class
    /// enable cursor builder.
    Cursor,

    /// Pagination builder type, If type set to [Null] then the pagination
    /// builder will be disabled, Otherwise the [Pagination] set to [bool]
    /// enable pagination builder.
    Pagination,

    /// distinct
    Distinct,

    /// having
    Having
    //------------------------- Divider -------------------------//
    > implements Future<Model> {
  /// The factory of the model
  final ModelFactory<Unserialized, Model> factory;

  /// Action arguments
  final Map<String, dynamic> arguments;

  /// Create a new action.
  const Action({
    required this.factory,
    this.arguments = const {},
  });

  /// Returns the action unserialized data.
  Future<Unserialized> unserialized() {
    throw UnimplementedError();
  }

  @override
  Stream<Model> asStream() async* {
    final value = await unserialized();
    final result = factory(value);

    yield result;
  }

  @override
  Future<Model> catchError(Function onError,
      {bool Function(Object error)? test}) {
    return unserialized().catchError(onError, test: test).then(factory);
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(Model value) onValue,
      {Function? onError}) {
    return unserialized()
        .then(factory, onError: onError)
        .then(onValue, onError: onError);
  }

  @override
  Future<Model> whenComplete(FutureOr<void> Function() action) {
    return unserialized().whenComplete(action).then(factory);
  }

  @override
  Future<Model> timeout(Duration timeLimit,
      {FutureOr<Model> Function()? onTimeout}) {
    return unserialized()
        .then(factory)
        .timeout(timeLimit, onTimeout: onTimeout);
  }
}
