import 'dart:async';

import '../../core/json_convertible.dart';
import '../../protocol/deserialize_json_response.dart';
import '../../protocol/model_action.dart';
import '../../protocol/serialize_json_query.dart';
import '../context.dart';

class ActionClient<T> extends WithRuntimeContext
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
  Map<String, dynamic>? toJson() => _args.isEmpty ? null : _args;

  Map<String, dynamic> toJsonWithMerge(String name, JsonConvertible value) {
    final result = switch (value.toJson()) {
      Map value => {...?_args[name], ...value},
      Iterable value => [...?_args[name], ...value],
      _ => value.toJson(),
    };

    return {..._args, name: result};
  }
}
