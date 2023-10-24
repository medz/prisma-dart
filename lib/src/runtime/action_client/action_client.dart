import 'dart:async';

import '../../core/json_convertible.dart';
import '../context.dart';

abstract class ActionClient<T> extends WithRuntimeContext
    implements Future<T>, JsonConvertible<Map?> {
  const ActionClient(super.context);

  @override
  Stream<T> asStream() {
    // TODO: implement asStream
    throw UnimplementedError();
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    // TODO: implement catchError
    throw UnimplementedError();
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function? onError}) {
    // TODO: implement then
    throw UnimplementedError();
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) {
    // TODO: implement whenComplete
    throw UnimplementedError();
  }

  /// Convert ActionClient to a new Future instance.
  Future<T> toFuture();
}
