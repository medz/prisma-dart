import 'dart:async';

import '../core/json_convertible.dart';
import '../protocol/deserialize_json_response.dart';
import '../protocol/model_action.dart';
import '../protocol/serialize_json_query.dart';
import '_internal/deep_merge_map.dart';
import 'context.dart';

class ActionClient<T, S> extends WithRuntimeContext
    implements Future<T>, JsonConvertible<Map<String, dynamic>?> {
  final ModelAction action;
  final Map<String, dynamic> _args;
  final bool isWrite;

  const ActionClient({
    required super.context,
    required this.action,
    this.isWrite = false,
    final Map<String, dynamic>? args,
  }) : _args = args ?? const {};

  @override
  Stream<T> asStream() => toFuture().asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      toFuture().catchError(onError, test: test);

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue,
          {Function? onError}) =>
      toFuture().then(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      toFuture().timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      toFuture().whenComplete(action);

  /// Convert ActionClient to a new Future instance.
  Future<T> toFuture() async {
    final query = serializeJsonQuery(
      modelName: context.modelName,
      action: action,
      datamodel: context.datamodel,
      clientVersion: context.clientVersion,
      errorFormat: context.errorFormat,
      args: toJson(),
    );

    final response = await context.engine.request(
      query,
      isWrite: isWrite,
      traceparent: context.traceparent,
      transaction: context.transaction,
    );

    return deserializeJsonResponse(response) as T;
  }

  @override
  Map<String, dynamic> toJson() => _args;
}

/// Deep merge args with key and create a new ActionClient instance.
extension<R, S, V> on ActionClient<R, S> {
  ActionClient<R, S> copyWithNamedArg(String name, V value) => ActionClient(
      context: context,
      action: action,
      isWrite: isWrite,
      args: _args.deepMerge({name: value}));
}

abstract interface class Select<T> {}

extension ActionClientSelect<R, T extends JsonConvertible, S extends Select<T>>
    on ActionClient<R, S> {
  /// Select specific fields to fetch from the [R]
  ActionClient<R, S> select(T select) =>
      copyWithNamedArg('select', select.toJson());
}

abstract interface class Include implements JsonConvertible {}

extension ActionClientInclude<R, S extends Include> on ActionClient<R, S> {
  /// Choose, which related nodes to fetch as well.
  ActionClient<R, S> include(S include) =>
      copyWithNamedArg('include', include.toJson());
}

abstract interface class Where<T> {}

extension ActionClientWhere<R, T extends JsonConvertible, S extends Where<T>>
    on ActionClient<R, S> {
  /// Filter, which [R] to fetch.
  ActionClient<R, S> where(T where) =>
      copyWithNamedArg('where', where.toJson());
}

abstract interface class OrderBy implements JsonConvertible {}

extension ActionClientOrderBy<R, S extends OrderBy> on ActionClient<R, S> {
  /// Determine the order of [R] to fetch.
  ActionClient<R, S> orderBy(S orderBy) =>
      copyWithNamedArg('orderBy', orderBy.toJson());
}

abstract interface class Cursor implements JsonConvertible {}

extension ActionClientCursor<R, S extends Cursor> on ActionClient<R, S> {
  /// Sets the position for searching for [R].
  ActionClient<R, S> cursor(S cursor) =>
      copyWithNamedArg('cursor', cursor.toJson());
}

abstract interface class Pagination {}

extension ActionClientPagination<R, S extends Pagination>
    on ActionClient<R, S> {
  /// Take `±n` [R] from the position of the cursor.
  ActionClient<R, S> take(int take) => copyWithNamedArg('take', take);

  /// Skip the first `n` [R].
  ActionClient<R, S> skip(int skip) => copyWithNamedArg('skip', skip);
}

abstract interface class Distinct implements JsonConvertible<String> {}

extension ActionClientDistinct<R, S extends Distinct> on ActionClient<R, S> {
  /// Select distinct [R] by a specific field.
  ActionClient<R, S> distinct(S distinct) =>
      copyWithNamedArg('distinct', distinct.toJson());
}
