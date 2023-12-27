import 'dart:async';

import '../../dmmf/ast/datamodel.dart' show DataModel;
import '../json_protocol/protocol.dart';

/// Model from JSON factory.
typedef ModelFactory<T, R> = R Function(T data);

/// Prisma CRUD action.
///
/// - [U]: The unserialized data type.
/// - [T]: The serialized data type.
/// - [O]: The action options
class Action<U, T, O> implements Future<T> {
  /// The factory of the model
  final ModelFactory<U, T> factory;

  /// Action arguments
  final Map<String, dynamic> arguments;

  /// The schema data model.
  final DataModel datamodel;

  /// The action type
  final JsonQueryAction action;

  /// The action owner model name.
  final String? model;

  /// Create a new action.
  const Action({
    required this.factory,
    required this.datamodel,
    required this.action,
    this.model,
    this.arguments = const {},
  });

  /// Returns the action unserialized data.
  Future<U> unserialized() {
    throw UnimplementedError();
  }

  @override
  Stream<T> asStream() async* {
    final value = await unserialized();
    final result = factory(value);

    yield result;
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    return unserialized().catchError(onError, test: test).then(factory);
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function? onError}) {
    return unserialized()
        .then(factory, onError: onError)
        .then(onValue, onError: onError);
  }

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) {
    return unserialized().whenComplete(action).then(factory);
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    return unserialized()
        .then(factory)
        .timeout(timeLimit, onTimeout: onTimeout);
  }
}
